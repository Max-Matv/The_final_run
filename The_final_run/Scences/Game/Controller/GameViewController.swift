//
//  GameViewController.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 03.Sep.22.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    private var car: UIImageView!
    private var carDirLeft: NSLayoutConstraint!
    @IBOutlet weak var roadView: SKView!
    private var carDirRight: NSLayoutConstraint!
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet weak private var stearingWheel: UIImageView!
    private var player = Player()
    
    private var score = 0 {
        didSet {
            scoreLabel.text = " Score: \(score) "
        }
    }
    private var gameTimer: Timer?
    private var directionTimer: Timer?
    private var gameIsOver: Bool = false
    private let garage = Garage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCar()
        navigationController?.isNavigationBarHidden = true
        player.play(resourse: URL(fileURLWithPath: Bundle.main.path(forResource: "ride", ofType: ".mp3")!), endlessCycle: true)
    }
    
    //MARK: - Right button pressed
    @IBAction func rightPressed(_ sender: Any) {
        if !gameIsOver {
            let carInfo = garage.getCar(_with: UserDefaults.standard.integer(forKey: "playerCar"))
            car.image = UIImage(named: carInfo.right)
            self.directionTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [self] timer in
                if car.frame.origin.x > roadView.bounds.maxX - self.car.frame.width / 2 {
                    total()
                }
                carDirRight.constant += 3
                carDirLeft.constant += 3
                UIView.animate(withDuration: 0.01, delay: 0, options: []) {
                    self.roadView.layoutIfNeeded()
                    self.stearingWheel.transform = CGAffineTransform(rotationAngle: +70)
                }
            }
        }
    }
    //MARK: - Right button unpressed
    @IBAction func rightUnpressed(_ sender: Any) {
        directionTimer?.invalidate()
        let carInfo = garage.getCar(_with: UserDefaults.standard.integer(forKey: "playerCar"))
        car.image = UIImage(named: carInfo.back)
        self.stearingWheel.transform = CGAffineTransform(rotationAngle: 0)
    }
    
    //MARK: - Left button pressed
    @IBAction func leftPressed(_ sender: Any) {
        if !gameIsOver {
            let carInfo = garage.getCar(_with: UserDefaults.standard.integer(forKey: "playerCar"))
            car.image = UIImage(named: carInfo.left)
            self.directionTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [self] timer in
                if car.frame.origin.x < roadView.bounds.minX - self.car.frame.width / 2 {
                    total()
                }
                carDirLeft.constant -= 3
                carDirRight.constant -= 3
                UIView.animate(withDuration: 0.01, delay: 0, options: []) {
                    self.roadView.layoutIfNeeded()
                    self.stearingWheel.transform = CGAffineTransform(rotationAngle: -70)
                }
            }
        }
    }
    //MARK: - Left button unpressed
    @IBAction func leftUnpressed(_ sender: Any) {
        directionTimer?.invalidate()
        let carInfo = garage.getCar(_with: UserDefaults.standard.integer(forKey: "playerCar"))
        car.image = UIImage(named: carInfo.back)
        self.stearingWheel.transform = CGAffineTransform(rotationAngle: 0)
    }
    //MARK: - Add car
    private func setupCar() {
        car = UIImageView()
        roadView.addSubview(car)
        let carInfo = garage.getCar(_with: UserDefaults.standard.integer(forKey: "playerCar"))
        car.image = UIImage(named: carInfo.back)
        stearingWheel.image = UIImage(named: carInfo.stearingWheel)
        car.contentMode = .scaleAspectFill
        car.translatesAutoresizingMaskIntoConstraints = false
        car.heightAnchor.constraint(equalToConstant: 110).isActive = true
        car.bottomAnchor.constraint(equalTo: roadView.bottomAnchor).isActive = true
        carDirLeft = car.leadingAnchor.constraint(equalTo: roadView.leadingAnchor, constant: roadView.frame.width / 1.5)
        carDirLeft.isActive = true
        carDirRight = car.trailingAnchor.constraint(equalTo: roadView.trailingAnchor, constant: 0)
        carDirRight.isActive = true
    }
    //MARK: - Score
    private func scoreTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if !self.gameIsOver {
                self.score += 1
            } else {
                timer.invalidate()
            }
        }
    }
    //MARK: - Setup road mark
    private func addBlockage() {
        let blockage = UIImageView(frame: CGRect(x: roadView.center.x, y: roadView.bounds.minY, width: car.frame.width / 2, height: car.frame.height / 2))
        blockage.image = UIImage(named: "truck")
        guard let direction = Direction.allCases.randomElement() else {return}
        blockageDirection(direction: direction, view: blockage)
        roadView.insertSubview(blockage, at: 0)
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if !self.gameIsOver {
                if blockage.frame.origin.y > self.roadView.bounds.maxY - blockage.frame.height {
                    blockage.removeFromSuperview()
                }
                direction == .toLeft ? (blockage.frame.origin.x -= 0.5) : (blockage.frame.origin.x += 0.6)
                blockage.frame.origin.y += 2
                blockage.frame.size.width += 0.4
                blockage.frame.size.height += 0.4
                if self.car.frame.intersects(blockage.frame) {
                    self.total()
                }
            }
        }
    }
    //MARK: - Blockage direction
    private func blockageDirection(direction: Direction, view: UIView) {
        switch direction {
        case .toLeft:
            view.center.x = roadView.center.x - view.frame.width
        case .toRight:
            view.center.x = roadView.center.x + view.frame.width
        }
    }
    
    //MARK: - Total
    private func total() {
        player.play(resourse: URL(fileURLWithPath: Bundle.main.path(forResource: "crash", ofType: ".mp3")!), endlessCycle: false)
        gameIsOver = true
        gameTimer?.invalidate()
        directionTimer?.invalidate()
        roadView.isPaused = true
        let carInfo = garage.getCar(_with: UserDefaults.standard.integer(forKey: "playerCar"))
        let alertController = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { [self] action in
            guard let text = alertController.textFields?.first?.text else {return}
            DBManager.shared.setScore(name: text, car: carInfo.image, score: score)
            navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addTextField()
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    //MARK: - Animate road mark
    override func viewDidAppear(_ animated: Bool) {
        scoreTimer()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { timer in
            print("added")
            self.addBlockage()
        }
        if let roadView = SKScene(fileNamed: "RoadMarkScene") {
            self.roadView.presentScene(roadView)
        }
    }
    
}
