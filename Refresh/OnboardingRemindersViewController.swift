//
//  OnboardingRemindersViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/14/21.
//

import UIKit

class OnboardingRemindersViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var times = [Date]()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var progressBars: [UIView]!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.layer.cornerRadius = 20
            continueButton.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        
        loadUI()
    }
    
    private func loadUI() {
        for bar in progressBars {
            bar.layer.cornerRadius = 5
            bar.clipsToBounds = true
        }
        
        
    }

    @IBAction func continuePress(_ sender: UIButton) {
        if times.count == 0 {
            self.displayMessage(title: "Incomplete", message: "Please add at least one time.")
        }
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in
                dispatchGroup.leave()
            })
        dispatchGroup.wait()
        
        createNotifications()
        self.performSegue(withIdentifier: "Submit Reminders Segue", sender: nil)
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
                print("added!!")
                print(request)
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
    
    

}
