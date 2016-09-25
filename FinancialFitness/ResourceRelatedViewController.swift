//
//  ResourceRelatedViewController.swift
//  FinancialFitness
//
//  Created by Ashish Mishra on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class ResourceRelatedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var relatedResourceTableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableVieCell = tableView.dequeueReusableCellWithIdentifier("RelatedResourceCell")! as UITableViewCell
        
        tableVieCell.textLabel?.text = "Sample";
        
        return tableVieCell
        
        
    }

}
