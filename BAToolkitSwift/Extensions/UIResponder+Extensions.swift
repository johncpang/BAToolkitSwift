//
//  UIResponder+Extensions.swift
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

public extension UIResponder {

	func iOS_version() -> Float {
		return UIDevice.current.systemVersion.floatValue()
	}

	func asyncNow(execute work: @escaping @convention(block) () -> Swift.Void) {
		DispatchQueue.main.asyncAfter(deadline: .now(), execute: work)
	}

	func asyncAfter(_ delay: DispatchTimeInterval, execute work: @escaping @convention(block) () -> Swift.Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: work)
	}

}
