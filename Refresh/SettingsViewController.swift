//
//  SettingsViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/17/21.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func feedbackPress(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["avi@habitatapp.co"])
            mail.setSubject("Feedback for Refresh")
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    @IBAction func reportBugPress(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["avi@habitatapp.co"])
            mail.setSubject("Report a Bug in Refresh")
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func backButtonPress(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
