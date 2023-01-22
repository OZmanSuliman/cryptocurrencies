/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Status : Codable {
	let timestamp : String?
	let error_code : Int?
	let error_message : String?
	let elapsed : Int?
	let credit_count : Int?
	let notice : String?

	enum CodingKeys: String, CodingKey {

		case timestamp = "timestamp"
		case error_code = "error_code"
		case error_message = "error_message"
		case elapsed = "elapsed"
		case credit_count = "credit_count"
		case notice = "notice"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
		error_code = try values.decodeIfPresent(Int.self, forKey: .error_code)
		error_message = try values.decodeIfPresent(String.self, forKey: .error_message)
		elapsed = try values.decodeIfPresent(Int.self, forKey: .elapsed)
		credit_count = try values.decodeIfPresent(Int.self, forKey: .credit_count)
		notice = try values.decodeIfPresent(String.self, forKey: .notice)
	}

    init(timestamp: String?, error_code: Int?, error_message: String?, elapsed: Int?, credit_count: Int?, notice: String?) {
        self.timestamp = timestamp
        self.error_code = error_code
        self.error_message = error_message
        self.elapsed = elapsed
        self.credit_count = credit_count
        self.notice = notice
    }

}
