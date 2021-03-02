//
//  ReflectViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 2/28/21.
//

import UIKit

class ReflectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
    
    private var moods = Mood.allCases
    private var feelings = ["relaxed", "happy", "energized", "apathetic", "angry", "bored", "irritable", "tired", "stressed"]
    
    @IBOutlet weak var moodCollectionView: UICollectionView!
    @IBOutlet weak var feelingCollectionView: DynamicHeightCollectionView!
    @IBOutlet weak var intentionalitySlider: UISlider!
    @IBOutlet weak var notesTextView: UITextView! {
        didSet {
            notesTextView.layer.cornerRadius = 10
            notesTextView.clipsToBounds = true
        }
    }
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.layer.cornerRadius = 15
            saveButton.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moodCollectionView.delegate = self
        moodCollectionView.dataSource = self
        feelingCollectionView.delegate = self
        feelingCollectionView.dataSource = self
        
        feelingCollectionView.layoutIfNeeded()
        notesTextView.delegate = self
        
        registerForKeyboardNotifications()
        
        moodCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .right)
        feelingCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .right)
        intentionalitySlider.value = 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.restorationIdentifier == "moodCollectionView" {
            return moods.count
        } else {
            return feelings.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.restorationIdentifier == "moodCollectionView" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Mood Cell", for: indexPath)
            
            if let moodCell = cell as? MoodCollectionViewCell {
                moodCell.mood = moods[indexPath.row]
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Feeling Cell", for: indexPath)
            
            if let feelingCell = cell as? FeelingCollectionViewCell {
                feelingCell.feelingString = feelings[indexPath.row]
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.restorationIdentifier == "moodCollectionView" {
            return CGSize(width: 70, height: 70)
            
        } else {
            return CGSize(width: (view.frame.width - 80)/3, height: 40)
        }
    }
    
    
    @IBAction func saveButtonPress(_ sender: UIButton) {
        let moodIndex = moodCollectionView.indexPathsForSelectedItems?[0].row ?? 0
        let mood = moods[moodIndex]
        let feelingIndex = feelingCollectionView.indexPathsForSelectedItems?[0].row ?? 0
        let feeling = feelings[feelingIndex]
        
        let intentionality = intentionalitySlider.value
        
        let notes = notesTextView.text
        
        let newJournal = Journal(mood: mood, feeling: feeling, intentionality: intentionality, notes: notes)
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(newJournal)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let userDefaults = UserDefaults.standard
        var currentJournals = userDefaults.array(forKey: "JournalArray") as? [String] ?? [String]()
        currentJournals.append(json!)

        userDefaults.setValue(currentJournals, forKey: "JournalArray")
        
        self.performSegue(withIdentifier: "Save Journal Segue", sender: newJournal)
    }
    
    
    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        self.scrollView.isScrollEnabled = true
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.scrollView.setContentOffset(CGPoint(x: 0, y: keyboardSize!.height), animated: true)
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if (!aRect.contains(notesTextView.frame.origin)){
            self.scrollView.scrollRectToVisible(notesTextView.frame, animated: true)
        }
        
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        let info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
        self.scrollView.contentInset = UIEdgeInsets.zero
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func backPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Save Journal Segue" {
            if let newJournal = sender as? Journal {
                if let destination = segue.destination as? EntriesViewController {
                    destination.journals.insert(newJournal, at: 0)
                    destination.entryCollectionView.reloadData()
                }
                
            }
        }
    }
    
}
