//
//  NSLayoutConstraint+Extensions.swift
//
//  Created by John on 2017-12-24.
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
import UIKit

public extension NSLayoutConstraint {
	/**
	Change multiplier constraint

	- parameter multiplier: CGFloat
	- returns: NSLayoutConstraint
	*/
	func replace(multiplier:CGFloat) -> NSLayoutConstraint {

		NSLayoutConstraint.deactivate([self])

		let newConstraint = NSLayoutConstraint(
			item: firstItem as Any,
			attribute: firstAttribute,
			relatedBy: relation,
			toItem: secondItem,
			attribute: secondAttribute,
			multiplier: multiplier,
			constant: constant)

		newConstraint.priority = priority
		newConstraint.shouldBeArchived = self.shouldBeArchived
		newConstraint.identifier = self.identifier

		NSLayoutConstraint.activate([newConstraint])
		return newConstraint
	}
}
