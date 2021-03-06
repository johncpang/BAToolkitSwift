//
//  BAViewControllerWithTable.swift
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

open class BAViewControllerWithTable: BAViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak open var tableView: UITableView!

	weak open var refreshControl: UIRefreshControl!

	override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
    override open func viewDidLoad() {
        super.viewDidLoad()
		removeEmptySeparators(fromTableView: self.tableView)
	}
	
	open func setupRefreshControl() {
		// http://stackoverflow.com/questions/12497940/uirefreshcontrol-without-uitableviewcontroller
		let tableViewController = UITableViewController.init()
		tableViewController.tableView = self.tableView

		let refreshControl = UIRefreshControl.init()
		refreshControl.setTitleAsDefault()
		refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
		tableViewController.refreshControl = refreshControl
		self.refreshControl = refreshControl
	}

	open func showRefreshControl(_ refreshControl: UIRefreshControl) {
		let offset = self.tableView.contentOffset
		self.tableView.setContentOffset(
			CGPoint(x: offset.x,
					y: offset.y - refreshControl.frame.size.height),
			animated: true)
		refreshControl.beginRefreshing()
	}

	@objc open func pullToRefresh(_ refreshControl: UIRefreshControl) {
		// to be implemented by subclass
	}

	// MARK: - UITableViewDataSource

	open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

	open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell.init(style: .default, reuseIdentifier: nil)
	}

	// MARK: - UITableViewDelegate

}
