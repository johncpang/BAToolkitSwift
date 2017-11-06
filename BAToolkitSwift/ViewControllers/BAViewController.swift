//
//  BaseViewController.swift
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

// MARK: - class BAViewController

open class BAViewController: UIViewController, UIGestureRecognizerDelegate {

	open var preventBack: Bool = false

	override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override open func viewDidLoad() {
		super.viewDidLoad()
		if (self.preventBack) {
			self.navigationItem.hidesBackButton = true
		}
	}

	override open func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if (self.preventBack) {
			self.stopPopGestureRecognizer(delegate: self)
		}
	}

	override open func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		if (self.preventBack) {
			self.resumePopGestureRecognizer()
		}
	}

	// MARK: - Navigations

	/**
	http://stackoverflow.com/a/26946596/3731039
	1) shouldPerformSegueWithIdentifier is used to make sure that a segue that has been set up in
	Storyboards should be triggered, so it only gets called in the case of Storyboard Segues
	and gives you the chance to not actually perform the segue

	2) when you call performSegueWithIdentifier yourself, shouldPerformSegueWithIdentifier is not
	called because it can be assumed that you know what you are doing. there would be no point
	in calling performSegueWithIdentifier but then return a NO from shouldPerformSegueWithIdentifier
	*/
	override open func performSegue(withIdentifier identifier: String, sender: Any?) {
		if (shouldPerformSegue(withIdentifier: identifier, sender: sender)) {
			super.performSegue(withIdentifier: identifier, sender: sender)
		}
	}

	// MARK: - UIGestureRecognizerDelegate {

	open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return !self.preventBack
	}

}
