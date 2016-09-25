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
    let forceClient : ForceClient = ForceClient()
    
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
        print("selected ... \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let answerResource = answerResources![indexPath.row]
        let resourceType = answerResource.resourceType
        forceClient.getResourceById(answerResource.resourceCustomId!) { (resource, error) in
            if (resourceType == "Fin Ed Video") {
                self.performSegueWithIdentifier(Constants.RESOURCE_VEDIO_SEGUE, sender: resource)
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // no-op
        let segueIdentifier = segue.identifier
        let resource = sender as? Resource
        if (segueIdentifier == Constants.RESOURCE_VEDIO_SEGUE) {
            let resourceVedioViewController = segue.destinationViewController as! ResourceVedioViewController
            resourceVedioViewController.resource = resource
        }
    }
}
