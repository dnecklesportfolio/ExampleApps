//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate{
  var player: AVAudioPlayer
    let soundArray = ["note1","note2","note3","note4","note5","note6","note7",]

    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        
       playSound()
       
    }
    func playSound() {
        let path = Bundle.main.path(forResource: "note1", ofType : "wav")!
        let soundUrl = URL(fileURLWithPath : path)
        
        do {
            player = try AVAudioPlayer(contentsOf: soundUrl)
            
            
        } catch {
            
            print ("There is an issue with this code! "+ error)
            
        }
        player?.play()
    }
  

}

