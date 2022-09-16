//
//  SettingsViewCell.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 10.Sep.22.
//

import UIKit

class SettingsViewCell: UICollectionViewCell {

    @IBOutlet weak private var carImage: UIImageView!
    @IBOutlet weak private var selctButton: UIButton!
    
    var buttonPressed: () -> Void = {}
    private var carSelected: Bool = false {
        didSet {
            selctButton.backgroundColor = carSelected ? .green : .red
            carSelected == false ? selctButton.setTitle("Select", for: .normal) : selctButton.setTitle("Selected", for: .normal)
        }
    }
    
    @IBAction func selectCar(_ sender: Any) {
        buttonPressed()
    }
    
    func setupCell(car: CarInGarage) {
        carImage.image = UIImage(named: car.image)
        carSelected = car.selectStatus
    }

}
