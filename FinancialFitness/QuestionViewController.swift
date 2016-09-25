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
           self.setUpQuestionAnswer(currentQuestion)
            } else {
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func setUpQuestionAnswer(question : Question){
        self.questionTextView.text = question.questionName
        self.forceClient.getAnswersByQuestionId(question.questionCustomId!, completion: { (answers, error) in
            self.answers = answers
            self.optionsTableView.reloadData()
        })
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
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        if self.currentQuestionIndex != (questions?.count)! - 1  {
        self.currentQuestionIndex += 1;
        let currentQuestion = questions![self.currentQuestionIndex]
        self.setUpQuestionAnswer(currentQuestion)
        } else {
            self.showAlert("Congratulations", message: "you have completed the survey!")
        }
    }
    
    func showAlert(title : NSString, message : NSString) {
        let alertController = UIAlertController(title: title as String, message:message as String, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
}
