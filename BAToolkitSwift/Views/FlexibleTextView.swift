//
//  FlexibleTextView.swift
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

// http://stackoverflow.com/a/41770390/3731039

import UIKit

@IBDesignable open class FlexibleTextView: UITextView {
	// limit the height of expansion per intrinsicContentSize
	@objc open var maxHeight: CGFloat = 0.0

	private let placeholderTextView: UITextView = {
		let tv = UITextView()

		tv.translatesAutoresizingMaskIntoConstraints = false
		tv.backgroundColor = .clear
		tv.isScrollEnabled = false
		tv.textColor = .lightGray
		tv.isUserInteractionEnabled = false
		return tv
	}()

	@IBInspectable open var placeholder: String! {
		get {
			return placeholderTextView.text
		}
		set {
			placeholderTextView.text = newValue
		}
	}

	// Setup view from .xib file
	func xibSetup() {
		isScrollEnabled = false
		autoresizingMask = [.flexibleWidth, .flexibleHeight]
		NotificationCenter.default.addObserver(self, selector: #selector(UITextInputDelegate.textDidChange(_:)), name: Notification.Name.UITextViewTextDidChange, object: self)
		placeholderTextView.font = font
		addSubview(placeholderTextView)

		NSLayoutConstraint.activate([
			placeholderTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
			placeholderTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
			placeholderTextView.topAnchor.constraint(equalTo: topAnchor),
			placeholderTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
			])
	}

	override public init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		xibSetup()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}

	override open var text: String! {
		didSet {
			invalidateIntrinsicContentSize()
			placeholderTextView.isHidden = !text.isEmpty
		}
	}

	override open var font: UIFont? {
		didSet {
			placeholderTextView.font = font
			invalidateIntrinsicContentSize()
		}
	}

	override open var contentInset: UIEdgeInsets {
		didSet {
			placeholderTextView.contentInset = contentInset
		}
	}

	override open var intrinsicContentSize: CGSize {
		var size = super.intrinsicContentSize

		if size.height == UIViewNoIntrinsicMetric {
			// force layout
			layoutManager.glyphRange(for: textContainer)
			size.height = layoutManager.usedRect(for: textContainer).height + textContainerInset.top + textContainerInset.bottom
		}

		if maxHeight > 0.0 && size.height > maxHeight {
			size.height = maxHeight

			if !isScrollEnabled {
				isScrollEnabled = true
			}
		} else if isScrollEnabled {
			isScrollEnabled = false
		}

		return size
	}

	@objc open func textDidChange(_ note: Notification) {
		// needed incase isScrollEnabled is set to true which stops automatically calling invalidateIntrinsicContentSize()
		invalidateIntrinsicContentSize()
		self.placeholderTextView.isHidden = !self.text.isEmpty
	}
}
