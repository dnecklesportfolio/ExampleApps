//
//  ViewController.swift
//  BullsEye
//
//  Created by Dwayne Neckles on 9/11/19.
//  Copyright © 2019 Dwayne Neckles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      startNewGame()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func showAlert() {
        
 let difference = abs(currentValue - targetValue)
    var points = 100 - difference

        let title:String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            
            if difference == 1 {
                points += 50
            }
            
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        let message = "You scored \(points) points"

                score += points
        // top part copy
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        //bottom part action
        let action = UIAlertAction(title: "Ok", style: .default,   handler: { _ in
            self.startNewRound()
        })
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil)
 
    }
    
    @IBAction func startOver() {
        startNewGame()
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
    
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in:1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
         roundLabel.text = String(round)
    }
}

