//
//  Debouncer.swift
//  myMangas
//
//  Created by epena on 7/1/24.
//

import Foundation

final class Debouncer {
    private var workItem: DispatchWorkItem?

    func debounce(delay: TimeInterval, action: @escaping () -> Void) {
        workItem?.cancel()

        let newWorkItem = DispatchWorkItem { action() }
        workItem = newWorkItem

        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: newWorkItem)
    }
}
