//
//  ScoreCell.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 11.Sep.22.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var carImage: UIImageView!
    @IBOutlet weak private var score: UILabel!
    
   
    func setupCell(score: Score) {
        name.text = score.name
        carImage.image = UIImage(named: score.car)
        self.score.text = String(score.score)
    }
    
}
