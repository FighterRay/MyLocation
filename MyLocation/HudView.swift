//
//  HudView.swift
//  MyLocations
//
//  Created by 张润峰 on 2016/12/1.
//  Copyright © 2016年 FighterRay. All rights reserved.
//

import UIKit

class HudView: UIView {

    var text = ""
    
    // Convinience constructor
    class func hud(inView view: UIView, animated: Bool) -> HudView {
        let hudView = HudView(frame: view.bounds)
        
        view.addSubview(hudView)
        view.isUserInteractionEnabled = false
        
        hudView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        hudView.show(animated: true)

        return hudView
    }
    
    override func draw(_ rect: CGRect) {
        let boxWidth:CGFloat = 95
        let boxHeight:CGFloat = 95
        
        let boxRect = CGRect(x: round((bounds.size.width - boxWidth) / 2),
                             y: round((bounds.size.height - boxHeight) / 2),
                             width: boxWidth,
                             height: boxHeight)
        
        let roundedRect = UIBezierPath(roundedRect: boxRect, cornerRadius: 10)
        
        UIColor(white: 0.3, alpha: 0.8).setFill()
        roundedRect.fill()
        
        // Add checkmark image
        if let image = UIImage(named: "checkmark") {
            let imagePoint = CGPoint(x: center.x - image.size.width / 2,
                                     y: center.y - image.size.height / 2 - boxHeight / 8)
            image.draw(at: imagePoint)
        }
        
        // Add text
        let attribs = [ NSFontAttributeName: UIFont.systemFont(ofSize: 16),
                        NSForegroundColorAttributeName: UIColor.white]
        let textSize = text.size(attributes: attribs)
        
        let textPoint = CGPoint(x: center.x - round(textSize.width / 2),
                                y: center.y - round(textSize.height / 2) + boxHeight / 4)
        
        text.draw(at: textPoint, withAttributes: attribs)
    }
    
    func show(animated: Bool) {
        if animated {
            alpha = 0
            transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: { 
                self.alpha = 1
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }

}
