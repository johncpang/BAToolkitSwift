//
//  BAGradientView.swift
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

// Source: http://codingangry.com/index.php/site/article/ios_gradent_with_transparency

import UIKit

@IBDesignable open class BAGradientView: UIView {

	@IBInspectable open var color: UIColor = .black {
		didSet { setNeedsDisplay() }
	}

	@IBInspectable open var direction: Int = 0 {
		didSet { setNeedsDisplay() }
	}

	private var startPoint: CGPoint!

	private var endPoint: CGPoint!

	override open func awakeFromNib() {
		super.awakeFromNib()
		isUserInteractionEnabled = false
		backgroundColor = .clear
	}

	func calculateStartAndEndPoints() {
		switch (direction) {
		case 3:
			// bottom
			startPoint = CGPoint.init(x: 0, y: 0)
			endPoint = CGPoint.init(x: 0, y: max(self.frame.height, 1))
		case 1:
			// left
			startPoint = CGPoint.init(x: 0, y: 0)
			endPoint = CGPoint.init(x: max(self.frame.width, 1), y: 0)
		case 2:
			// right
			startPoint = CGPoint.init(x: max(self.frame.width, 1), y: 0)
			endPoint = CGPoint.init(x: 0, y: 0)
		default:
			// top
			startPoint = CGPoint.init(x: 0, y: max(self.frame.height, 1))
			endPoint = CGPoint.init(x: 0, y: 0)
		}
	}

	override open func draw(_ rect: CGRect) {
		// draw gradient
		let maskColors: [CGFloat] = [
			0.0, 0.0, 0.0, 1.0,
			1.0, 1.0, 1.0, 1.0
		]
		calculateStartAndEndPoints()
		// Create an image of a solid slab in the desired color
		let frame = CGRect.init(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
		var context = UIGraphicsGetCurrentContext()
		context?.setFillColor(self.color.cgColor)
		context?.fill(frame)
		// UIGraphicsGetCurrentContext()!.fill(frame)
		let colorRef = UIGraphicsGetImageFromCurrentImageContext()?.cgImage

		// Create an image of a gradient from black to white
		let rgb = CGColorSpaceCreateDeviceRGB()
		let gradientRef = CGGradient(colorSpace: rgb,
									 colorComponents: maskColors,
									 locations: nil,
									 count: 2)
		// CGColorSpaceRelease(rgb)
		context?.drawLinearGradient(gradientRef!,
									start: startPoint,
									end: endPoint,
									options: [.drawsBeforeStartLocation,
											  .drawsAfterEndLocation])
		let maskRef = (UIGraphicsGetImageFromCurrentImageContext()?.cgImage)!
		UIGraphicsEndImageContext()

		// Blend the solid image and the gradient to produce the final gradient.
		let tmpMask = CGImage(
			maskWidth: maskRef.width,
			height: maskRef.height,
			bitsPerComponent: maskRef.bitsPerComponent,
			bitsPerPixel: maskRef.bitsPerPixel,
			bytesPerRow: maskRef.bytesPerRow,
			provider: maskRef.dataProvider!,
			decode: nil,
			shouldInterpolate: false)

		// Draw the resulting mask.
		context = UIGraphicsGetCurrentContext()
		context?.draw(colorRef!.masking(tmpMask!)!, in: rect)
		UIGraphicsEndImageContext()
	}

}
