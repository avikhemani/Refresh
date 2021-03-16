//
//  OnboardingReasonViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/14/21.
//

import UIKit

class OnboardingReasonViewController: UIViewController {
    
    private var selectedReason: String?
    
    @IBOutlet var reasonButtons: [UIButton]!
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
        for button in reasonButtons {
            button.layer.cornerRadius = 20
            button.clipsToBounds = true
        }
        for view in progressBars {
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
        }
    }
    
    @IBAction func reasonButtonPress(_ sender: UIButton) {
        for button in reasonButtons {
            button.outlineBorder(width: 0, color: .systemPink)
            button.backgroundColor = .systemGray6
            button.setTitleColor(.label, for: .normal)
        }
        sender.outlineBorder(width: 2, color: .systemPink)
        sender.setTitleColor(.systemPink, for: .normal)
        selectedReason = sender.accessibilityLabel
    }
    
    @IBAction func continuePress(_ sender: UIButton) {
        if selectedReason == nil {
            self.displayMessage(title: "Incomplete", message: "Please select a reason")
            return
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(selectedReason ?? "", forKey: "OnboardingReason")
        self.performSegue(withIdentifier: "Submit Reason Segue", sender: nil)
        
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
