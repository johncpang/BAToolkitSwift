//
//  BATableViewController.swift
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

// MARK: - class BATableViewController

open class BATableViewController: UITableViewController {

	override open func viewDidLoad() {
		super.viewDidLoad()
		removeEmptySeparators(fromTableView: self.tableView)
		tableView(self.tableView, enableAutoRowHeight: 44.0)
	}

	// MARK: - Navigations

	/**
	http://stackoverflow.com/a/26946596/3731039
	*/
	override open func performSegue(withIdentifier identifier: String, sender: Any?) {
		if (shouldPerformSegue(withIdentifier: identifier, sender: sender)) {
			super.performSegue(withIdentifier: identifier, sender: sender)
		}
	}

	// MARK: - UITableViewDelegate

	func tableView(_ tableView: UITableView, numberOfVisibleRows section: Int) -> Int {
		let count = super.tableView(tableView, numberOfRowsInSection: section)
		var hidden = 0
		for i in 0..<count {
			let indexPath = IndexPath.init(item: i, section: section)
			if (0 == super.tableView(tableView, heightForRowAt:indexPath)) {
				hidden += 1
			}
		}
		return (count - hidden)
	}

	override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		let count = self.tableView(tableView, numberOfVisibleRows: section)
		return (0 == count ? 0.1 : super.tableView(tableView, heightForHeaderInSection:section))
	}

	override open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		let count = self.tableView(tableView, numberOfVisibleRows: section)
		return (0 == count ? 0.1 : super.tableView(tableView, heightForFooterInSection:section))
	}

	override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let cell = super.tableView(tableView, cellForRowAt: indexPath)
		return (cell.isHidden ? 0 : UITableViewAutomaticDimension)
	}

	override open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let count = self.tableView(tableView, numberOfVisibleRows: section)
		return (0 == count && section != 0 ? nil : super.tableView(tableView, viewForHeaderInSection:section))
	}

	override open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let count = self.tableView(tableView, numberOfVisibleRows: section)
		return (0 == count ? nil : super.tableView(tableView, titleForHeaderInSection:section))
	}

}

