//
//  EntriesViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/1/21.
//

import UIKit

class EntriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var journals = [Journal]()
    
    private var emptyImageView: UIImageView?
    @IBOutlet weak var entryCollectionView: DynamicHeightCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryCollectionView.delegate = self
        entryCollectionView.dataSource = self
        setUpPlaceholder()
        
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
    
    private func setUpPlaceholder() {
        let width = view.frame.width
        let size = width - 20
        let frame = CGRect(x: width/2 - size/2, y: view.frame.midY - size/2, width: size, height: size)
        emptyImageView = UIImageView(image: UIImage(named: "noEntries"))
        emptyImageView?.frame = frame
        emptyImageView?.isHidden = true
        view.addSubview(emptyImageView!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = journals.count
        if count == 0 {
            emptyImageView?.isHidden = false
        } else {
            emptyImageView?.isHidden = true
        }
        return count
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
        
        if let journalCell = self.entryCollectionView.cellForItem(at: indexPath) as? JournalCollectionViewCell {
            journalCell.contentView.backgroundColor = .systemGray4
            UIView.animate(withDuration: 0.5, animations: {
                journalCell.contentView.backgroundColor = .systemGray6
            }) { (completed) in
                
            }
        }
            
        self.performSegue(withIdentifier: "Show Entry Segue", sender: selectedJournal)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: 220)
    }
    
    @IBAction func saveJournal(bySegue: UIStoryboardSegue) {
        let seconds = 0.2
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            if let journalCell = self.entryCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? JournalCollectionViewCell {
                UIView.animate(withDuration: 0.6) {
                    
                    journalCell.contentView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.5)
                } completion: { (true) in
                    UIView.animate(withDuration: 0.6) {
                        
                        journalCell.contentView.backgroundColor = .systemGray6
                    } completion: { (true) in
                        UIView.animate(withDuration: 0.6) {
                            
                            journalCell.contentView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.5)
                        } completion: { (true) in
                            UIView.animate(withDuration: 0.6) {
                                
                                journalCell.contentView.backgroundColor = .systemGray6
                            } completion: { (true) in
                                
                            }
                        }
                    }
                }

            }
        }
        
    }

    @IBAction func deleteJournal(bySegue: UIStoryboardSegue) {
        let seconds = 0.2
        let selectedRow = entryCollectionView.indexPathsForSelectedItems?[0].row ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            UIView.animate(withDuration: 1.0) {
                self.entryCollectionView.deleteItems(at: [IndexPath(row: selectedRow, section: 0)])
            }
        }

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
