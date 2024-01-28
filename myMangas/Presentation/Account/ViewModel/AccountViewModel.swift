//
//  AccountViewModel.swift
//  myMangas
//
//  Created by epena on 13/1/24.
//

import Foundation
import Combine

final class AccountViewModel: ObservableObject {
    private var network: DataInteractor
    private let keychainHelper: KeychainHelper
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var loading: Bool = false
    @Published var registrationError: String? = nil
    @Published var loginError: String? = nil
    @Published var loginSuccess: Bool = false

    init(network: DataInteractor = Network(), keychainHelper: KeychainHelper = KeychainHelper()) {
        self.network = network
        self.keychainHelper = keychainHelper
        
        Task { [weak self] in
            await self?.renew()
        }
    }

    func register(email: String, password: String) async {
        guard isValidEmailFormat(email), password.count >= 8 else {
            await MainActor.run { [weak self] in self?.registrationError = "Invalid email or password" }
            return
        }
        await MainActor.run { [weak self] in self?.loading = true }
        do {
            try await network.register(credentials: UserCredentials(email: email, password: password))
            await login(email: email, password: password)
        } catch {
            await MainActor.run { [weak self] in
                self?.registrationError = "There was a problem with the registration, it may already be registered"
            }
        }
        await MainActor.run { [weak self] in self?.loading = false }
    }

    func login(email: String, password: String) async {
        guard isValidEmailFormat(email), password.count >= 8 else {
            await MainActor.run { [weak self] in self?.loginError = "Invalid email or password" }
            return
        }
        await MainActor.run { [weak self] in self?.loading = true }
        do {
            try await network.login(credentials: UserCredentials(email: email, password: password))
            await MainActor.run { loginSuccess = true }
        } catch {
            await MainActor.run { [weak self] in
                self?.loginError = "Invalid email or password"
                self?.loginSuccess = false
            }
        }
        await MainActor.run { [weak self] in self?.loading = false }
    }
    
    func logout() async {
        await MainActor.run { [weak self] in self?.loginSuccess = false }
        network.logout()
    }
    
    func cleanError() {
        loginError = nil
        registrationError = nil
    }
}

private extension AccountViewModel {
    func renew() async {
        do {
            try await network.renew()
            await MainActor.run { [weak self] in self?.loginSuccess = true }
        }
        catch {
            await logout()
            await MainActor.run { [weak self] in self?.loginSuccess = false }
        }
    }
    
    func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

