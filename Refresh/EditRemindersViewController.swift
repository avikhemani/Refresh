//
//  EditRemindersViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/17/21.
//

import UIKit

class EditRemindersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var oldIdentifiers = [String]()
    private var times = [Date]()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.layer.cornerRadius = 20
            saveButton.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        
        let userDefaults = UserDefaults.standard
        let currentReminders = userDefaults.array(forKey: "RemindersArray") as? [String] ?? [String]()

        for reminderJson in currentReminders {
            let jsonDecoder = JSONDecoder()
            let newReminder = try! jsonDecoder.decode(Reminder.self, from: reminderJson.data(using: String.Encoding.utf8)!)
            
            let oldDate = Calendar.current.date(from: newReminder.time) ?? Date()
            times.append(oldDate)
            oldIdentifiers.append(newReminder.identifier)
        }
        
        times.sort()
        timeCollectionView.reloadData()
    }
    
    @IBAction func savePress(_ sender: UIButton) {
        if times.count == 0 {
            self.displayMessage(title: "Incomplete", message: "Please add at least one time.")
            return
        }
        
        removeOld()
        createNotifications()
        
        self.dismiss(animated: true)
    }
    
    private func removeOld() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: oldIdentifiers)
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue([String](), forKey: "RemindersArray")
    }
    
    private func createNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Complete productive tasks!"
        content.body = "Stop wasting time on your phone and make the most out of the moment!"
        
        let calendar = Calendar.current
        for time in self.times {
            var dateComponents = DateComponents()
            dateComponents.hour = calendar.component(.hour, from: time)
            dateComponents.minute = calendar.component(.minute, from: time)
            let identifier = UUID().uuidString
            
            let newReminder = Reminder(identifier: identifier, time: dateComponents)
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try! jsonEncoder.encode(newReminder)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            let userDefaults = UserDefaults.standard
            var currentReminders = userDefaults.array(forKey: "RemindersArray") as? [String] ?? [String]()
            currentReminders.append(json!)
            
            userDefaults.setValue(currentReminders, forKey: "RemindersArray")
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return times.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Time Cell", for: indexPath)
        
        if let timeCell = cell as? TimeCollectionViewCell {
            timeCell.time = times[indexPath.row]
            timeCell.index = indexPath.row
            timeCell.deleteButton.addTarget(self, action: #selector(removeReminder), for: .touchUpInside)

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 28)
    }
    
    @objc func removeReminder(_ sender: InfoButton) {
        if let index = sender.index {
            self.times.remove(at: index)
            self.timeCollectionView.reloadData()
        }
    }
    
    @IBAction func addTimePress(_ sender: UIButton) {
        let time = datePicker.date
        if times.contains(time) {
            self.displayMessage(title: "Repeated time", message: "You already added a reminder at \(time.toHourString()).")
            return
        }
        
        self.times.append(time)
        self.timeCollectionView.reloadData()
    }
    
    @IBAction func cancelPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
