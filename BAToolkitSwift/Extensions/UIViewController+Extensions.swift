//
//  UIViewController+Extensions.swift
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

extension UIViewController {

	// MARK: - For any UIViewControllers

	func findParent(_ aClass: AnyClass) -> UIViewController? {
		var vc: UIViewController? = self
		while (vc != nil) {
			if vc!.isKind(of: aClass) {
				return vc
			}
			vc = vc!.parent
		}
		return nil
	}

	/*
	 Changes the back button to empty text. Must called from parent view controller.
	*/
	func setupEmptyBackButtonOnPushed() {
		setupBackButtonOnPushed(text: " ")
	}

	/*
	Changes the back button to any text. Must called from parent view controller.
	Default value is "Back",
	*/
	func setupBackButtonOnPushed(text: String? = nil) {
		let item = UIBarButtonItem(title: text, style: .plain, target: nil, action: nil)
		self.navigationItem.backBarButtonItem = item
	}

	// MARK: - affect navigation controller flow

	func stopPopGestureRecognizer(delegate: UIGestureRecognizerDelegate?) {
		let recognizer = self.navigationController?.interactivePopGestureRecognizer
		recognizer?.isEnabled = false
		recognizer?.delegate = delegate
	}

	func resumePopGestureRecognizer() {
		let recognizer = self.navigationController?.interactivePopGestureRecognizer
		recognizer?.isEnabled = true
		recognizer?.delegate = nil
	}

	// MARK: - UITextField or UITextView

	func toolbarWithDoneButton(_ action: Selector) -> UIToolbar? {
		let screenW = UIScreen.main.bounds.width
		let accessoryView = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: screenW, height: 44.0))
		let space = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let done = UIBarButtonItem.init(barButtonSystemItem: .done, target: nil, action: action)
		accessoryView.items = [space, done];
		return accessoryView
	}

	func dismissKeyboardWhenTapping(view: UIView) {
		let tap = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard() {
		self.view.endEditing(true)
	}

	// MARK: - UITableView

	func removeEmptySeparators(fromTableView tableView: UITableView) {
		tableView.tableFooterView = UIView.init(frame: CGRect.zero)
	}

	func tableView(_ tableView: UITableView, enableAutoRowHeight estimatedRowHeight: CGFloat) {
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = estimatedRowHeight
	}

	func tableView(_ tableView: UITableView, enableAutoSectionHeaderHeight height: CGFloat) {
		tableView.sectionHeaderHeight = UITableViewAutomaticDimension
		tableView.estimatedSectionHeaderHeight = height
	}

	func tableView(_ tableView: UITableView, enableAutoSectionFooterHeight height: CGFloat) {
		tableView.sectionFooterHeight = UITableViewAutomaticDimension
		tableView.estimatedSectionFooterHeight = height
	}

	// MARK: - UIAlertController

	func showAlert(title: String?, message: String?,
	               okButton: String?, okHandler:((UIAlertAction) -> Swift.Void)?,
	               cancelButton: String?, cancelHandler:((UIAlertAction) -> Swift.Void)?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		if let cancelButton = cancelButton {
			let action = UIAlertAction(title: cancelButton, style: .cancel, handler: cancelHandler)
			alert.addAction(action)
		}
		if let okButton = okButton {
			let action = UIAlertAction(title: okButton, style: .default, handler: okHandler)
			alert.addAction(action)
		}
		present(alert, animated: true, completion: nil)
	}

	func showAlert(title: String?, message: String?, button: String?, handler:((UIAlertAction) -> Swift.Void)?) {
		showAlert(title: title, message: message, okButton: button, okHandler: handler, cancelButton: nil, cancelHandler: nil)
	}

	func showAlert(title: String?, message: String?, button: String?) {
		showAlert(title: title, message: message, okButton: button, okHandler: nil, cancelButton: nil, cancelHandler: nil)
	}

	func showAlert(title: String?, button: String?) {
		showAlert(title: title, message: nil, okButton: button, okHandler: nil, cancelButton: nil, cancelHandler: nil)
	}

}
