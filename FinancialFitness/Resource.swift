//
//  Resource.swift
//  FinancialFitness
//
//  Created by Ankit Jasuja on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class Resource: NSObject {

    var resourceId : String?
    var resourceType : String?
    var resourceName : String?
    var deleted : Bool?
    
    var videoUrlString : String?
    var goalType : String?
    
    var searchNearbyProviders : Bool?
    var searchTerm : String?
    var searchRadius : String?
    var searchSortBy : String?
}

enum ResourceType {
    
    case Progress
    case Completion
    case Video
    case Goal
    case Provider
    case Service
    case Tip
    case WebTool
    case CustomTool
    case Checklist
    case Explore
}