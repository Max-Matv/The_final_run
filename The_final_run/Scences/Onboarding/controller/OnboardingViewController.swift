//
//  OnboardingViewController.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 12.Sep.22.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak private var contentView: UIView!
    private var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupScrollView()
    }
    //MARK: - Setup scroll view
    private func setupScrollView() {
        scrollView = UIScrollView(frame: contentView.bounds)
        contentView.addSubview(scrollView)
        let titles = ["Steering the car left and right", "Вodge obstacles and don't go off the track!", "Enjoy the game"]
        let images = ["info1", "info2", "logo"]
        
        for i in 0..<3 {
            let page = UIView(frame: CGRect(x: CGFloat(i) * contentView.frame.size.width, y: 0, width: contentView.frame.width, height: contentView.frame.height))
            scrollView.addSubview(page)
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: page.frame.size.width - 20, height: 120))
            let image = UIImageView(frame: CGRect(x: 10, y: 10 + 120 + 10, width: page.frame.size.width - 20, height: page.frame.size.height - 60 - 130 - 15))
            let button = UIButton(frame: CGRect(x: 10, y: page.frame.size.height - 60, width: page.frame.size.width - 20, height: 50))
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = UIFont(name: "Helvetica-Bold", size: 30)
            page.addSubview(label)
            label.text = titles[i]
            image.contentMode = .scaleAspectFit
            image.image = UIImage(named: images[i])
            page.addSubview(image)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.tag = i + 1
            button.setTitle("next", for: .normal)
            if i == 2 {
                button.setTitle("ride", for: .normal)
            }
            button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            page.addSubview(button)
        }
        scrollView.contentSize = CGSize(width: contentView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc
    private func tapButton(_ sender: UIButton) {
        guard sender.tag < 3 else {
            Core.shared.setRun()
            dismiss(animated: true)
            return
        }
        scrollView.setContentOffset(CGPoint(x: contentView.frame.size.width * CGFloat(sender.tag), y: 0), animated: true)
    }
}
