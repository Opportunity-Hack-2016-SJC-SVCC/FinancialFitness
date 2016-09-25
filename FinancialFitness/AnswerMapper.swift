//
//  AnswerMapper.swift
//  FinancialFitness
//
//  Created by Ankit Jasuja on 9/25/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class AnswerMapper: NSObject {

    func toAnswers(answersDictionary : NSDictionary) -> [Answer] {
        var answers : [Answer] = []
        let records = answersDictionary["records"] as! [NSDictionary]
        for record in records {
            answers.append(toAnswer(record))
        }
        return answers
    }
    
    func toAnswer(answerDictionary : NSDictionary) -> Answer {
        let answer = Answer()
        answer.answerId = answerDictionary["Id"] as? String
        answer.answerName = answerDictionary["Name"] as? String
        answer.answerCustomId = answerDictionary["Answer__c"] as? String
        return answer
    }
    
    func userDetails(userDictionary : NSDictionary) -> String {
        
        let users = userDictionary["records"] as? NSArray
        
        if users?.count > 0 {
           return "Success"
        } else {
            return "Failure"
        }
    }
    
    
}
