//
//  MainScene.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 01.Sep.22.
//

import UIKit
import SpriteKit

class MainScene: SKScene {
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createRoad()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveRoad()
    }
    //MARK: -Create road
    private func createRoad() {
        for i in 0...4 {
            let road = SKSpriteNode(imageNamed: "road")
            road.name = "Road"
            road.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            road.anchorPoint = CGPoint(x: 1, y: 1)
            road.position = CGPoint(x: self.frame.size.width / 2, y: CGFloat(i) * road.size.height )
            
            self.addChild(road)
        }
    }
    //MARK: -Move road
    private func moveRoad() {
        self.enumerateChildNodes(withName: "Road", using: ({ node, error in
            node.position.y -= 3
            if node.position.y < -((self.scene?.size.width)!) {
                node.position.y += self.scene!.size.width * 4
            }
        }))
    }

}
