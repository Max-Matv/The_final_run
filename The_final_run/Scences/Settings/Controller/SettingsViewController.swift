//
//  SettingsViewController.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 08.Sep.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    private var garage = Garage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        volumeSlider.value = UserDefaults.standard.float(forKey: "volume")
    }
    
    @IBAction func sliderDidSlide(_ sender: UISlider) {
        UserDefaults.standard.set(sender.value, forKey: "volume")
    }
    
    //MARK: - Setup collection view
    private func setupCollectionView() {
        let key = SettingsViewCell.reuseIdentifire
        collectionView.register(UINib(nibName: key, bundle: nil), forCellWithReuseIdentifier: key)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        garage.getCars().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsViewCell.reuseIdentifire, for: indexPath) as? SettingsViewCell else {
            fatalError()
        }
        cell.setupCell(car: garage.getCars()[indexPath.row])
        cell.buttonPressed = { [self] in
            UserDefaults.standard.set(indexPath.row, forKey: "playerCar")
            garage.updateGarage(_with: indexPath.row)
            collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
