//
//  RoadMarkScene.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 05.Sep.22.
//

import UIKit
import SpriteKit

class RoadMarkScene: SKScene {
    
    private var roadMark = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        createRoad()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveRoadMark()
    }
    //MARK: - Create road
    private func createRoad() {
        let road = SKSpriteNode(imageNamed: "gameRoad")
        road.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        road.anchorPoint = CGPoint(x: 1, y: 1)
        road.position = CGPoint(x: self.frame.size.width / 2, y: self.size.height / 2)
        self.addChild(road)
        roadMark = SKSpriteNode(imageNamed: "roadMark")
        roadMark.name = "roadMark"
        roadMark.size = CGSize(width: self.size.width / 25, height: self.size.height / 15)
        roadMark.position = CGPoint(x: 0 , y: self.size.height / 2)
        self.addChild(roadMark)
    }
    //MARK: - move road mark
    private func moveRoadMark() {
        self.enumerateChildNodes(withName: "roadMark", using: ({ node, error in
            node.position.y -= 23
            self.roadMark.size.height += 2
            self.roadMark.size.width += 2
            if node.position.y < -(self.size.height) {
                node.position.y = self.size.height / 2
                self.roadMark.size = CGSize(width: self.size.width / 25, height: self.size.height / 15)
            }
        }))
    }
}
