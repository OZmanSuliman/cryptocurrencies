//
//  AppState.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Combine
import SwiftUI

// MARK: - AppStateEnum

enum AppStateEnum: Equatable {
    static func == (lhs: AppStateEnum, rhs: AppStateEnum) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.failed(_), .failed(_)):
            return true
        case (.loaded(_), .loaded(_)):
            return true
        default:
            return false
        }
    }

    case idle
    case loading
    case failed(String)
    case loaded(Any)
}

// MARK: - AppState
class AppState: ObservableObject {
    static let shared = AppState()
    @Published private(set) var state = AppStateEnum.idle
    private let concurrentQueue = DispatchQueue(label: "serialQueue", attributes: .concurrent)

    var stateCalculator: AppStateEnum {
        get {
            var value: AppStateEnum?
            concurrentQueue.sync {
                value = self.state
            }
            return value ?? .idle
        }
        set {
            concurrentQueue.async(flags: .barrier) {
                DispatchQueue.main.async {
                    self.state = newValue
                }
            }
        }
    }
}
