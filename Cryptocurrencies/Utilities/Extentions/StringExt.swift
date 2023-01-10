//
//  StringExt.swift
//  Cryptocurrencies
//
//  Created by Osman Ahmed on 10/01/2023.
//

import Foundation

extension String {
    func changeCentigradeToFahrenheit() -> String {
        let temp = Double(self)
        return "\(((temp! * 9 / 5) + 32).roundedDecimal(to: 2))"
    }
}

extension String {
    func formatDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = Strings.dataFormatYMDHMS.fullString()

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = Strings.dateFormatEHA.fullString()

        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return Strings.errorDecodingString.fullString()
        }
    }
}

extension String {
    mutating func insert(string: String, ind: Int) {
        insert(contentsOf: string, at: index(startIndex, offsetBy: ind))
    }

    var length: Int {
        return count
    }

    subscript(i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript(r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
