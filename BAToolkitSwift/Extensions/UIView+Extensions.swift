//
//  UIView+Extensions.swift
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

import UIKit

public extension UIView {

	// MARK: - Display and Styling

	@objc func setBorder(color: UIColor) {
		self.layer.borderColor = color.cgColor
	}

	@objc func setBorder(color: UIColor, width: CGFloat, native: Bool = true) {
		self.layer.borderColor = color.cgColor
		self.layer.borderWidth = width * (native ? UIScreen.main.scale / UIScreen.main.nativeScale : 1)
	}

	@objc func setRoundCorner(_ radius: CGFloat) {
		self.layer.cornerRadius = radius
		self.clipsToBounds = true
	}

	@objc func clearRoundCorder() {
		self.layer.cornerRadius = 0.0
	}

	// http://stackoverflow.com/questions/23988086/how-to-do-hexagon-type-image-masking-on-imageview-in-ios
	func setupAsHexagon() {
		let rect = self.frame
		let hexagonMask = CAShapeLayer.init()
		let hexagonPath = UIBezierPath.init()

		let sideWidth = 2 * ( 0.5 * rect.size.width / 2 )
		let lcolumn = ( rect.size.width - sideWidth ) / 2
		let rcolumn = rect.size.width - lcolumn
		let height = 0.866025 * rect.size.height
		let y = (rect.size.height - height) / 2
		let by = rect.size.height - y
		let midy = rect.size.height / 2
		let rightmost = rect.size.width
		hexagonPath.move(to: CGPoint(x: lcolumn, y: y))
		hexagonPath.addLine(to: CGPoint(x: rcolumn, y: y))
		hexagonPath.addLine(to: CGPoint(x: rightmost, y: midy))
		hexagonPath.addLine(to: CGPoint(x: rcolumn, y: by))
		hexagonPath.addLine(to: CGPoint(x: lcolumn, y: by))
		hexagonPath.addLine(to: CGPoint(x: 0, y: midy))
		hexagonPath.addLine(to: CGPoint(x: lcolumn, y: y))
		hexagonMask.path = hexagonPath.cgPath
		self.layer.mask = hexagonMask
	}

	func fadeOut(_ animated: Bool = true) {
		if (animated && self.alpha != 0) {
			UIView.animate(withDuration: 0.3) {self.alpha = 0}
		} else {
			self.alpha = 0
		}
	}

	func fadeIn(_ animated: Bool = true) {
		if (animated && self.alpha != 1) {
			UIView.animate(withDuration: 0.3) {self.alpha = 1}
		} else {
			self.alpha = 1
		}
	}

	// MARK: - User Interactions

	@discardableResult @objc func addTapGesture(target: Any?, action: Selector?) -> UITapGestureRecognizer {
		let gesture = UITapGestureRecognizer.init(target: target, action: action)
		gesture.numberOfTapsRequired = 1
		self.addGestureRecognizer(gesture)
		self.isUserInteractionEnabled = true
		gesture.cancelsTouchesInView = true
		gesture.delegate = target as? UIGestureRecognizerDelegate
		return gesture
	}

	// MARK: - Animation

	// https://stackoverflow.com/a/34199068
	@objc func startRotate() {
		let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
		rotation.toValue = NSNumber(value: -Double.pi * 2)
		rotation.duration = 2
		rotation.isCumulative = true
		rotation.repeatCount = Float.greatestFiniteMagnitude
		self.layer.add(rotation, forKey: "rotationAnimation")
	}

	@objc func stopRotate() {
		self.layer.removeAnimation(forKey: "rotationAnimation")
	}

	// MARK: - View loading

	func loadViewFromNib() -> UIView {
		return loadViewFromNib(String(describing: type(of: self)))
	}

	func loadViewFromNib(_ nibName: String) -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: nibName, bundle: bundle)
		let v = nib.instantiate(withOwner: self, options: nil).first as! UIView
		v.frame = bounds
		v.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
		return v
	}

	@objc func removeAllSubviews() {
		self.subviews.forEach() { $0.removeFromSuperview() }
	}

	@objc func findFirstResponder() -> UIView? {
		if (self.isFirstResponder) {
			return self
		}
		for v in self.subviews {
			if let res = v.findFirstResponder() {
				return res
			}
		}
		return nil
	}

	@objc func subview(withTag tag: Int) -> UIView? {
		for v in self.subviews {
			if let v2 = v.subview(withTag: tag) {
				return v2
			}
			if v.tag == tag {
				return v
			}
		}
		return nil
	}

	func firstAvailableUIViewController() -> UIViewController? {
		return traverseResponderChainForUIViewController() as? UIViewController
	}

	func traverseResponderChainForUIViewController() -> Any? {
		let nextResponder = self.next
		if (nextResponder is UIViewController) {
			return nextResponder
		}
		if (nextResponder is UIView) {
			return (nextResponder as! UIView).traverseResponderChainForUIViewController()
		}
		return nil
	}

}

