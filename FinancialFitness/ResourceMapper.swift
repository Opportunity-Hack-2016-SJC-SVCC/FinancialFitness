//
//  ResourceMapper.swift
//  FinancialFitness
//
//  Created by Ankit Jasuja on 9/25/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class ResourceMapper: NSObject {

    func toResource(resourceDictionary : NSDictionary) -> Resource {
        let resource = Resource()
        resource.resourceId = resourceDictionary["Id"] as? String
        resource.resourceName = resourceDictionary["Name"] as? String
        resource.videoUrlString = resourceDictionary["URL__c"] as? String
        return resource
    }

    
}
