//
//  DeviceRotationViewModifierExt.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 10/01/2023.
//

import Foundation
import SwiftUI

// MARK: - DeviceRotationViewModifier

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}
