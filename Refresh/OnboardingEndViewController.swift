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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
