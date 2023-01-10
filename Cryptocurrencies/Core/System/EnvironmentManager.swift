//
//  EnvironmentManager.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Foundation

// MARK: - EnvironmentManager

final class EnvironmentManager {
    static let shared = EnvironmentManager()
    fileprivate let environmentPlistName = Strings.EnvironmentVariables.fullString()
    fileprivate let configurationKey = Strings.Configuration.fullString()
    fileprivate var environmentsDict: NSDictionary!
    var activeConfiguration: Configuration?

    enum Configuration: String {
        case Debug
        case Staging
        case Release
    }

    fileprivate enum EnvironmentProperty: String {
        case baseURL
        case apiKey
        
        var stringValue: String {
            let appConfig = try? EnvironmentManager.shared.setting(self)
            return appConfig ?? ""
        }

        var urlValue: URL? {
            let appConfig = try? URL(string: EnvironmentManager.shared.setting(self))
            return appConfig
        }
    }

    fileprivate init() {
        let bundle = Bundle(for: EnvironmentManager.self)
        let configurationName = (bundle.infoDictionary?[configurationKey] as? String)!
        activeConfiguration = Configuration(rawValue: configurationName)
        let environmentsPath = bundle.path(forResource: environmentPlistName, ofType: Strings.plist.fullString())!
        if let mainEnvironmentsDict = NSDictionary(contentsOfFile: environmentsPath),
           let activeConfigurationString = activeConfiguration?.rawValue,
           let activeDictionary = mainEnvironmentsDict[activeConfigurationString] as? NSDictionary
        {
            environmentsDict = activeDictionary
        }
    }

    fileprivate func setting(_ property: EnvironmentProperty) throws -> String {
        if let value = environmentsDict[property.rawValue] as? String {
            return value
        }
        throw NSError(domain: Strings.noSetting.fullString(withParameters: "\(property.rawValue)"), code: 100_012, userInfo: nil)
    }

    func getAppKey() -> String {
        return EnvironmentProperty.apiKey.stringValue
    }
    
    func getBaseUrl() -> String {
        return EnvironmentProperty.baseURL.stringValue
    }
    
    func checkIsDev() -> Bool {
        return activeConfiguration == .Debug
    }
}

// MARK: - PlistFiles

internal enum PlistFiles {
    private static let _document = PlistDocument(path: Strings.environmentVariablesPlist.fullString())
}

private func arrayFromPlist<T>(at path: String) -> [T] {
    let bundle = Bundle(for: BundleToken.self)
    guard let url = bundle.url(forResource: path, withExtension: nil),
          let data = NSArray(contentsOf: url) as? [T]
    else {
        fatalError(Strings.unableToLoadPLIST.fullString(withParameters: "\(path)"))
    }
    return data
}

// MARK: - PlistDocument

private struct PlistDocument {
    let data: [String: Any]

    init(path: String) {
        let bundle = Bundle(for: BundleToken.self)
        guard let url = bundle.url(forResource: path, withExtension: nil),
              let data = NSDictionary(contentsOf: url) as? [String: Any]
        else {
            fatalError(Strings.unableToLoadPLIST.fullString(withParameters: "\(path)"))
        }
        self.data = data
    }

    subscript<T>(key: String) -> T {
        guard let result = data[key] as? T else {
            fatalError(Strings.PropertyNotOfType.fullString(withParameters: "'\(key)'", "\(T.self)"))
        }
        return result
    }
}

// MARK: - BundleToken

private final class BundleToken {}
