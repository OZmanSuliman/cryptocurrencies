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
    @Published var unit = 0
    @Published var isNotificationsOn = false
    @Published var state = AppStateEnum.idle
    @Published var result: Result<CryptocurrencyModel, Error>?
    @Published private(set) var time = Date().timeIntervalSince1970
    private var cancellable: AnyCancellable?
    private let concurrentQueue = DispatchQueue(label: "serialQueue", attributes: .concurrent)

    init() {
        unit = UserDefaults.standard.integer(forKey: "unit")
        isNotificationsOn = UserDefaults.standard.bool(forKey: "isNotificationsOn")
    }
}

extension AppState {
    var stateCalculator: AppStateEnum {
        get {
            return getState()
        }
        set {
            setState(newValue: newValue)
        }
    }

    func getState() -> AppStateEnum {
        var value: AppStateEnum?
        concurrentQueue.sync {
            value = self.state
        }
        return value ?? .idle
    }

    func setState(newValue: AppStateEnum) {
        concurrentQueue.async(flags: .barrier) {
            DispatchQueue.main.async{
                self.state = newValue
            }
        }
    }

    func start() {
        cancellable = Timer.publish(
            every: 1,
            on: .main,
            in: .default
        )
        .autoconnect()
        .sink { date in
            self.time = date.timeIntervalSince1970
        }
    }

    func stop() {
        cancellable = nil
    }
}
