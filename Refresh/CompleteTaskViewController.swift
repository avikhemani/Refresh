//
//  CompleteTaskViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import UIKit

class CompleteTaskViewController: UIViewController {
    
    var task: Task?
    var taskView: TaskView!

    @IBOutlet weak var completedButton: UIButton! {
        didSet {
            completedButton.layer.cornerRadius = 15
            completedButton.clipsToBounds = true
            completedButton.alpha = 0
        }
    }
    
    @IBOutlet weak var laterButton: UIButton! {
        didSet {
            laterButton.alpha = 0
        }
    }
    
    @IBOutlet weak var instructionsLabel: UILabel! {
        didSet {
            instructionsLabel.alpha = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let frame = CGRect(x: (view.frame.width/2) - (CGFloat(task!.width)/2), y: view.frame.height-CGFloat(task!.height), width: CGFloat(task!.width), height: CGFloat(task!.height))
        taskView = TaskView(frame: frame, task: task!)
        view.addSubview(taskView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(taskTap(sender:)))
        taskView.addGestureRecognizer(tapGesture)
        
        UIView.animate(withDuration: 0.8) {
            self.taskView.frame = CGRect(x: (self.view.frame.width/2) - (CGFloat(self.task!.width)/2), y: self.view.frame.height/3, width: CGFloat(self.task!.width), height: CGFloat(self.task!.height))
        } completion: { (completed) in
            UIView.animate(withDuration: 0.4) {
                self.instructionsLabel.alpha = 1.0
            } completion: { (completed) in
                UIView.animate(withDuration: 0.4) {
                    self.completedButton.alpha = 1.0
                } completion: { (completed) in
                    UIView.animate(withDuration: 0.4) {
                        self.laterButton.alpha = 1.0
                    }
                }
            }
        }
        
    }
    
    @IBAction func completedPress(_ sender: UIButton) {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self.task!)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let userDefaults = UserDefaults.standard
        var currentTasks = userDefaults.array(forKey: "TaskArray") as? [String] ?? [String]()
        if let index = currentTasks.firstIndex(of: json ?? "") {
            currentTasks.remove(at: index)
        }
        userDefaults.setValue(currentTasks, forKey: "TaskArray")
        
        var completedTasks = userDefaults.array(forKey: "CompletedArray") as? [String] ?? [String]()
        completedTasks.append(json!)
        userDefaults.setValue(completedTasks, forKey: "CompletedArray")
        
        UIView.animate(withDuration: 0.5) {
            self.taskView.frame = CGRect(x: (self.view.frame.width/2) - (CGFloat(self.task!.width)/2), y: CGFloat(-self.task!.height), width: CGFloat(self.task!.width), height: CGFloat(self.task!.height))
        } completion: { (completed) in
            self.performSegue(withIdentifier: "Completed Task Segue", sender: nil)
        }
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @objc func taskTap(sender: UITapGestureRecognizer) {
        let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactGenerator.impactOccurred()
    }
    
}
