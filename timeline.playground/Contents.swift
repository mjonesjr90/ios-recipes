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
        line.strokeColor = UIColor.white.cgColor
        circle.inComingLine = line
        outGoingLine = line
        outGoingCircle = circle
        circle.inComingCircle = self
        return line
    }
    
    func lineToWake(circle: CircleView) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: self.center)
        path.addLine(to: circle.center)
        
        let line = CAShapeLayer()
        line.path = path.cgPath
        line.lineWidth = 5
        line.lineDashPattern = [0.001, 10]
        line.lineCap = CAShapeLayerLineCap.round
        line.strokeColor = UIColor.white.cgColor
        circle.inComingLine = line
        outGoingLine = line
        outGoingCircle = circle
        circle.inComingCircle = self
        return line
    }
}

extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
}

class MyViewController : UIViewController {

    let myView = UIView()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let diameter = 10
    
    var current = CircleView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var circle0 = CircleView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var circle1 = CircleView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var circle2 = CircleView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var circle3 = CircleView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var circle4 = CircleView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var circle5 = CircleView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))

    override func loadView() {
        myView.backgroundColor = .systemTeal
        self.view = myView
        
        let width = screenWidth/2
        
        current = CircleView(frame: CGRect(x: normalize(hour: 10), y: 400, width: diameter, height: diameter))
        
        circle0 = CircleView(frame: CGRect(x: -(Int(diameter)), y: 400, width: diameter, height: diameter))
        circle1 = CircleView(frame: CGRect(x: normalize(hour: 6), y: 400, width: diameter, height: diameter))
        circle2 = CircleView(frame: CGRect(x: normalize(hour: 13), y: 400, width: diameter, height: diameter))
        circle3 = CircleView(frame: CGRect(x: normalize(hour: 14), y: 400, width: diameter, height: diameter))
        circle4 = CircleView(frame: CGRect(x: normalize(hour: 18), y: 400, width: diameter, height: diameter))
        circle5 = CircleView(frame: CGRect(x: Int(width), y: 400, width: diameter, height: diameter))

        myView.layer.addSublayer(circle0.lineTo(circle: circle1))
        myView.layer.addSublayer(circle1.lineToWake(circle: circle2))
        myView.layer.addSublayer(circle2.lineTo(circle: circle3))
        myView.layer.addSublayer(circle3.lineToWake(circle: circle4))
        myView.layer.addSublayer(circle4.lineTo(circle: circle5))
        
        current.backgroundColor = .purple
        myView.addSubview(current)
        
        circle0.backgroundColor = .white
        myView.addSubview(circle0)
        
        circle1.backgroundColor = .white
        myView.addSubview(circle1)

        circle2.backgroundColor = .white
        myView.addSubview(circle2)

        circle3.backgroundColor = .white
        myView.addSubview(circle3)

        circle4.backgroundColor = .white
        myView.addSubview(circle4)
        
        circle5.backgroundColor = .white
        myView.addSubview(circle5)
    }
    
    func normalize(hour: Int) -> Int {
        let width = screenWidth/2
        return Int(width) * hour / 24
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 1, delay:0, options: [.repeat, .autoreverse], animations: {
            self.current.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
//        let windowRect = self.view.window?.frame
//        let windowWidth = windowRect?.size.width
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
