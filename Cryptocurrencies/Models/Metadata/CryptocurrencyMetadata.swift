/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CryptocurrencyMetadata : Codable {
	let urls : Urls?
	let logo : String?
	let id : Int?
	let name : String?
	let symbol : String?
	let slug : String?
	let description : String?
	let date_added : String?
	let date_launched : String?
	let tags : [String]?
	let category : String?

	enum CodingKeys: String, CodingKey {

		case urls = "urls"
		case logo = "logo"
		case id = "id"
		case name = "name"
		case symbol = "symbol"
		case slug = "slug"
		case description = "description"
		case date_added = "date_added"
		case date_launched = "date_launched"
		case tags = "tags"
		case category = "category"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
		logo = try values.decodeIfPresent(String.self, forKey: .logo)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
		slug = try values.decodeIfPresent(String.self, forKey: .slug)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		date_added = try values.decodeIfPresent(String.self, forKey: .date_added)
		date_launched = try values.decodeIfPresent(String.self, forKey: .date_launched)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		category = try values.decodeIfPresent(String.self, forKey: .category)
	}

}
