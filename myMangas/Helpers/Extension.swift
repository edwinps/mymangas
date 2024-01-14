//
//  Extension.swift
//  myMangas
//
//  Created by epena on 14/1/24.
//

import SwiftUI

extension UIDevice {
    static var topInsetSize: CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .safeAreaInsets
            .top ?? 0
    }
}
