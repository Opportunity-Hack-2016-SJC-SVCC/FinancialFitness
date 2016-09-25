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
    var selectedAnswers : [Answer]? = []
    var answerResources : [AnswerResource] = []
    
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
        tableViewCell!.accessoryType = .None
        return tableViewCell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected ... \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let optionTableViewCell = tableView.cellForRowAtIndexPath(indexPath)
        if (optionTableViewCell?.accessoryType == .Checkmark) {
            optionTableViewCell!.accessoryType = .None
            removeAnswerSelection(answers![indexPath.row].answerId!)
        } else {
            optionTableViewCell!.accessoryType = .Checkmark
            selectedAnswers?.append(answers![indexPath.row])
        }
    }
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        if self.currentQuestionIndex != (questions?.count)! - 1  {
            let selectedAnswerIds = toAnswerIds(selectedAnswers!)
            forceClient.getQuestionsByAnswerIds(selectedAnswerIds, completion: { (questions, error) in
                // remove current question and insert new questions on the top
                print(questions)
                self.questions?.removeAtIndex(0)
                for question in questions! {
                  self.questions?.insert(question, atIndex: 0)
                }
            })
            forceClient.getAnswerResourcesByAnswerIds(selectedAnswerIds, completion: { (answerResources, error) in
                print(answerResources)
                if (answerResources != nil && answerResources?.count > 0) {
                    // segue to resources flow
                    self.performSegueWithIdentifier(Constants.QUESTION_TO_RESOURCE_SEGUE, sender: answerResources)
                }
            })
            self.currentQuestionIndex += 1;
            let currentQuestion = questions![self.currentQuestionIndex]
            self.setUpQuestionAnswer(currentQuestion)
        } else {
            self.showAlert("Congratulations", message: "you have completed the survey!")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueIdentifier = segue.identifier
        if segueIdentifier == Constants.QUESTION_TO_RESOURCE_SEGUE {
            let resourceViewController = segue.destinationViewController as! ResourceViewController
            if let sender = sender {
                let answerResources = sender as! [AnswerResource]
                resourceViewController.answerResources = answerResources
            }
            // might have to set delegate here
        }
    }
    
    private func showAlert(title : NSString, message : NSString) {
        let alertController = UIAlertController(title: title as String, message:message as String, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func removeAnswerSelection(answerId : String) {
        var currentIndex : Int = 0
        for selectedAnswer in selectedAnswers! {
            if (selectedAnswer.answerId == answerId) {
                selectedAnswers?.removeAtIndex(currentIndex)
            }
            currentIndex += 1
        }
    }
    
    private func toAnswerIds(answers : [Answer]) -> [String] {
        var answerIds : [String] = []
//        answerIds.append("a0441000001M9P9")
        for answer in answers {
            answerIds.append(answer.answerCustomId!)
        }
        return answerIds
    }
}
