import UIKit
import PlaygroundSupport

final class CustomView: UIView {
	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else { return }

		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let color = CGColor(colorSpace: colorSpace, components: [1, 1, 1, 1])!

		context.setFillColor(color)
		context.fill(bounds)

		// Zoom out
		context.translateBy(x: bounds.midX, y: bounds.midY)
		context.scaleBy(x: 0.5, y: 0.5)
		context.translateBy(x: -bounds.midX, y: -bounds.midY)

		// Flip horizontally
//		context.translateBy(x: bounds.midX, y: bounds.midY)
//		context.scaleBy(x: -1, y: 1)
//		context.translateBy(x: -bounds.midX, y: -bounds.midY)

		drawGrid(context)

		// Rotate -45°
		context.translateBy(x: bounds.midX, y: bounds.midY)
		context.rotate(by: .pi / -4)
		context.translateBy(x: -bounds.midX, y: -bounds.midY)

		drawGrid(context)

		// Draw blue square
		context.setFillColor(CGColor(colorSpace: colorSpace, components: [0, 0, 1, 1])!)
		context.fill(CGRect(x: 60, y: 60, width: 200, height: 200))

		// Rotate 45° (back to regular)
		context.translateBy(x: bounds.midX, y: bounds.midY)
		context.rotate(by: .pi / 4)
		context.translateBy(x: -bounds.midX, y: -bounds.midY)

		// Draw green square
		context.setFillColor(CGColor(colorSpace: colorSpace, components: [0, 1, 0, 0.5])!)
		context.fill(CGRect(x: 60, y: 60, width: 200, height: 200))

		// Draw yellow square
		context.setFillColor(CGColor(colorSpace: colorSpace, components: [1, 1, 0, 0.5])!)
		context.fill(CGRect(x: 300, y: 300, width: 20, height: 20))
	}

	func drawGrid(_ context: CGContext) {
		context.saveGState()

		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let color = CGColor(colorSpace: colorSpace, components: [0, 0, 0, 0.2])!
		context.setStrokeColor(color)
		context.setLineWidth(2)

		// Stroke the border
		context.stroke(bounds)

		// Draw a line ever 20pt
		let increment: CGFloat = 20

		for x in 1..<Int(bounds.height / increment) {
			// Vertical line
			context.move(to: CGPoint(x: CGFloat(x) * increment, y: 0))
			context.addLine(to: CGPoint(x: CGFloat(x) * increment, y: bounds.height))

			for y in 1..<Int(bounds.width / increment) {
				// Horizontal line
				context.move(to: CGPoint(x: 0, y: CGFloat(y) * increment))
				context.addLine(to: CGPoint(x: bounds.width, y: CGFloat(y) * increment))
			}
		}

		// Stroke grid
		context.strokePath()

		// Draw top left red square
		context.setFillColor(CGColor(colorSpace: colorSpace, components: [1, 0, 0, 0.5])!)
		context.fill(CGRect(x: 0, y: 0, width: increment, height: increment))

		context.restoreGState()
	}
}

PlaygroundPage.current.liveView = CustomView(frame: CGRect(x: 0, y: 0, width: 320, height: 320))
