//
//  ForceClient.swift
//  FinancialFitness
//
//  Created by Ashish Mishra on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit
import Alamofire

let baseForceUrl = "https://na35.salesforce.com/services/data/v37.0/sobjects/"

let accessToken = "Bearer 00D41000000GYQ7!AQ8AQGdbg_ONWA00KiWmLL6qYzLxqV5ixnF7rM4FtICEhpKkzTLUbl2jWRAGDH.jDOQ.m6D.FlZ1NmWPe7BR7Xnc029JFZGd"

class ForceClient: NSObject {

    var questionMapper : QuestionMapper = QuestionMapper()
    var answerMapper : AnswerMapper = AnswerMapper()
    var answerResourceMapper : AnswerResourceMapper = AnswerResourceMapper()
    var resourceMapper : ResourceMapper = ResourceMapper()
    
    func createRequest() -> NSMutableURLRequest {
        let request = NSMutableURLRequest()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer AQ8AQGdbg_ONWA00KiWmLL6qYzLxqV5ixnF7rM4FtICEhpKkzTLUbl2jWRAGDH.jDOQ.m6D.FlZ1NmWPe7BR7Xnc029JFZGd", forHTTPHeaderField: "Authorization")
        return request
    }

    func createUrl(urlString : String) -> NSURL? {
        let url = NSURL(string: urlString)
        return url
    }
    
    static func getContactById() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://na35.salesforce.com/services/data/v37.0/sobjects/Contact/00341000003oBot")!)
        request.HTTPMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer 00D41000000GYQ7!AQ8AQG0xVv6sZUnwqJfLZitvpJWzuY4pdxALU0pMlkZZLpM9.uYoKc5l5BvazfRF7ZfA62XV.aSxXu0XM5RsPKjV4r8i8K.4", forHTTPHeaderField: "Authorization")
                
        Alamofire.request(request).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                print(responseData)
                //completionHandler(response: responseData.response, error: nil)
            }
        }
    }
    
    //===================== Questions =========================
    func getAllQuestions(completion : (questions : [Question]?, error : NSError?) -> Void) {
        let urlString = "https://na35.salesforce.com/services/data/v37.0/query/?q=Select+Id,IsDeleted,Name,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,Question__c,Language__c+FROM+Language_Question__c+WHERE+Question__r.Include_Question_on_Main_Flow__c=true+and+Language__c='English'+ORDER+BY+Question__r.Order__c"
        let request = createRequest()
        request.URL = createUrl(urlString)
        Alamofire.request(request).responseJSON { (response) -> Void in
            if((response.result.value) != nil) {
                print(response)
                if (response.result.isSuccess) {
                    let responseDictionary = response.result.value as! NSDictionary
                    completion(questions: self.questionMapper.toQuestions(responseDictionary), error: nil)
                } else {
                    completion(questions: nil, error: response.result.error)
                }
            }
        }
    }
    
    //===================== Answers =========================
    func getAnswersByQuestionId(questionCustomId : String, completion : (answers : [Answer]?, error : NSError?) -> Void) {
        let urlString = "https://na35.salesforce.com/services/data/v37.0/query/?q=Select+Id,IsDeleted,Name,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,Answer__c,Language__c+FROM+Language_Answer__c+WHERE+Answer__r.Question__c='\(questionCustomId)'+and+Language__c=+'English'+ORDER+BY+Answer__r.Order__c"
        let request = createRequest()
        request.URL = createUrl(urlString)
        Alamofire.request(request).responseJSON { (response) -> Void in
            if((response.result.value) != nil) {
                print(response)
                if (response.result.isSuccess) {
                    let responseDictionary = response.result.value as! NSDictionary
                    completion(answers: self.answerMapper.toAnswers(responseDictionary), error : nil)
                } else {
                    completion(answers: nil, error: response.result.error)
                }
            }
        }
    }
    
    //===================== Answer Resources =========================
    
    func getAnswerResourcesByAnswerIds(answerIds : [String], completion : (answerResources : [AnswerResource]?, error : NSError?) -> Void) {
        let answerIdsDelimited = "'" + answerIds.joinWithSeparator("','") + "'"
        let urlString = "https://na35.salesforce.com/services/data/v37.0/query/?q=Select+Id,IsDeleted,Name,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,Resource__r.RecordType.Name,Resource__c,Answer__c+from+Fin_Fit_Answer_Resource__c+where+Answer__c+in+(\(answerIdsDelimited))"
        let request = createRequest()
        request.URL = createUrl(urlString)
        Alamofire.request(request).responseJSON { (response) -> Void in
            if((response.result.value) != nil) {
                print(response)
                if (response.result.isSuccess) {
                    let responseDictionary = response.result.value as! NSDictionary
                    completion(answerResources : self.answerResourceMapper.toAnswerResources(responseDictionary), error : nil)
                } else {
                    completion(answerResources: nil, error: response.result.error)
                }
            }
        }
    }
    
    //===================== Answer Questions =========================
    
    func getQuestionsByAnswerIds(answerIds : [String], completion : (questions : [Question]?, error : NSError?) -> Void) {
        let answerIdsDelimited = "'" + answerIds.joinWithSeparator("','") + "'"
        let urlString = "https://na35.salesforce.com/services/data/v37.0/query/?q=Select+Id,IsDeleted,Question__r.Max_Answers_to_Select__c,Question__r.Min_Answers_to_Select__c,Name,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,Question__c,Language__c+FROM+Language_Question__c+WHERE+Question__r.Parent_Answer__c+in+(\(answerIdsDelimited))+and+Language__c=+'English'+ORDER+BY+Question__r.Order__c"
        let request = createRequest()
        request.URL = createUrl(urlString)
        Alamofire.request(request).responseJSON { (response) -> Void in
            if((response.result.value) != nil) {
                print(response)
                if (response.result.isSuccess) {
                    let responseDictionary = response.result.value as! NSDictionary
                    completion(questions : self.questionMapper.toQuestions(responseDictionary), error : nil)
                } else {
                    completion(questions: nil, error: response.result.error)
                }
            }
        }
    }

    //===================== Login & SignUp =========================
    
    func signUpUserWithparameters(signUpparameters : NSDictionary, completion : (response : AnyObject?, error : NSError?) -> Void) {
        
        let urlString = "https://na35.salesforce.com/services/data/v37.0/sobjects/Contact/"
        let request = createRequest()
        request.URL = createUrl(urlString)
        request.HTTPMethod = "POST"
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(signUpparameters, options:[])
        
        request.HTTPBody = jsonData
        
        Alamofire.request(request).responseJSON { (response) -> Void in
            if((response.result.value) != nil) {
                print(response)
                if (response.result.isSuccess) {
                    let responseDictionary = response.result.value as! NSDictionary
                    completion(response: "Success", error : nil)
                } else {
                    completion(response: nil, error: response.result.error)
                }
            }
        }
        
    }
    
    func validateLogin(userEmailId : String, completion : (response : AnyObject?, error : NSError?) -> Void){
        
        let urlString = "https://na35.salesforce.com/services/data/v37.0/query/?q=SELECT+email+from+contact+where+email='\(userEmailId)'"
        let request = createRequest()
        request.URL = createUrl(urlString)
        request.HTTPMethod = "GET"
        
        Alamofire.request(request).responseJSON { (response) -> Void in
            if((response.result.value) != nil) {
                print(response)
                if (response.result.isSuccess) {
                    let responseDictionary = response.result.value as! NSDictionary
                    completion(response: self.answerMapper.userDetails(responseDictionary), error : nil)
                } else {
                    completion(response: nil, error: response.result.error)
                }
            }
        }
        
    }
    
    //===================== Resource =========================
    func getResourceById(resourceId : String, completion : (resource : Resource?, error : NSError?) -> Void) {
        let urlString = "https://na35.salesforce.com/services/data/v37.0/sobjects/Fin_Fit_Resource__c/\(resourceId)"
        let request = createRequest()
        request.URL = createUrl(urlString)
        Alamofire.request(request).responseJSON { (response) -> Void in
            if((response.result.value) != nil) {
                print(response)
                if (response.result.isSuccess) {
                    let responseDictionary = response.result.value as! NSDictionary
                    completion(resource : self.resourceMapper.toResource(responseDictionary), error : nil)
                } else {
                    completion(resource: nil, error: response.result.error)
                }
            }
        }
    }

    
 }
