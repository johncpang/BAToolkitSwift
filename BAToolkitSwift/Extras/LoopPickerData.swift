//
//  PickerView.swift
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

open class LoopPickerData<T>: NSObject {

	public init(_ items: [T]) {
		super.init()
		self.items = items
		self.reload()
	}

	public private(set) var numberOfRows = 10000

	private var middleRow = 0

	open var items: [T]! {
		didSet {
			reload()
		}
	}

	open func reload() {
		let count = items!.count
		numberOfRows = (count < 2000 ? 10000 : count * 10)
		middleRow = ((numberOfRows / count) / 2) * count
	}

	open func index(atRow row: Int) -> Int {
		return (row % items!.count)
	}

	open func value(atRow row: Int) -> T {
		return items[index(atRow: row)]
	}

	open func row(atIndex index: Int) -> Int {
		return middleRow + index
	}

	// whenever the picker view comes to rest, we'll jump back to
	// the row with the current value that is closest to the middle
	open func pickerView(_ pickerView: UIPickerView, selectRow row: Int, inComponent component: Int) {
		let newRow = middleRow + (row % items!.count)
		pickerView.selectRow(newRow, inComponent: component, animated: false)
		NSLog("Resetting row to \(newRow)")
	}
	
}

