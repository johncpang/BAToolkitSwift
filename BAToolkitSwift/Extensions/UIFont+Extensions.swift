//
//  UIFont+Extensions.swift
//
//  @version 1.0
//  @author John Pang, http://brewingapps.com
//
//  Copyright © 2014–2016 Brewing Apps Limited ( http://brewingapps.com/ )
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

public extension UIFont {

	@objc class func font(forTextStyle style: UIFont.TextStyle, multiple: CGFloat) -> UIFont {
		let font = UIFont.preferredFont(forTextStyle: style)
		return font.withSize(font.pointSize * multiple)
	}

	@objc class func systemFont(forTextStyle style: UIFont.TextStyle, multiple: CGFloat, weight: Weight) -> UIFont {
		let font = UIFont.preferredFont(forTextStyle: style)
		let size = font.pointSize * multiple
		return UIFont.systemFont(ofSize: size, weight: weight)
	}

	@objc public func systemFont(ofWeight weight: Weight) -> UIFont {
		return UIFont.systemFont(ofSize: self.pointSize, weight: weight)
	}

	public func fontWithSymbolicTraits(_ symbolicTraits: UIFontDescriptor.SymbolicTraits) -> UIFont {
		if let descriptor = self.fontDescriptor.withSymbolicTraits(symbolicTraits) {
			return UIFont.init(descriptor: descriptor, size: self.pointSize)
		}
		return self
	}

	public func fontWithBold(_ isBold: Bool) -> UIFont {
		var symbolicTraits = self.fontDescriptor.symbolicTraits
		if (isBold) {
			symbolicTraits.insert([.traitBold])
		} else {
			symbolicTraits.remove([.traitBold])
		}
		return fontWithSymbolicTraits(symbolicTraits)
	}

	public func fontWithItalic(_ isItalic: Bool) -> UIFont {
		var symbolicTraits = self.fontDescriptor.symbolicTraits
		if (isItalic) {
			symbolicTraits.insert([.traitItalic])
		} else {
			symbolicTraits.remove([.traitItalic])
		}
		return fontWithSymbolicTraits(symbolicTraits)
	}

}
