//
//  QuestionMapper.swift
//  FinancialFitness
//
//  Created by Ankit Jasuja on 9/25/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class QuestionMapper: NSObject {

    func toQuestions(questionsDictionary : NSDictionary) -> [Question] {
        var questions : [Question] = []
        let records = questionsDictionary["records"] as! [NSDictionary]
        for record in records {
            questions.append(toQuestion(record))
        }
        return questions
    }
    
    func toQuestion(questionDictionary : NSDictionary) -> Question {
        let question = Question()
        question.questionId = questionDictionary["Id"] as? String
        question.questionName = questionDictionary["Name"] as? String
        question.questionCustomId = questionDictionary["Question__c"] as? String
        return question
    }
    
}
