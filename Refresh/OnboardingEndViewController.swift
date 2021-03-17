//
//  OnboardingEndViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/14/21.
//

import UIKit

class OnboardingEndViewController: UIViewController {

    @IBOutlet weak var progressBar: UIView! {
        didSet {
            progressBar.layer.cornerRadius = 5
            progressBar.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.layer.cornerRadius = 20
            continueButton.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var firstTaskLabel: UILabel!
    @IBOutlet weak var makeMostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard
        let currentTasks = userDefaults.array(forKey: "TaskArray") as? [String] ?? [String]()

        if currentTasks.count == 0 { return }
        
        let taskJson = currentTasks[0]
        
        let jsonDecoder = JSONDecoder()
        let task = try! jsonDecoder.decode(Task.self, from: taskJson.data(using: String.Encoding.utf8)!)
        
        let frame = CGRect(x: view.frame.width/2 - 125, y: (makeMostLabel.frame.minY + firstTaskLabel.frame.maxY)/2 - 125, width: 250, height: 250)
        let taskView = TaskView(frame: frame, task: task)
        
        view.addSubview(taskView)
        
    }
    
    @IBAction func continuePress(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Onboarding Finish Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Onboarding Finish Segue" {
            if let tabBar = segue.destination as? UITabBarController {
                tabBar.selectedIndex = 1
            }
            UserDefaults.standard.setValue(true, forKey: "IsOldUser")
        }
    }

}
