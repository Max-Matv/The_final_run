//
//  UITableViewCell+ReuseIdentifire.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 11.Sep.22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifire: String {
        String(describing: self)
    }
}
