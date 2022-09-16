//
//  ViewController.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 01.Sep.22.
//

import UIKit
import SpriteKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak private var animationView: SKView!
    private var startButton = UIButton()
    private var settingsButton = UIButton()
    private var scoreButton = UIButton()
    private var contentView = UIView()
    private var player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentView()
        player.play(resourse: URL(fileURLWithPath: Bundle.main.path(forResource: "menu", ofType: ".mp3")!), endlessCycle: true)
    }
    
    //MARK: - Setup ContentView
    private func setupContentView() {
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        setupStartButton()
        setupSettingsButton()
        setupScoreButton()
        contentView.widthAnchor.constraint(equalTo: startButton.widthAnchor).isActive = true
        contentView.layoutIfNeeded()
    }
    
    //MARK: - Setup start button
    private func setupStartButton() {
        startButton.setBackgroundImage(UIImage(named: "startOff"), for: .normal)
        startButton.setBackgroundImage(UIImage(named: "startOn"), for: .highlighted)
        startButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        contentView.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        startButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    //MARK: - Setup settings button
    private func setupSettingsButton() {
        settingsButton.setBackgroundImage(UIImage(named: "settings"), for: .normal)
        settingsButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        contentView.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 15).isActive = true
        settingsButton.heightAnchor.constraint(equalTo: startButton.heightAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: startButton.widthAnchor).isActive = true
    }
    //MARK: - Setup score button
    private func setupScoreButton() {
        scoreButton.setBackgroundImage(UIImage(named: "score"), for: .normal)
        scoreButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        contentView.addSubview(scoreButton)
        scoreButton.translatesAutoresizingMaskIntoConstraints = false
        scoreButton.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 20).isActive = true
        scoreButton.heightAnchor.constraint(equalTo: startButton.heightAnchor).isActive = true
        scoreButton.widthAnchor.constraint(equalTo: startButton.widthAnchor).isActive = true
        scoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    //MARK: - Button action
    @objc
    private func buttonAction(_ sender: UIButton!) {
        switch sender {
        case startButton:
            let vc = GameViewController.instantiate() as! GameViewController
            player.stop()
            navigationController?.pushViewController(vc, animated: false)
        case settingsButton:
            let vc = SettingsViewController.instantiate() as! SettingsViewController
            navigationController?.pushViewController(vc, animated: true)
        case scoreButton:
            let vc = ScoreViewController.instantiate() as! ScoreViewController
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
        if Core.shared.isFirstRun() {
            let vc = OnboardingViewController.instantiate() as! OnboardingViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    //MARK: - Start main menu animation
    override func viewDidAppear(_ animated: Bool) {
        if let animationView = SKScene(fileNamed: "MainScene") {
            self.animationView.presentScene(animationView)
        }
    }
}

