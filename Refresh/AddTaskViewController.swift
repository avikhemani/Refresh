//
//  AddTaskViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 2/22/21.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let shapes = Shape.allCases
    private let colors = RColor.allCases

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var shapeCollectionView: UICollectionView!
    @IBOutlet weak var addTaskButton: UIButton! {
        didSet {
            addTaskButton.layer.cornerRadius = 15
            addTaskButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskNameTextField.delegate = self
        shapeCollectionView.delegate = self
        shapeCollectionView.dataSource = self
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
        shapeCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .right)
        colorCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .right)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.restorationIdentifier == "shapeCollectionView" {
            return shapes.count
        } else {
            return colors.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.restorationIdentifier == "shapeCollectionView" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Shape Cell", for: indexPath)
            
            if let shapeCell = cell as? ShapeCollectionViewCell {
                shapeCell.shape = shapes[indexPath.row]
            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Color Cell", for: indexPath)
            
            if let colorCell = cell as? ColorCollectionViewCell {
                colorCell.rcolor = colors[indexPath.row]
            }
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.restorationIdentifier == "shapeCollectionView" {
            return CGSize(width: 70, height: 70)

        } else {
            return CGSize(width: 60, height: 60)
        }
    }
    
    
    @IBAction func addTaskPress(_ sender: UIButton) {
        let taskName = taskNameTextField.text ?? ""
        let shapeIndex = shapeCollectionView.indexPathsForSelectedItems?[0].row ?? 0
        let shape = shapes[shapeIndex]
        let colorIndex = colorCollectionView.indexPathsForSelectedItems?[0].row ?? 0
        let color = colors[colorIndex]
        
        if taskName == "" {
            self.displayMessage(title: "Incomplete", message: "Please add a task name")
            return
        }
        
        let width = Int.random(in: 100..<200)
        let height = shape == .rectangle ? Int(Double(width) * 0.75) : width
        
        let newTask = Task(name: taskName, shape: shape, color: color, width: width, height: height)
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(newTask)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let userDefaults = UserDefaults.standard
        var currentTasks = userDefaults.array(forKey: "TaskArray") as? [String] ?? [String]()
        currentTasks.append(json!)

        userDefaults.setValue(currentTasks, forKey: "TaskArray")
        
        self.performSegue(withIdentifier: "Add Task Segue", sender: newTask)
    }
    
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add Task Segue" {
            if let newTask = sender as? Task {
                if let destination = segue.destination as? DoSomethingViewController {
                    let frame = CGRect(x: 100, y: 0, width: newTask.width, height: newTask.height)
                    let taskView = TaskView(frame: frame, task: newTask)
                    destination.view.addSubview(taskView)
                    destination.behavior.addItem(item: taskView)
                    let tapGesture = UITapGestureRecognizer(target: destination, action: #selector(destination.completeTask(sender:)))
                    taskView.addGestureRecognizer(tapGesture)
                }
                
            }
            
        }
    }
    

}
