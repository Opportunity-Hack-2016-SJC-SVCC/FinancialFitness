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
        return (answerResources?.count)!
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let resourceTableViewCell = tableView.dequeueReusableCellWithIdentifier("ResourceTableViewCell") as! ResourcesTableViewCell
        let answerResource = answerResources![indexPath.row]
        resourceTableViewCell.resourceTypeLabel.text = "Vedio"
        resourceTableViewCell.resourceDescriptionlabel.text = answerResource.answerResourceName
        return resourceTableViewCell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }


}
