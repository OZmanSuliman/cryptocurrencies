//
//  Strings.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 10/01/2023.
//

import Foundation

enum Strings: String {
    case appLogo
    case jsonFile
    case json
    case EnvironmentVariables
    case Configuration
    case plist
    case noSetting = "No <%@> setting has been found"
    case environmentVariablesPlist = "EnvironmentVariables.plist"
    case unableToLoadPLIST = "Unable to load PLIST at path: %@"
    case PropertyNotOfType = "Property %@ is not of type %@"
    case Currency_14
    case apiKey = "X-CMC_PRO_API_KEY"
    case marketCap = "market_cap"
    case all
    case appStateSerialQueue
    case networkSerialQueue
    case GMT
    case dateFormatEHA = "EEEE - h a"
    case dataFormatYMDHMS = "yyyy-MM-dd HH:mm:ss"
    case errorDecodingString = "There was an error decoding the string"
    case NA
    case noData = "No Data Available About The Currencies😢"
    case icloud = "icloud.slash.fill"
    case defaultError = "An Error Occured"
    case banner
    case appName = "Cryptocurrencies"
    case appCost = "One Month free, then $4.99/month."
    
    func fullString(withParameters parameters: CVarArg...) -> String {
        var str = self.rawValue

        if parameters.count > 0 {
            str = String(format: str, arguments: parameters)
        }

        return str
    }
}
