//
//  ScoreViewController.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 11.Sep.22.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    
    private var score = [Score]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        DBManager.shared.getScore { score in
            print(score)
            self.score = score
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        let key = ScoreCell.reuseIdentifire
        tableView.register(UINib(nibName: key, bundle: nil), forCellReuseIdentifier: key)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        score.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreCell.reuseIdentifire, for: indexPath) as? ScoreCell else { fatalError() }
        cell.setupCell(score: score[indexPath.row])
        return cell
    }
}
