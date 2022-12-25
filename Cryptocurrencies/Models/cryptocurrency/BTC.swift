/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct BTC : Codable {
	let price : Double?
	let volume_24h : Double?
	let volume_change_24h : String?
	let percent_change_1h : String?
	let percent_change_24h : String?
	let percent_change_7d : String?
	let market_cap : Double?
	let market_cap_dominance : Double?
	let fully_diluted_market_cap : Double?
	let last_updated : String?

	enum CodingKeys: String, CodingKey {

		case price = "price"
		case volume_24h = "volume_24h"
		case volume_change_24h = "volume_change_24h"
		case percent_change_1h = "percent_change_1h"
		case percent_change_24h = "percent_change_24h"
		case percent_change_7d = "percent_change_7d"
		case market_cap = "market_cap"
		case market_cap_dominance = "market_cap_dominance"
		case fully_diluted_market_cap = "fully_diluted_market_cap"
		case last_updated = "last_updated"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		price = try values.decodeIfPresent(Double.self, forKey: .price)
		volume_24h = try values.decodeIfPresent(Double.self, forKey: .volume_24h)
		volume_change_24h = try values.decodeIfPresent(String.self, forKey: .volume_change_24h)
		percent_change_1h = try values.decodeIfPresent(String.self, forKey: .percent_change_1h)
		percent_change_24h = try values.decodeIfPresent(String.self, forKey: .percent_change_24h)
		percent_change_7d = try values.decodeIfPresent(String.self, forKey: .percent_change_7d)
		market_cap = try values.decodeIfPresent(Double.self, forKey: .market_cap)
		market_cap_dominance = try values.decodeIfPresent(Double.self, forKey: .market_cap_dominance)
		fully_diluted_market_cap = try values.decodeIfPresent(Double.self, forKey: .fully_diluted_market_cap)
		last_updated = try values.decodeIfPresent(String.self, forKey: .last_updated)
	}

}
