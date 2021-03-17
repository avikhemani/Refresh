//
//  CompletedViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import UIKit

class CompletedViewController: UIViewController {
    
    var task: Task?
    private lazy var animator = UIDynamicAnimator(referenceView: view)
    let behavior = TaskBehavior()
    var isCompleted = true

    override func viewDidLoad() {
        super.viewDidLoad()
        behavior.dynamicItemBehavior.elasticity = 0.7
        
        let userDefaults = UserDefaults.standard
        let completedTasks = userDefaults.array(forKey: "CompletedArray") as? [String] ?? [String]()

        animator.addBehavior(behavior)
        for (i, taskJson) in completedTasks.enumerated() {
            let jsonDecoder = JSONDecoder()
            let task = try! jsonDecoder.decode(Task.self, from: taskJson.data(using: String.Encoding.utf8)!)
            
            var frame = CGRect(x: (i % 2) * 100, y: Int(view.frame.height) - 200 - Int(i/2) * 200, width: task.width, height: task.height)
            if i == completedTasks.count - 1 && isCompleted {
                self.task = task
                frame = CGRect(x: view.frame.width/2 - CGFloat(task.width/2), y: 0, width: CGFloat(task.width), height: CGFloat(task.height))
            }
            let taskView = TaskView(frame: frame, task: task)
            view.addSubview(taskView)
            behavior.addItem(item: taskView)
        }
    }
    
    

    @IBAction func homePress(_ sender: UIButton) {
        if isCompleted {
            self.performSegue(withIdentifier: "Return From Completed", sender: nil)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
