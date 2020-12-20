//
//  DrawingController.swift
//  mobile development labs
//

import UIKit


class DrawingController: UIViewController {
	@IBOutlet weak var drawpad: DrawingView!
	@IBOutlet weak var selector: UISegmentedControl!

	@IBAction func trigger(_ sender: Any) {
		drawpad.state = ViewState(rawValue: selector.selectedSegmentIndex)!

		drawpad.setNeedsDisplay()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		NotificationCenter.default.addObserver(self, selector: #selector(trigger), name: UIDevice.orientationDidChangeNotification, object: nil)
	}
}
