//
//  ViewController.swift
//  BlissWheel
//
//  Created by Ben Schwartz on 2/20/22.
//

import Cocoa

class ViewController: NSViewController {
    
    
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var field: NSTextField!
    @IBOutlet weak var buffer: NSProgressIndicator!
    
    @IBOutlet weak var benImageView: NSImageView!
    @IBOutlet weak var box: NSBox!
    override func viewDidLoad() {
        
        benImageView.isHidden = true;
        
        super.viewDidLoad()
        box.fillColor = NSColor.clear;
        // Do any additional setup after loading the view.
    }
    @IBAction func pressed(_ sender: Any) {
        
        // Before animate, reset the anchor point
        imageView.setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 0.5))
        // Start animation
        
        if let num = Double(field.stringValue) {
            
            if !(1...100).contains(num) { return }

            animate_rodder(period: 0.1, count: 40)

            buffer.startAnimation(self)
            
            let secondsToDelay = 3.7

            DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                self.buffer.stopAnimation(self)
                let randomInt = Double.random(in: 1..<100)
                if randomInt < num {
                    self.label.stringValue = "YES"
                    self.imageView.isHidden = true;
                    self.benImageView.isHidden = false;
                    self.box.fillColor = NSColor.systemGreen
                }
                else {
                    self.label.stringValue = "NO"
                    self.imageView.isHidden = true;
                    self.benImageView.isHidden = false;
                    self.box.fillColor = NSColor.red
                }
            }
        }
    }
    
    
    @IBAction func reset(_ sender: Any) {
        self.imageView.isHidden = false;
        self.benImageView.isHidden = true;
        box.fillColor = NSColor.clear;
        label.stringValue = ""
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


extension ViewController {
    
    
    
    func animate_rodder(period: Double, count: Float) {
        if imageView.layer?.animationKeys()?.count == 0 || imageView.layer?.animationKeys() == nil {
            let rotate = CABasicAnimation(keyPath: "transform.rotation")
            rotate.fromValue = 0
            rotate.toValue = CGFloat(-1 * .pi * 2.0)
            rotate.duration = period
            rotate.repeatCount = count
            imageView.layer?.add(rotate, forKey: "rotation")
        }
    }
    
}


extension NSView {
    func setAnchorPoint(anchorPoint:CGPoint) {
        if let layer = self.layer {
            var newPoint = NSPoint(x: self.bounds.size.width * anchorPoint.x, y: self.bounds.size.height * anchorPoint.y)
            var oldPoint = NSPoint(x: self.bounds.size.width * layer.anchorPoint.x, y: self.bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(layer.affineTransform())
        oldPoint = oldPoint.applying(layer.affineTransform())

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y


        layer.anchorPoint = anchorPoint
        layer.position = position
    }
}
}

