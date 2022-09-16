//
//  MediaPlayer.swift
//  The_final_run
//
//  Created by Maksim Matveichuk on 12.Sep.22.
//

import Foundation
import MediaPlayer

class Player {
    
    private var player: AVAudioPlayer!
    
    func play(resourse: URL, endlessCycle: Bool) {
        do {
            player = try AVAudioPlayer(contentsOf: resourse)
            if endlessCycle {
                player.numberOfLoops = -1
            }
            player.volume = UserDefaults.standard.object(forKey: "volume") as? Float ?? 1.0 
            player.play()
        } catch {
            print("error")
        }
    }
    
    func stop() {
        player.stop()
    }
}
