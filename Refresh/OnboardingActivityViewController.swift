//
//  OnboardingActivityViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/14/21.
//

import UIKit

class OnboardingActivityViewController: UIViewController {

    private var tasks = [
        Task(name: "Go for a run outside", shape: .circle, color: .red, width: 180, height: 180),
        Task(name: "Talk with family and friends", shape: .square, color: .pBlue, width: 180, height: 180),
        Task(name: "Read a new book", shape: .triangle, color: .orange, width: 180, height: 180),
        Task(name: "Get ahead on work", shape: .circle, color: .purple, width: 180, height: 180)
    ]
    
    private var selectedTask: Int?
    private var customTask: String?
    
    @IBOutlet var taskButtons: [UIButton]!
    @IBOutlet weak var customButton: UIButton! {
        didSet {
            customButton.layer.cornerRadius = 10
            customButton.clipsToBounds = false
        }
    }
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.layer.cornerRadius = 20
            continueButton.clipsToBounds = true
        }
    }
    
    @IBOutlet var progressBars: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }
    
    private func loadUI() {
        for button in taskButtons {
            button.layer.cornerRadius = 20
            button.clipsToBounds = true
        }
        for view in progressBars {
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
        }
    }
    
    @IBAction func reasonButtonPress(_ sender: UIButton) {
        for (i, button) in taskButtons.enumerated() {
            button.outlineBorder(width: 0, color: .systemPink)
            button.backgroundColor = .systemGray6
            button.setTitleColor(.label, for: .normal)
            if button == sender {
                selectedTask = i
                customTask = nil
            }
        }
        customButton.setTitle("+ custom", for: .normal)
        customButton.outlineBorder(width: 0, color: .systemPink)
        
        sender.outlineBorder(width: 3, color: .systemPink)
        sender.setTitleColor(.systemPink, for: .normal)
        
    }
    
    @IBAction func customButtonPress(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Custom Task",
            message: "Type the task you want to do.",
            preferredStyle: .alert
        )
        alert.addTextField { (textField) in
            // nothing
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let textField = alert.textFields![0] as UITextField
            let taskText = textField.text ?? ""
            if taskText == "" {
                self.displayMessage(title: "Empty Task", message: "An empty task is not allowed.")
                return
            }
            
            for button in self.taskButtons {
                button.outlineBorder(width: 0, color: .systemPink)
                button.backgroundColor = .systemGray6
                button.setTitleColor(.label, for: .normal)
            }
            self.customButton.setTitle(taskText, for: .normal)
            self.customButton.outlineBorder(width: 3, color: .systemPink)
            self.customTask = taskText
            self.selectedTask = nil
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func continuePress(_ sender: UIButton) {
        if selectedTask == nil && customTask == nil {
            self.displayMessage(title: "Incomplete", message: "Please select one task")
            return
        }
        let newTask: Task
        if selectedTask != nil {
            newTask = tasks[selectedTask!]
        } else {
            newTask = Task(name: customTask!, shape: .circle, color: .blue, width: 180, height: 180)
        }
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(newTask)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let userDefaults = UserDefaults.standard
        var currentTasks = userDefaults.array(forKey: "TaskArray") as? [String] ?? [String]()

        currentTasks.append(json!)

        userDefaults.setValue(currentTasks, forKey: "TaskArray")
        
        self.performSegue(withIdentifier: "Submit Tasks Segue", sender: nil)
        
    }

    

}
