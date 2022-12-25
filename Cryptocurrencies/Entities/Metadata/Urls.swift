/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Urls : Codable {
	let website : [String]?
	let technical_doc : [String]?
	let twitter : [String]?
	let reddit : [String]?
	let message_board : [String]?
	let announcement : [String]?
	let chat : [String]?
	let explorer : [String]?
	let source_code : [String]?

	enum CodingKeys: String, CodingKey {

		case website = "website"
		case technical_doc = "technical_doc"
		case twitter = "twitter"
		case reddit = "reddit"
		case message_board = "message_board"
		case announcement = "announcement"
		case chat = "chat"
		case explorer = "explorer"
		case source_code = "source_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		website = try values.decodeIfPresent([String].self, forKey: .website)
		technical_doc = try values.decodeIfPresent([String].self, forKey: .technical_doc)
		twitter = try values.decodeIfPresent([String].self, forKey: .twitter)
		reddit = try values.decodeIfPresent([String].self, forKey: .reddit)
		message_board = try values.decodeIfPresent([String].self, forKey: .message_board)
		announcement = try values.decodeIfPresent([String].self, forKey: .announcement)
		chat = try values.decodeIfPresent([String].self, forKey: .chat)
		explorer = try values.decodeIfPresent([String].self, forKey: .explorer)
		source_code = try values.decodeIfPresent([String].self, forKey: .source_code)
	}

}