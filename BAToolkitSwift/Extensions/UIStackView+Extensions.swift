//
//  UIStackView+Extensions.swift
//  ActiveLabel
//
//  Created by John on 2018-3-13.
//

import UIKit

@available(iOS 9.0, *)
public extension UIStackView {

	public func discardArrangedSubview(_ view: UIView) {
		self.removeArrangedSubview(view)
		view.removeFromSuperview()
	}

	public func discardArrangedSubviews() {
		let array = self.arrangedSubviews
		for (_, view) in array.enumerated().reversed() {
			discardArrangedSubview(view)
		}
	}

}
