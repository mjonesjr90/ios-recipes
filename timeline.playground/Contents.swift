//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class CircleView : UIView {

    var outGoingLine : CAShapeLayer?
    var inComingLine : CAShapeLayer?
    var inComingCircle : CircleView?
    var outGoingCircle : CircleView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.width / 2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func lineTo(circle: CircleView) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: self.center)
        path.addLine(to: circle.center)

        let line = CAShapeLayer()
        line.path = path.cgPath
        line.lineWidth = 5
        line.strokeColor = UIColor.red.cgColor
        circle.inComingLine = line
        outGoingLine = line
        outGoingCircle = circle
        circle.inComingCircle = self
        return line
    }
}

class MyViewController : UIViewController {

    let circle1 = CircleView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
    let circle2 = CircleView(frame: CGRect(x: 100, y: 200, width: 50, height: 50))
    let circle3 = CircleView(frame: CGRect(x: 100, y: 300, width: 50, height: 50))
    let circle4 = CircleView(frame: CGRect(x: 100, y: 400, width: 50, height: 50))

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view

        circle1.backgroundColor = .red
        view.addSubview(circle1)

        circle2.backgroundColor = .red
        view.addSubview(circle2)

        circle3.backgroundColor = .red
        view.addSubview(circle3)

        circle4.backgroundColor = .red
        view.addSubview(circle4)

        circle1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan(gesture:))))

        circle2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan(gesture:))))

        circle3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan(gesture:))))

        circle4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan(gesture:))))

        view.layer.addSublayer(circle1.lineTo(circle: circle2))
        view.layer.addSublayer(circle2.lineTo(circle: circle3))
        view.layer.addSublayer(circle3.lineTo(circle: circle4))
    }

    @objc func didPan(gesture: UIPanGestureRecognizer) {
        guard let circle = gesture.view as? CircleView else {
            return
        }
        if (gesture.state == .began) {
            circle.center = gesture.location(in: self.view)
        }
        let newCenter: CGPoint = gesture.location(in: self.view)
        let dX = newCenter.x - circle.center.x
        let dY = newCenter.y - circle.center.y
        circle.center = CGPoint(x: circle.center.x + dX, y: circle.center.y + dY)


        if let outGoingCircle = circle.outGoingCircle, let line = circle.outGoingLine, let path = circle.outGoingLine?.path {

            let newPath = UIBezierPath(cgPath: path)
            newPath.removeAllPoints()
            newPath.move(to: circle.center)
            newPath.addLine(to: outGoingCircle.center)
            line.path = newPath.cgPath
        }

        if let inComingCircle = circle.inComingCircle, let line = circle.inComingLine, let path = circle.inComingLine?.path {

            let newPath = UIBezierPath(cgPath: path)
            newPath.removeAllPoints()
            newPath.move(to: inComingCircle.center)
            newPath.addLine(to: circle.center)
            line.path = newPath.cgPath
        }
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
