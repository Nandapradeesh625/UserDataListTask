//
//  CustomButton.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    var selectedColor: UIColor?
    var unSelectedColor: UIColor?
    var handleSelectionColor: Bool?
    public var touchPadding = UIEdgeInsets.zero
    var badgeValue: String! = "" {
        didSet {
            self.layoutSubviews()
        }
    }
    
    private var badgeLayer: CAShapeLayer!
    
    //MARK:- View LifeCycle
    override init(frame: CGRect)  {
        super.init(frame: frame)
        
        self.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.awakeFromNib()
    }
    
    override func awakeFromNib() {
        self.drawBadgeLayer()
    }
    
    //MARK:- View Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        self.drawBadgeLayer()
        self.setNeedsDisplay()
    }
    
   //MARK:- Draw Badge
   private func drawBadgeLayer() {
        if self.badgeLayer != nil {
            self.badgeLayer.removeFromSuperlayer()
        }
        // Omit layer if text is nil
        if self.badgeValue == nil || self.badgeValue.count == 0 {
            return
        }
        //! Initial label text layer
        let labelText = CATextLayer()
        labelText.contentsScale = UIScreen.main.scale
        labelText.string = self.badgeValue.uppercased()
        labelText.fontSize = 14.0
        labelText.font = UIFont.systemFont(ofSize: 14)
        labelText.alignmentMode = CATextLayerAlignmentMode.center
        labelText.foregroundColor = UIColor.white.cgColor
        let labelString = self.badgeValue.uppercased() as String?
        let labelFont: UIFont = UIFont.systemFont(ofSize: 14)
        let attributes = [NSAttributedString.Key.font : labelFont]
        let w = self.frame.size.width
        let h = CGFloat(15.0)  // fixed height
        let labelWidth = min(w * 0.8, 10.0)    // Starting point
        let rect = labelString!.boundingRect(with: CGSize(width: labelWidth, height: h), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        let textWidth = round(rect.width * UIScreen.main.scale)
        labelText.frame = CGRect(x: 0 , y: 10, width: textWidth + 20, height: h)
        
        //! Initialize outline, set frame and color
        let shapeLayer = CAShapeLayer()
        shapeLayer.contentsScale = UIScreen.main.scale
        let frame: CGRect = labelText.frame
        let cornerRadius = CGFloat(5.0)
        let borderInset = CGFloat(-1.0)
        let aPath = UIBezierPath(roundedRect: frame.insetBy(dx: borderInset, dy: borderInset), cornerRadius: cornerRadius)
        
        shapeLayer.path = aPath.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.insertSublayer(labelText, at: 0)
        shapeLayer.frame = shapeLayer.frame.offsetBy(dx: w * 0.5, dy: 0.0)
        
        self.layer.insertSublayer(shapeLayer, at: 999)
        self.layer.masksToBounds = false
        self.badgeLayer = shapeLayer
    }
    
    override var isSelected: Bool {
        willSet {
            //Utility.sharedInstance.printData("changing from \(isSelected) to \(newValue)")
        }
        
        didSet {
            if(handleSelectionColor ?? false) {
                if(isSelected) {
                    self.backgroundColor = selectedColor
                }else {
                    self.backgroundColor = unSelectedColor
                }
                //Utility.sharedInstance.printData("changed from \(oldValue) to \(isSelected)")
            }
        }
    }
    
    @IBInspectable var vkCornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = vkCornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var vkBorderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = vkBorderColor.cgColor
            layer.masksToBounds = true
        }
    }
    
    
    @IBInspectable var vkSelectionColor: UIColor = UIColor.clear {
        didSet {
            selectedColor = vkSelectionColor
        }
    }
    
    @IBInspectable var vkUnselectionColor: UIColor = UIColor.clear {
        didSet {
            unSelectedColor = vkUnselectionColor
        }
    }
    
    @IBInspectable var vkNeedToHandleSelectionColor: Bool = false {
        didSet {
            handleSelectionColor = vkNeedToHandleSelectionColor
        }
    }


       @IBInspectable var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
       }

       @IBInspectable var borderColor: UIColor? {
           get {
               return UIColor(cgColor: layer.borderColor!)
           }
           set {
               layer.borderColor = newValue?.cgColor
           }
       }

       @IBInspectable
       var shadowRadius: CGFloat {
           get {
               return layer.shadowRadius
           }
           set {
               layer.masksToBounds = false
               layer.shadowRadius = newValue
           }
       }

       @IBInspectable
       var shadowOpacity: Float {
           get {
               return layer.shadowOpacity
           }
           set {
               layer.masksToBounds = false
               layer.shadowOpacity = newValue
           }
       }

       @IBInspectable
       var shadowOffset: CGSize {
           get {
               return layer.shadowOffset
           }
           set {
               layer.masksToBounds = false
               layer.shadowOffset = newValue
           }
       }

       @IBInspectable
       var shadowColor: UIColor? {
           get {
               if let color = layer.shadowColor {
                   return UIColor(cgColor: color)
               }
               return nil
           }
           set {
               if let color = newValue {
                   layer.shadowColor = color.cgColor
               } else {
                   layer.shadowColor = nil
               }
           }
       }
}
