//
//  DBManager.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 11.Sep.22.
//

import Foundation
import FirebaseDatabase

class DBManager {
    
    private let db = Database.database().reference()
    static let shared = DBManager()
    
    func setScore(name: String, car: String, score: Int) {
        let object: [String: Any] = [
            "name": name,
            "car": car,
            "score": score
        ]
        db.child("score").child("\(Int(Date().timeIntervalSince1970))").setValue(object)
    }
    
    func getScore(completition: @escaping ([Score]) -> Void) {
        var scoreList = [Score]()
        db.child("score").observe(.value) { dataSnapshot in
            for data in dataSnapshot.children.allObjects as! [DataSnapshot] {
                let object = data.value as? [String: Any]
                let name = object?["name"]
                let car = object?["car"]
                let score = object?["score"]
                let scoreModel = Score(name: name as! String, car: car as! String, score: score as! Int)
                scoreList.append(scoreModel)
            }
            let sortedList = scoreList.sorted(by: {$0.score > $1.score})
            completition(sortedList)
        }
    }
}
