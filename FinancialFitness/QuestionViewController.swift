//
//  QuestionViewController.swift
//  FinancialFitness
//
//  Created by Ashish Mishra on 9/24/16.
//  Copyright © 2016 Ashish Mishra. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var questionTextView : UITextView!
    @IBOutlet var optionsTableView : UITableView!
    
    var questions : [Question]? = []
    var answers : [Answer]? = []
    var currentQuestionIndex : Int = 0
    
    let forceClient : ForceClient = ForceClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forceClient.getAllQuestions { (questions, error) in
            if error == nil {
                self.questions = questions
                let currentQuestion = questions![self.currentQuestionIndex]
                self.questionTextView.text = currentQuestion.questionName
                self.forceClient.getAnswersByQuestionId(currentQuestion.questionCustomId!, completion: { (answers, error) in
                    self.answers = answers
                    self.optionsTableView.reloadData()
                })
            } else {
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (answers?.count)!
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCellWithIdentifier("QuestionOptionCell")
        tableViewCell?.textLabel?.text = answers![indexPath.row].answerName
        return tableViewCell!;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    
    
  
    

}
