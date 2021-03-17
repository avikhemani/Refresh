//
//  InsightsViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/10/21.
//

import UIKit

class InsightsViewController: UIViewController {
    
    private var tips = [
        Tip(
            insight: "more than 2/3 of your mindless scrolling happens when you’re about to go to bed!",
            advice: "some people find it helpful to make a night time routine. ",
            action: "add a night time routine",
            task: Task(
                name: "night time routine",
                shape: .circle,
                color: .blue,
                width: 150,
                height: 150)
        ),
        Tip(
            insight: "more than 1/2 of your mindless scrolling happens in the morning",
            advice: "some people find it helpful to make a morning routine.",
            action: "add a morning routine",
            task: Task(
                name: "morning routine",
                shape: .square,
                color: .orange,
                width: 130,
                height: 130)
        ),
        Tip(
            insight: "your time spent mindlessly scrolling has increased by 40% over the past few days",
            advice: "some people find it helpful to journal about their mindless scrolling habits.",
            action: "add a journal session",
            task: Task(
                name: "journal",
                shape: .triangle,
                color: .red,
                width: 140,
                height: 140)
        ),
        Tip(
            insight: "your time spent mindlessly scrolling has increased by 30% over the past week",
            advice: "some people find it helpful to be more mindful about their habits",
            action: "add a meditation session",
            task: Task(
                name: "meditate",
                shape: .rectangle,
                color: .pPink2,
                width: 140,
                height: 140)
        ),
        Tip(
            insight: "more than 1/2 of your mindless scrolling happens in the morning",
            advice: "some people find it helpful to write down positive affirmation in the morning to align themselves for the day",
            action: "add positive affirmations task",
            task: Task(
                name: "write positive affirmations",
                shape: .rectangle,
                color: .green,
                width: 160,
                height: 120)
        )
    ]
    
    private let selectedIndex = Int.random(in: 0..<5)
    
    @IBOutlet weak var tipBackgroundView: UIView! {
        didSet {
            tipBackgroundView.layer.cornerRadius = 15
            tipBackgroundView.clipsToBounds = true
        }
    }
    @IBOutlet weak var tipInsightLabel: UILabel!
    @IBOutlet weak var tipAdviceLabel: UILabel!
    
    @IBOutlet weak var tipButton: UIButton! {
        didSet {
            tipButton.layer.cornerRadius = 15
            tipButton.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var summaryImageView: UIImageView! {
        didSet {
            summaryImageView.layer.cornerRadius = 15
            summaryImageView.clipsToBounds = true
            summaryImageView.alpha = 0.9
        }
    }
    
    @IBOutlet weak var basicBarChart: BasicBarChart!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }
    
    private func loadUI() {
        let selectedTip = tips[selectedIndex]
        
        tipInsightLabel.text = selectedTip.insight
        tipAdviceLabel.text = selectedTip.advice
        tipButton.setTitle(selectedTip.action, for: .normal)
        tipButton.setTitle("added!", for: .disabled)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewSummary))
        summaryImageView.isUserInteractionEnabled = true
        summaryImageView.addGestureRecognizer(tapGesture)
        
        let userDefaults = UserDefaults.standard
        let completedTips = userDefaults.array(forKey: "CompletedTips") as? [Int] ?? [Int]()
        if completedTips.contains(selectedIndex) {
            tipButton.isEnabled = false
            tipButton.backgroundColor = .systemGray3
        }
        
        updateChart()
        
    }
    
    func updateChart() {
        if maxLabel == nil || midLabel == nil || minLabel == nil {
            return
        }
        let userDefaults = UserDefaults.standard
        let dateToCompleted = userDefaults.dictionary(forKey: "DateToCompleted") as? [String : Int] ?? [String : Int]()
        var dataEntries = [DataEntry]()
        var max = dateToCompleted.values.max() ?? 0
        if max % 2 == 1 {
            max += 1
        }
        maxLabel.text = "\(max)"
        midLabel.text = "\(max/2)"
        for date in dateToCompleted.keys.sorted() {
            let progress = dateToCompleted[date] ?? 0
            let entry = DataEntry(color: .systemPink, height: Float(progress)/Float(max), textValue: "\(progress)", title: date)
            dataEntries.append(entry)
        }
        basicBarChart.updateDataEntries(dataEntries: dataEntries, animated: true)
    }
    
    @objc func viewSummary() {
        self.performSegue(withIdentifier: "View Summary Segue", sender: nil)
    }
    
    @IBAction func tipButtonPress(_ sender: UIButton) {
        if let navVC = tabBarController?.viewControllers?[1] as? UINavigationController, let doSomethingVC = navVC.topViewController as? DoSomethingViewController {
            let selectedTip = tips[selectedIndex]
            
            let newTask = selectedTip.task
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try! jsonEncoder.encode(newTask)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            let userDefaults = UserDefaults.standard
            var currentTasks = userDefaults.array(forKey: "TaskArray") as? [String] ?? [String]()
            currentTasks.append(json!)
            
            userDefaults.setValue(currentTasks, forKey: "TaskArray")
            tabBarController?.selectedIndex = 1
            let frame = CGRect(x: 100, y: 0, width: newTask.width, height: newTask.height)
            let taskView = TaskView(frame: frame, task: newTask)
            doSomethingVC.view.addSubview(taskView)
            doSomethingVC.behavior.addItem(item: taskView)
            doSomethingVC.taskViews.append(taskView)
            doSomethingVC.updateEmptyImage()
            let tapGesture = UITapGestureRecognizer(target: doSomethingVC, action: #selector(doSomethingVC.completeTask(sender:)))
            taskView.addGestureRecognizer(tapGesture)
            tipButton.isEnabled = false
            tipButton.backgroundColor = .systemGray4
            
            var completedTips = userDefaults.array(forKey: "CompletedTips") as? [Int] ?? [Int]()
            completedTips.append(selectedIndex)
            
            userDefaults.setValue(completedTips, forKey: "CompletedTips")
        }
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "View All Segue" {
            if let destination = segue.destination as? CompletedViewController {
                destination.isCompleted = false
            }
        }
    }
    

}
