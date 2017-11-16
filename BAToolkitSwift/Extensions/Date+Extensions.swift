//
//  Date+Extensions.swift
//  BAToolkitSwift
//
//  Created by John on 2017-11-6.
//
//  @version 1.0
//  @author John Pang, http://brewingapps.com
//
//  Copyright © 2014–2017 Brewing Apps Limited ( http://brewingapps.com/ )
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

public extension Date {

	static func date(from string: String, format: String) -> Date? {
		let formatter = DateFormatter.init()
		formatter.dateFormat = format
		return formatter.date(from: string)
	}

	// example localIdentifier: "en_US_POSIX"
	public func string(format: String, localeIdentifier: String? = nil) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		if let identifier = localeIdentifier {
			formatter.locale = Locale.init(identifier: identifier)
		}
		return formatter.string(from: self)
	}

	public func isBeforeToday() -> Bool {
		return (compareWithToday() == .orderedAscending)
	}

	public func isToday() -> Bool {
		return (compareWithToday() == .orderedSame)
	}

	public func isAfterToday() -> Bool {
		return (compareWithToday() == .orderedDescending)
	}

	public func compareWithToday() -> ComparisonResult {
		let calendar = Locale.current.calendar
		let units: Set<Calendar.Component> = [.year, .month, .day]
		let today = calendar.date(from: calendar.dateComponents(units, from: Date()))!
		let date = calendar.date(from: calendar.dateComponents(units, from: self))!
		return date.compare(today)
	}

}
