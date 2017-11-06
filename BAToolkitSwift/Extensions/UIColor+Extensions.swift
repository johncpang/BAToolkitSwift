//
//  UIColor+Extensions.swift
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

import UIKit

extension UIColor {

	convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
		self.init(
			red: CGFloat(red) / 255.0,
			green: CGFloat(green) / 255.0,
			blue: CGFloat(blue) / 255.0,
			alpha: a
		)
	}

	convenience init(red: Int, green: Int, blue: Int, aInt: Int) {
		self.init(
			red: CGFloat(red) / 255.0,
			green: CGFloat(green) / 255.0,
			blue: CGFloat(blue) / 255.0,
			alpha: CGFloat(aInt) / 255.0
		)
	}

	convenience init(rgb: Int, a: CGFloat = 1.0) {
		self.init(
			red: (rgb >> 16) & 0xFF,
			green: (rgb >> 8) & 0xFF,
			blue: rgb & 0xFF,
			a: a
		)
	}

	// let's suppose alpha is the first component (ARGB)
	convenience init(argb: Int) {
		self.init(
			red: (argb >> 16) & 0xFF,
			green: (argb >> 8) & 0xFF,
			blue: argb & 0xFF,
			aInt: (argb >> 24) & 0xFF
		)
	}

	var hexString: String {
		let colorRef = self.cgColor.components!
		let r: CGFloat = colorRef[0]
		let g: CGFloat = colorRef[1]
		let b: CGFloat = colorRef[2]
		return String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
	}
}
