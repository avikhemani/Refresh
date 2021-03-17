//
//  JournalEntryViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import UIKit

class JournalEntryViewController: UIViewController {
    
    var journal: Journal?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var intentionalityLabel: UILabel!
    @IBOutlet weak var intentionalityBackBar: UIView!
    @IBOutlet weak var intentionalityFrontBar: UIView!
    @IBOutlet weak var frontBarWidth: NSLayoutConstraint!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var additionalNotesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
    }
    
    private func loadUI() {
        dateLabel.text = journal?.dateCreated.toMonthDate().lowercased()
        moodImageView.image = UIImage(named: journal!.mood.iconString)
        moodLabel.text = journal?.feeling
        intentionalityBackBar.layer.cornerRadius = 10
        intentionalityBackBar.clipsToBounds = true
        intentionalityFrontBar.layer.cornerRadius = 10
        intentionalityFrontBar.clipsToBounds = true
        frontBarWidth.constant = intentionalityBackBar.frame.width * CGFloat(journal!.intentionality)
        intentionalityLabel.text = "\(Int(journal!.intentionality * 100))% intentionality"
        notesLabel.text = journal?.notes
        if journal?.notes == "" {
            additionalNotesLabel.isHidden = true
        }
        
    }
    
    private func deleteJournal() {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(journal!)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let userDefaults = UserDefaults.standard
        var currentJournals = userDefaults.array(forKey: "JournalArray") as? [String] ?? [String]()
        if let index = currentJournals.firstIndex(of: json!) {
            currentJournals.remove(at: index)
        }
        
        userDefaults.setValue(currentJournals, forKey: "JournalArray")
        
        self.performSegue(withIdentifier: "Delete Journal Segue", sender: nil)
    }
    
    @IBAction func moreButtonPress(_ sender: UIButton) {
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            let alert = UIAlertController(
                title: "Are you sure?",
                message: "This action can not be undone.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.deleteJournal()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
    
        }))
        actionSheet.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel
        ))
        present(actionSheet, animated: true)
    }
    
    @IBAction func backButtonPress(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Delete Journal Segue" {
            if let destination = segue.destination as? EntriesViewController {
                if let index = destination.journals.firstIndex(of: journal!) {
                    destination.journals.remove(at: index)
//                    destination.entryCollectionView.reloadData()
                }
            }
        }
        
    }
    
}
