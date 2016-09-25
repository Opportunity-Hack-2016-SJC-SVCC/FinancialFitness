//
//  ForceClient.swift
//  FinancialFitness
//
//  Created by Ashish Mishra on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit
import Alamofire

class ForceClient: NSObject {

    
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
    
}
