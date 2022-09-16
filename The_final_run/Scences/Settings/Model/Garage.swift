//
//  Garage.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 10.Sep.22.
//

import Foundation


class Garage {
    
    private var carsInGarage: [CarInGarage] = [
        CarInGarage(image: "carOneSide", selectStatus: false, back: "carOne", left: "carOneLeft", right: "carOneRight", stearingWheel: "carOneSteeringWheel"),
        CarInGarage(image: "carTwoSide", selectStatus: false, back: "carTwo", left: "carTwoLeft", right: "carTwoRight", stearingWheel: "carTwoSteeringWheel")
    ]
    
    init() {
        updateGarage(_with: UserDefaults.standard.integer(forKey: "playerCar"))
    }
    
    func getCar(_with index: Int) -> CarInGarage {
        carsInGarage[index]
    }
    
    func getCars() -> [CarInGarage] {
        carsInGarage
    }
    
    func updateGarage(_with index: Int) {
        carsInGarage[index].selectStatus = true
        var indexOfCar = 0
        carsInGarage.forEach { car in
            if index != indexOfCar {
                carsInGarage[indexOfCar].selectStatus = false
            }
            indexOfCar += 1
        }
    }
}
