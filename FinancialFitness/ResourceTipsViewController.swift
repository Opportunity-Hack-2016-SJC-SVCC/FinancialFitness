//
//  ResourceTipsViewController.swift
//  FinancialFitness
//
//  Created by Ashish Mishra on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class ResourceTipsViewController: UIViewController {
    
    @IBOutlet var tipSegmentedControl : UISegmentedControl!
    @IBOutlet var tipOptionsContainerView : UIView!
    
    var aboutTipResourceViewController : ResouceTipsAboutViewController?
    var resourceTipsRelatedViewController : ResourceRelatedViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tipSegmentedControl.selectedSegmentIndex = 0;
        // Do any additional setup after loading the view.
    }


    @IBAction func segmentvalueChanged(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "ResourceTips", bundle: nil)
        
        if sender.selectedSegmentIndex == 0 {
            
            self.aboutTipResourceViewController = storyboard.instantiateViewControllerWithIdentifier("ResouceTipsAboutViewController") as? ResouceTipsAboutViewController
            
            self.tipOptionsContainerView.addSubview((self.aboutTipResourceViewController?.view)!)
            
        } else if sender.selectedSegmentIndex == 1 {
            
            self.resourceTipsRelatedViewController = storyboard.instantiateViewControllerWithIdentifier("ResourceRelatedViewController") as? ResourceRelatedViewController
            
            self.tipOptionsContainerView.addSubview((self.resourceTipsRelatedViewController?.view)!)
            
        }
    }
}
