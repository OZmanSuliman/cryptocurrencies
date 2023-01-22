/*
 Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

 */

import Foundation

struct CryptocurrencyModel: Codable, Identifiable, Equatable, Hashable {
    static func == (lhs: CryptocurrencyModel, rhs: CryptocurrencyModel) -> Bool {
        lhs.id == rhs.id
    }

    var identifier: String {
        return "\(id ?? 0)-\(name ?? "")-\(date_added ?? "")"
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }

    let id: Int?
    let name: String?
    let symbol: String?
    let slug: String?
    let cmc_rank: Double?
    let num_market_pairs: Double?
    let circulating_supply: Double?
    let total_supply: Double?
    let max_supply: Double?
    let last_updated: String?
    let date_added: String?
    let tags: [String]?
    let quote: Quote?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case slug
        case cmc_rank
        case num_market_pairs
        case circulating_supply
        case total_supply
        case max_supply
        case last_updated
        case date_added
        case tags
        case quote
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        cmc_rank = try values.decodeIfPresent(Double.self, forKey: .cmc_rank)
        num_market_pairs = try values.decodeIfPresent(Double.self, forKey: .num_market_pairs)
        circulating_supply = try values.decodeIfPresent(Double.self, forKey: .circulating_supply)
        total_supply = try values.decodeIfPresent(Double.self, forKey: .total_supply)
        max_supply = try values.decodeIfPresent(Double.self, forKey: .max_supply)
        last_updated = try values.decodeIfPresent(String.self, forKey: .last_updated)
        date_added = try values.decodeIfPresent(String.self, forKey: .date_added)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        quote = try values.decodeIfPresent(Quote.self, forKey: .quote)
    }

    init(id: Int?, name: String?, symbol: String?, slug: String?,
         cmc_rank: Double?, num_market_pairs: Double?, circulating_supply: Double?,
         total_supply: Double?, max_supply: Double?, last_updated: String?,
         date_added: String?, tags: [String]?, quote: Quote?) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.slug = slug
        self.cmc_rank = cmc_rank
        self.num_market_pairs = num_market_pairs
        self.circulating_supply = circulating_supply
        self.total_supply = total_supply
        self.max_supply = max_supply
        self.last_updated = last_updated
        self.date_added = date_added
        self.tags = tags
        self.quote = quote
    }
}
