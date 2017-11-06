//
//  UnderlineTextField.swift
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

@IBDesignable class UnderlineTextField: UITextField {

	@IBInspectable var activeLineColor: UIColor = UIColor.init(white: 32.0/255.0, alpha: 1.0)

	@IBInspectable var inactiveLineColor: UIColor = UIColor.init(white: 192.0/255.0, alpha: 1.0)

	@IBOutlet weak var errorLabel: UILabel?

	override open func awakeFromNib() {
		super.awakeFromNib()
		setup()
		updateBottomline(false)
	}

	override open var frame: CGRect {
		get { return super.frame }
		set {
			super.frame = newValue
			updateBottomline(false)
		}
	}

	override open var bounds: CGRect {
		get { return super.bounds }
		set {
			super.bounds = newValue
			updateBottomline(false)
		}
	}

	func setup() {
		self.addTarget(self, action: #selector(editingDidBegin(_:)), for: .editingDidBegin)
		self.addTarget(self, action: #selector(editingDidEnd(_:)), for: .editingDidEnd)
		self.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
		self.errorLabel?.isHidden = true
	}

	@objc func editingDidBegin(_ textField: UITextField) {
		updateBottomline(true)
	}

	@objc func editingDidEnd(_ textField: UITextField) {
		updateBottomline(false);
	}

	@objc func editingChanged(_ textField: UITextField) {
		hideError()
	}

	func updateBottomline(_ active: Bool) {
		self.setBottomBorder(color: (active ? self.activeLineColor : self.inactiveLineColor))
	}

	func hideError() {
		self.errorLabel?.alpha = 0.0
	}

	func showError() {
		self.errorLabel?.alpha = 1.0
		self.errorLabel?.isHidden = false
	}

	func showError(text: String) {
		self.errorLabel?.text = text
		showError()
	}

	func hasError() -> Bool {
		return !(self.errorLabel?.isHidden ?? true)
	}

}
