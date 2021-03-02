//
//  EntriesViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import UIKit

class EntriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var journals = [Journal]()
    
    @IBOutlet weak var entryCollectionView: DynamicHeightCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryCollectionView.delegate = self
        entryCollectionView.dataSource = self
        if let layout = entryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
        }
        
        let userDefaults = UserDefaults.standard
        let currentJournals = userDefaults.array(forKey: "JournalArray") as? [String] ?? [String]()

        for (i, taskJson) in currentJournals.enumerated() {
            let jsonDecoder = JSONDecoder()
            let journal = try! jsonDecoder.decode(Journal.self, from: taskJson.data(using: String.Encoding.utf8)!)
            journals.append(journal)
            
        }
        journals.reverse()
        entryCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return journals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Journal Cell", for: indexPath)
        
        if let journalCell = cell as? JournalCollectionViewCell {
            journalCell.journal = journals[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedJournal = journals[indexPath.row]
        
        self.performSegue(withIdentifier: "Show Entry Segue", sender: selectedJournal)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: 220)
    }
    
    @IBAction func newEntryPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveJournal(bySegue: UIStoryboardSegue) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Entry Segue" {
            if let journal = sender as? Journal {
                if let destination = segue.destination as? JournalEntryViewController {
                    destination.journal = journal
                }
            }
        }
    }
    
}
