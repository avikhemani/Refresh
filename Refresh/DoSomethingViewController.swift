//
//  DoSomethingViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 2/21/21.
//

import UIKit
import CoreMotion

class DoSomethingViewController: UIViewController {
    
    private lazy var animator = UIDynamicAnimator()
    let behavior = TaskBehavior()
    private let motionManager = CMMotionManager()
    @IBOutlet weak var addTaskButton: UIButton! {
        didSet {
            addTaskButton.layer.cornerRadius = addTaskButton.frame.width/2
            addTaskButton.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        let currentTasks = userDefaults.array(forKey: "TaskArray") as? [String] ?? [String]()

        animator.addBehavior(behavior)
        for (i, taskJson) in currentTasks.enumerated() {
            let jsonDecoder = JSONDecoder()
            let task = try! jsonDecoder.decode(Task.self, from: taskJson.data(using: String.Encoding.utf8)!)
            
            let frame = CGRect(x: (i % 2) * 100, y: 100 + Int(i/2) * 200, width: task.width, height: task.height)
            let taskView = TaskView(frame: frame, task: task)
            view.addSubview(taskView)
            behavior.addItem(item: taskView)
        }
        
        motionManager.startDeviceMotionUpdates(to: .main) { (deviceMotion, error) in
            self.behavior.gravityBehavior.gravityDirection = CGVector(dx: deviceMotion?.attitude.roll ?? 1.0, dy: deviceMotion?.attitude.pitch ?? 1.0)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        behavior.collisionBehavior.addBoundary(withIdentifier: "Test" as NSCopying, for: UIBezierPath(rect: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-(tabBarController?.tabBar.frame.height ?? 40))))
    }
    
    @IBAction func addTask(bySegue: UIStoryboardSegue) {

    }
    


}
