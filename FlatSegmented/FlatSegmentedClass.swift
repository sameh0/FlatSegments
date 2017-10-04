//
//  customSegmented.swift
//  GotLikes
//
//  Created by sameh on 7/16/17.
//  Copyright © 2017 Atiaf. All rights reserved.
//

import Foundation
import UIKit

public class FlatSegmented:UIControl{
    
    public var selectedValue = 0
    public var defaultValue:Int = 0
    public var underlineWeight:CGFloat = 1
    public var values:[String]?
    public var textColor:UIColor = UIColor.black
    public var underlineColor:UIColor = UIColor.blue
    public var selectedTextColor:UIColor?
    
    
    var segments = [UIButton]()
    var underline = UIView()
    var underlineHorizontalConstraint = NSLayoutConstraint()
    var underlineVerticalConstraint = NSLayoutConstraint()
    var underlineHeightConstraint = NSLayoutConstraint()
    var underlineWidthConstraint = NSLayoutConstraint()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    
    public func makeSegment(){
        guard let values = self.values as [String]?  else { return }
        
        for (index,value) in values.enumerated() {
            
            let button = UIButton()
            var horizontalConstraint:NSLayoutConstraint
            
            if index == 0 {
                horizontalConstraint = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            }
            else
            {
                horizontalConstraint = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: segments[index - 1 ], attribute: .trailing, multiplier: 1, constant: 0)
            }
            
            
            let verticalConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            
            let wMultiplier = (Double(Double(1) / Double(values.count)))
            let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: CGFloat(wMultiplier), constant: 0)
            
            let heightConstraint = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
            
            button.setTitle(value, for: .normal)
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .center
            button.setTitleColor(textColor, for: .normal)
            
            button.tag = index
            segments.append(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            self.addSubview(button)
            self.addConstraints(
                [horizontalConstraint,verticalConstraint,widthConstraint,heightConstraint]
            )
        }
        addUnderlineForFirstSegment()
    }
    
    func addUnderlineForFirstSegment()  {
        underline.removeFromSuperview()
        guard defaultValue <= values!.count else {
            return
        }
        
        let x = defaultValue
        
        underlineHorizontalConstraint = NSLayoutConstraint(item: underline, attribute: .leading, relatedBy: .equal, toItem: segments[x], attribute: .leading, multiplier: 1, constant: 0)
        
        underlineVerticalConstraint = NSLayoutConstraint(item: underline, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        let multiplier = CGFloat(1 / CGFloat(values!.count))
        
        underlineWidthConstraint = NSLayoutConstraint(item: underline, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: multiplier  , constant: 0)
        
        underlineHeightConstraint = NSLayoutConstraint(item: underline, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: underlineWeight)
        
        underline.backgroundColor = underlineColor
        underline.translatesAutoresizingMaskIntoConstraints = false
        
        let selectedButton = segments[defaultValue]
        selectedButton.setTitleColor(selectedTextColor, for: .normal)
        
        self.addSubview(underline)
        self.addConstraints([
            underlineHorizontalConstraint,underlineVerticalConstraint
            ,underlineWidthConstraint,underlineHeightConstraint
            ])
    }
    
    func changeUnderlinePosition(button:UIButton){
        let x  = button.tag
        
        self.removeConstraint(underlineHorizontalConstraint)
        underlineHorizontalConstraint = NSLayoutConstraint(item: underline, attribute: .leading, relatedBy: .equal, toItem: segments[x], attribute: .leading, multiplier: 1, constant: 0)
        self.addConstraint(underlineHorizontalConstraint)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
        })
    }
    
    @objc public func buttonAction(sender: UIButton) {
        changeUnderlinePosition(button: sender)
        selectedValue = sender.tag
        self.sendActions(for: .valueChanged)
        
        guard selectedTextColor != nil else{ return }
        for segment in segments {
            segment.setTitleColor(textColor, for: .normal)
        }
        sender.setTitleColor(selectedTextColor, for: .normal)
        
        
    }
    
    
}
