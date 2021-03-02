//
//  TaskView.swift
//  Refresh
//
//  Created by Avi Khemani on 2/21/21.
//

import UIKit

class TaskView: UIView {

    let task: Task
    
    init(frame: CGRect, task: Task) {
        self.task = task
        super.init(frame: frame)
        
        switch task.shape {
        case .circle: createCircle()
        case .square: createSquare()
        case .rectangle: createSquare()
        case .triangle: createTriangle()
        case .star: createStar()
        }
        addLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCircle() {
        layer.cornerRadius = frame.width/2
        clipsToBounds = true
        backgroundColor = task.color.color
    }
    
    private func createSquare() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = task.color.color
    }
    
    private func createTriangle() {
        let triangle = CAShapeLayer()
        triangle.fillColor = task.color.color.cgColor
        triangle.path = createRoundedTriangle(width: frame.width, height: frame.height, radius: 10)
        triangle.position = CGPoint(x: frame.width/2, y: frame.height/2)
        backgroundColor = task.color.color
        layer.masksToBounds = true
        layer.mask = triangle
    }
    
    func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
        let point1 = CGPoint(x: -width / 2, y: height / 2)
        let point2 = CGPoint(x: 0, y: -height / 2)
        let point3 = CGPoint(x: width / 2, y: height / 2)

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
        path.closeSubpath()

        return path
    }
    
    func createStar() {
        let triangle = CAShapeLayer()
        triangle.fillColor = task.color.color.cgColor
        triangle.path = createRoundedStar()
        triangle.position = CGPoint(x: 0, y: 0)
        layer.addSublayer(triangle)
    }
    
    func createRoundedStar() -> CGPath {
        let path = CGMutablePath()
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let r = frame.width / 2
        let rc: CGFloat = 5
        let rn = r * 0.95 - rc
        
        var cangle: CGFloat = 54
        for i in 1 ... 5 {
            // compute center point of tip arc
            let cc = CGPoint(x: center.x + rn * cos(cangle * .pi / 180), y: center.y + rn * sin(cangle * .pi / 180))
            
            // compute tangent point along tip arc
            let p = CGPoint(x: cc.x + rc * cos((cangle - 72) * .pi / 180), y: cc.y + rc * sin((cangle - 72) * .pi / 180))
            
            if i == 1 {
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }
            
            // add 144 degree arc to draw the corner
            path.addArc(center: cc, radius: rc, startAngle: (cangle - 72) * .pi / 180, endAngle: (cangle + 72) * .pi / 180, clockwise: false)
            
            cangle += 144
        }
        
        path.closeSubpath()
        return path
        
    }
    
    private func addLabel() {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = task.name
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        addSubview(label)
        
        
        label.widthAnchor.constraint(equalToConstant: frame.width - (task.shape == .triangle ? 50 : 30)).isActive = true
        label.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: task.shape == .triangle ? 20 : 0).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }

}
