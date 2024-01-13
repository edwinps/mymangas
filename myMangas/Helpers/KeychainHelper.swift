//
//  KeychainHelper.swift
//  myMangas
//
//  Created by epena on 13/1/24.
//

import Foundation
import Security

struct KeychainHelper {
    func saveData(key: String, data: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            return
        }
    }

    func loadData(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess, let data = item as? Data else {
            return nil
        }

        return data
    }
    
    func deleteData(key: String) {
           let query = [
               kSecClass: kSecClassGenericPassword,
               kSecAttrAccount: key
           ] as CFDictionary

           SecItemDelete(query)
       }
}
