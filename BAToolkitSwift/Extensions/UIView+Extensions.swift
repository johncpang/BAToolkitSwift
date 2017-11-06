//
//  UIView+Extensions.swift
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

public extension UIView {

	// MARK: - Display and Styling

	public func setBorder(color: UIColor) {
		self.layer.borderColor = color.cgColor;
	}

	public func setBorder(color: UIColor, pixelWidth width: CGFloat) {
		self.layer.borderColor = color.cgColor;
		self.layer.borderWidth = width / UIScreen.main.scale;
	}

	public func setRoundCorner(_ radius: CGFloat) {
		self.layer.cornerRadius = radius
		self.clipsToBounds = true
	}

	public func clearRoundCorder() {
		self.layer.cornerRadius = 0.0
	}

	public func fadeOut(_ animated: Bool = true) {
		if (animated) {
			UIView.animate(withDuration: 0.3) {self.alpha = 0}
		} else {
			self.alpha = 0;
		}
	}

	public func fadeIn(_ animated: Bool = true) {
		if (animated) {
			UIView.animate(withDuration: 0.3) {self.alpha = 1}
		} else {
			self.alpha = 1;
		}
	}

	// MARK: - User Interactions

	public func addTapGesture(target: UIGestureRecognizerDelegate?, action: Selector?) -> UITapGestureRecognizer {
		let gesture = UITapGestureRecognizer.init(target: target, action: action)
		gesture.numberOfTapsRequired = 1;
		self.addGestureRecognizer(gesture)
		self.isUserInteractionEnabled = true
		gesture.cancelsTouchesInView = true
		gesture.delegate = target
		return gesture
	}

	// MARK: - Animation

	// https://stackoverflow.com/a/34199068
	public func startRotate() {
		let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
		rotation.toValue = NSNumber(value: -Double.pi * 2)
		rotation.duration = 2
		rotation.isCumulative = true
		rotation.repeatCount = Float.greatestFiniteMagnitude
		self.layer.add(rotation, forKey: "rotationAnimation")
	}

	public func stopRotate() {
		self.layer.removeAnimation(forKey: "rotationAnimation")
	}

	// MARK: - View loading

	public func loadViewFromNib() -> UIView {
		return loadViewFromNib(String(describing: type(of: self)))
	}

	public func loadViewFromNib(_ nibName: String) -> UIView {
		let bundle = Bundle(for: type(of: self))
		let nib = UINib(nibName: nibName, bundle: bundle)
		let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
		view.frame = bounds
		view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
		return view
	}

}

