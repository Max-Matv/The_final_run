//
//  UIViewController+Instantiate.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 01.Sep.22.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiate() -> UIViewController {
        let identifire = String(describing: self)
        let storyboard = UIStoryboard(name: identifire, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifire)
        return viewController
    }
}
