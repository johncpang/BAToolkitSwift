//
//  BAButton.swift
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

@IBDesignable open class BAButton: UIButton {

	@IBInspectable var borderWidth: CGFloat = 1.0 {
		didSet {
			if (self.borderWidth < 0) {
				self.borderWidth = 0
			}
			updateBorder()
		}
	}

	@IBInspectable var borderColor: UIColor = UIColor.clear {
		didSet {
			updateBorder()
		}
	}

	@IBInspectable var cornerRadius: CGFloat = 0.0 {
		didSet {
			updateCorner(bounds: self.bounds)
		}
	}

	@IBInspectable var animatedOnHighlighted: Bool = true

	override open func awakeFromNib() {
		super.awakeFromNib()
		updateCorner(bounds: self.bounds)
	}

	override open var frame: CGRect {
		get { return super.frame }
		set {
			updateCorner(bounds: newValue)
			super.frame = newValue
		}
	}

	override open var bounds: CGRect {
		get { return super.bounds }
		set {
			updateCorner(bounds: newValue)
			super.bounds = newValue
		}
	}

	override open var isEnabled: Bool {
		didSet {
			updateAlpha()
		}
	}

	override open var isHighlighted: Bool {
		didSet {
			updateAlpha()
			if (self.animatedOnHighlighted) {
				let duration: TimeInterval = self.isHighlighted ? 0.10 : 0.05
				let scale: CGFloat = self.isHighlighted ? 0.95 : 1.00
				UIView.beginAnimations("BAButton", context: nil)
				UIView.setAnimationDuration(duration)
				self.transform = CGAffineTransform(scaleX: scale, y: scale)
				UIView.commitAnimations()
			}
		}
	}

	open func updateAlpha() {
		self.alpha = (self.isEnabled ? (self.isHighlighted ? 0.8 : 1.0) : 0.6)
	}

	open func updateBorder() {
		setBorder(color: self.borderColor, pixelWidth: self.borderWidth)
	}

	open func updateCorner(bounds: CGRect) {
		setRoundCorner(cornerRadius)
	}
	
}
