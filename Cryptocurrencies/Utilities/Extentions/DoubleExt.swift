//
//  DoubleExt.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 10/01/2023.
//

import Foundation

extension Double {
    func roundedDecimal(to scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        var decimalValue = Decimal(self)
        var result = Decimal()
        NSDecimalRound(&result, &decimalValue, scale, mode)
        return result
    }

    func convertDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: Strings.GMT.fullString()) // Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = Strings.dateFormatEHA.fullString() // Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
