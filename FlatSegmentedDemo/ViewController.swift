//
//  ViewController.swift
//  FlatSegmentedDemo
//
//  Created by sameh on 8/25/17.
//  Copyright © 2017 Radvy. All rights reserved.
//

import UIKit
import FlatSegmented

class ViewController: UIViewController
{
    @IBOutlet weak var tabs: FlatSegmented!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        tabs.values = ["Items","info"]
        tabs.textColor = UIColor.gray
        tabs.selectedTextColor = UIColor.green
        tabs.underlineColor = UIColor.green
        tabs.underlineWeight = 2.0
        tabs.addTarget(self, action: #selector(printTabs), for: .valueChanged)
        tabs.makeSegment()
        
    }
    
    func printTabs()
    {
        print(tabs.selectedValue)
    }
    
}

