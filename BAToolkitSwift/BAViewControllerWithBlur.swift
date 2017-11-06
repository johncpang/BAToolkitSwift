//
//  BAViewControllerWithBlur.swift
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

open class BAViewControllerWithBlur: BAViewController {

	@IBOutlet weak open var effectView: UIVisualEffectView!

	override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
    override open func viewDidLoad() {
		super.viewDidLoad()
		// addDismissKeyboardGesture
		let tap = UITapGestureRecognizer.init(target: self, action: #selector(dismissView))
		self.effectView.addGestureRecognizer(tap)
		tap.cancelsTouchesInView = true
		if (iOS_version() >= 9.0) {
			self.effectView.effect = nil
		}
	}

	override open func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if (iOS_version() >= 9.0) {
			UIView.animate(withDuration: 0.6) {
				self.effectView.effect = UIBlurEffect(style: .light)
			}
		}
	}

	override open func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		if (iOS_version() >= 9.0) {
			UIView.animate(withDuration: 0.3) {
				self.effectView.effect = nil
			}
		}
	}

	@objc open func dismissView() {
		self.dismiss(animated: true, completion: nil)
	}

}
