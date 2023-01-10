//
//  ViewExt.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 10/01/2023.
//

import Foundation
import SwiftUI

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        modifier(DeviceRotationViewModifier(action: action))
    }
}
