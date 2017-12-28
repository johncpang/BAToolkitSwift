//
//  Bundle+Language.swift
//
//  Created by John on 2017-12-5.
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

private var kBundleKey: UInt8 = 0

class BundleEx: Bundle {

	override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
		if let bundle = objc_getAssociatedObject(self, &kBundleKey) {
			return (bundle as! Bundle).localizedString(forKey: key, value: value, table: tableName)
		}
		return super.localizedString(forKey: key, value: value, table: tableName)
	}

}

extension Bundle {

	static let once: Void = {
		object_setClass(Bundle.main, type(of: BundleEx()))
	}()

	class func setLanguage(_ language: String?) {
		Bundle.once
		let isLanguageRTL = Bundle.isLanguageRTL(language)
		if (isLanguageRTL) {
			UIView.appearance().semanticContentAttribute = .forceRightToLeft
		} else {
			UIView.appearance().semanticContentAttribute = .forceLeftToRight
		}
		UserDefaults.standard.set(isLanguageRTL, forKey: "AppleTextDirection")
		UserDefaults.standard.set(isLanguageRTL, forKey: "NSForceRightToLeftWritingDirection")
		UserDefaults.standard.synchronize()

		let value = (language != nil ? Bundle.init(path: (Bundle.main.path(forResource: language, ofType: "lproj"))!) : nil)
		objc_setAssociatedObject(Bundle.main, &kBundleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

	class func isLanguageRTL(_ languageCode: String?) -> Bool {
		return (languageCode != nil && Locale.characterDirection(forLanguage: languageCode!) == .rightToLeft)
	}

}

