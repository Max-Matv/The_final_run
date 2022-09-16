//
//  Core.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 12.Sep.22.
//

import Foundation


class Core {
    
    static let shared = Core()
    
    func isFirstRun() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isFirstRun")
    }
    
    func setRun() {
        UserDefaults.standard.set(true, forKey: "isFirstRun")
    }
}
