//
//
//  Created by sameh on 7/16/17.
//  Copyright © 2017 Sameh Sayed. All rights reserved.
//

import Foundation
import UIKit

public class FlatSegmented:UIControl
{
    public var selectedValue = 0
    public var defaultValue:Int = 0
    public var underlineWeight:CGFloat = 1
    public var values:[String]?
    public var textColor:UIColor = UIColor.black
    public var underlineColor:UIColor = UIColor.blue
    public var selectedTextColor:UIColor?
    public var font:UIFont?
    public var allowUnderline = true

    var segments = [UIButton]()
    var underline = UIView()
    var underlineHorizontalConstraint = NSLayoutConstraint()
   
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    public func makeSegment(){
        guard let values = self.values as [String]?  else { return }
        
        for (index,value) in values.enumerated()
        {
            let button:UIButton =
            {
               let button = UIButton()
                var leadingControl:NSLayoutAnchor<NSLayoutXAxisAnchor>?
                button.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(button)
                if index == 0
                {
                    leadingControl = self.leadingAnchor
                }
                else
                {
                    leadingControl = segments[index - 1 ].trailingAnchor
                }
                let wMultiplier = (CGFloat(Double(1) / Double(values.count)))
                
                button.leadingAnchor.constraint(equalTo: leadingControl!).isActive = true
                button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: wMultiplier).isActive = true
                button.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
                
                button.setTitle(value, for: .normal)
                button.contentHorizontalAlignment = .center
                button.contentVerticalAlignment = .center
                button.setTitleColor(textColor, for: .normal)
                
                if let font = font
                {
                    button.titleLabel?.font = font
                }
                
                button.tag = index
                return button
            }()
    
            segments.append(button)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)

        }
        if allowUnderline
        {
            addUnderlineForFirstSegment()
        }
        
        //Set default button
        let selectedButton = segments[defaultValue]
        selectedButton.setTitleColor(selectedTextColor, for: .normal)
    }
    
    func addUnderlineForFirstSegment()
    {
        underline.removeFromSuperview()
        guard defaultValue <= values!.count else {
            return
        }
        
        let x = defaultValue
        
        underline.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(underline)

        //Constraints
        underlineHorizontalConstraint = underline.leadingAnchor.constraint(equalTo: segments[x].leadingAnchor)
        underlineHorizontalConstraint.isActive = true
        
        underline.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        let multiplier = CGFloat(1 / CGFloat(values!.count))
        
        underline.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true

        underline.heightAnchor.constraint(equalToConstant: underlineWeight).isActive = true

        underline.backgroundColor = underlineColor

        
    }
    
    func changeUnderlinePosition(button:UIButton)
    {
        underlineHorizontalConstraint.isActive = false
        underlineHorizontalConstraint = underline.leadingAnchor.constraint(equalTo: button.leadingAnchor)
        underlineHorizontalConstraint.isActive = true
        
        UIView.animate(withDuration: 0.1, animations:
        {
            self.layoutIfNeeded()
        })
    }
    
    @objc public func buttonAction(sender: UIButton)
    {
        if allowUnderline
        {
            changeUnderlinePosition(button: sender)
        }
        
        changeUnderlinePosition(button: sender)
        selectedValue = sender.tag
        self.sendActions(for: .valueChanged)
        
        guard selectedTextColor != nil else{ return }
        segments.forEach{   $0.setTitleColor(textColor, for: .normal)   }
        sender.setTitleColor(selectedTextColor, for: .normal)
    }
    
    
}
