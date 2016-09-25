//
//  ResourceViewController.swift
//  FinancialFitness
//
//  Created by Ashish Mishra on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class ResourceViewController: UIViewController {
    
    @IBOutlet var resourceTableView : UITableView!

    var answerResources : [AnswerResource]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var tableViewCell = tableView.dequeueReusableCellWithIdentifier("ResourceTableViewCell") as! ResourcesTableViewCell
        tableViewCell.resourceTypeLabel.text = "ResourceType"
        tableViewCell.resourceDescriptionlabel.text = "Resource Description"
        
        return tableViewCell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }


}
