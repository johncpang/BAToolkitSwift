//
//  String+Extensions.swift
//
//  Created by John on 2017-11-6.
//
//  @version 1.0
//  @author John Pang, http://brewingapps.com
//
//  Copyright © 2014-2018 Brewing Apps Limited ( http://brewingapps.com/ )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
/// Returns a localized string, using the main bundle if one is not specified.

public func LS(_ key: String) -> String {
	return NSLocalizedString(key, comment: "")
}

public extension String {

	static func isEmpty(_ string: String?) -> Bool {
		return ((nil == string) || (string!.length == 0))
	}

	public func isValidEmail() -> Bool {
		if (self.length > 0) {
			// Regular domain name: [A-Za-z0-9.-]+\.[A-Za-z]{2,4}
			// IP address: [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}
			let pattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,4})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3})"
			do {
				let regEx = try NSRegularExpression.init(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
				let matches = regEx.numberOfMatches(in: self, range: NSRange.init(location: 0, length: self.length))
				return matches != 0
			} catch _ {
				return false
			}
		}
		return false
	}

	// MARK: Common Swift String Extensions
	// https://gist.github.com/albertbori/0faf7de867d96eb83591

	public var length: Int {
		get {
			#if swift(>=3.2)
				return self.count
			#else
				return self.characters.count
			#endif
		}
	}

	public func floatValue() -> Float {
		return (self as NSString).floatValue
	}
	
	public func contains(s: String) -> Bool {
		return (self.range(of: s) != nil) ? true : false
	}

	public func fullRange() -> NSRange {
		return NSRange.init(location: 0, length: self.length)
	}

	// MARK: -

	public func trim() -> String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}

	public func replace(target: String, withString: String) -> String {
		return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
	}

	public func replace(pattern: String, withTemplate templ: String) -> String {
		if let regex = try? NSRegularExpression.init(pattern: pattern, options: .caseInsensitive) {
			return regex.stringByReplacingMatches(in: self,
												  range: self.fullRange(),
												  withTemplate: templ)
		}
		return self
	}

	public func remove(pattern: String) -> String {
		return replace(pattern: pattern, withTemplate: "")
	}

	// MARK: -

	static func join(_ array: [String]?) -> String? {
		var result: String?
		if let array = array {
			result = ""
			array.forEach() { result! += $0 }
		}
		return result
	}

	static func join(_ array: [String]?, with connector: String) -> String? {
		var result: String?
		if let array = array {
			result = ""
			array.dropLast().forEach() {
				result! += $0 + connector
			}
			result! += array.last ?? ""
		}
		return result
	}

	// MARK: - URL

	public func asEncodedURL() -> URL? {
		if let url = URL(string: self) {
			return url
		}
		if let s = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
			return URL(string: s)
		}
		return nil
	}

	// MARK: - HTML handlings

	public func unescapeHTML() -> String {
		guard let data = self.data(using: .utf8) else {
			return self
		}
		let attrString = try? NSAttributedString(data: data,
													   options: [.documentType: NSAttributedString.DocumentType.html,
																 .characterEncoding: String.Encoding.utf8.rawValue],
													   documentAttributes: nil)
		return attrString?.string ?? self
	}

	public func stripHTML() -> String {
		return self.replacingOccurrences(of: "<[^>]+>",
										 with: "",
										 options: .regularExpression,
										 range: nil)
	}

	// MARK: - JSON handlings

	static public func string(jsonObject: Any) -> String? {
		if let data = try? JSONSerialization.data(withJSONObject: jsonObject) {
			return String.init(data: data, encoding: .utf8)!
		}
		return nil
	}

	// MARK: - Numeric comparsion

	public func numericCompareTo(_ string: String) -> ComparisonResult {
		return self.compare(string, options: .numeric)
	}

	public func numericEqualTo(_ string: String) -> Bool {
		return numericCompareTo(string) == .orderedSame
	}

	public func numericGreaterThan(_ string: String) -> Bool {
		return numericCompareTo(string) == .orderedDescending
	}

	public func numericGreaterThanOrEqualTo(_ string: String) -> Bool {
		return numericCompareTo(string) != .orderedAscending
	}

	public func numericLessThan(_ string: String) -> Bool {
		return numericCompareTo(string) == .orderedAscending
	}

	public func numericLessThanOrEqualTo(_ string: String) -> Bool {
		return numericCompareTo(string) != .orderedDescending
	}

}
