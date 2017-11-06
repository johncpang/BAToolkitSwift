//
//  BAPageViewController.swift
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

open class BAPageViewController: UIPageViewController {

	var pages = [UIViewController]()

	override open func viewDidLoad() {
		super.viewDidLoad()
		self.dataSource = self
	}

	var currentIndex:Int {
		get {
			return pages.index(of: self.viewControllers!.first!)!
		}

		set {
			guard newValue >= 0,
				newValue < pages.count else {
					return
			}

			let vc = pages[newValue]
			let direction:UIPageViewControllerNavigationDirection = newValue > currentIndex ? .forward : .reverse
			self.setViewControllers([vc], direction: direction, animated: true, completion: nil)
		}
	}

	func disableBounceEffect() {
		for view in self.view.subviews {
			if let scrollView = view as? UIScrollView {
				scrollView.delegate = self
			}
		}
	}

}

extension BAPageViewController: UIPageViewControllerDataSource {

	open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		let currentIndex = pages.index(of: viewController)!
		return (currentIndex <= 0 ? nil : pages[currentIndex - 1])
	}

	open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		let currentIndex = pages.index(of: viewController)!
		return (currentIndex + 1 >= self.pages.count ? nil : pages[currentIndex + 1])
	}

}

// disable bounce effects

extension BAPageViewController: UIScrollViewDelegate {

	open func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
			scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
		} else if currentIndex == (viewControllers?.count)! - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
			scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
		}
	}

	open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		if currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
			scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
		} else if currentIndex == (viewControllers?.count)! - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
			scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
		}
	}

}
