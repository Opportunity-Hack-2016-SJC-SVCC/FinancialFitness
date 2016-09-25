//
//  AnswerResourceMapper.swift
//  FinancialFitness
//
//  Created by Ankit Jasuja on 9/25/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class AnswerResourceMapper: NSObject {

    func toAnswerResources(answerResourcesDictionary : NSDictionary) -> [AnswerResource] {
        var answerResources : [AnswerResource] = []
        let records = answerResourcesDictionary["records"] as! [NSDictionary]
        for record in records {
            answerResources.append(toAnswerResource(record))
        }
        return answerResources
    }
    
    func toAnswerResource(answerResourceDictionary : NSDictionary) -> AnswerResource {
        let answerResource = AnswerResource()
        answerResource.answerResourceId = answerResourceDictionary["Id"] as? String
        answerResource.answerResourceName = answerResourceDictionary["Name"] as? String
        answerResource.answerCustomId = answerResourceDictionary["Answer__c"] as? String
        answerResource.resourceCustomId = answerResourceDictionary["Resource__c"] as? String
        return answerResource
    }

}
