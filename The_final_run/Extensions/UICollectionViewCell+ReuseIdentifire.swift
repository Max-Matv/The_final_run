//
//  UICollectionViewCell+ReuseIdentifire.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 10.Sep.22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifire: String {
        String(describing: self)
    }
}
