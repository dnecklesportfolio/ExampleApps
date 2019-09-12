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
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func showAlert() {
        
 let difference = abs(currentValue - targetValue)
    let points = 100 - difference
        score += points
        
       let message = "You scored \(points) points"
        
        // top part copy
        let alert = UIAlertController(title: "Hello, World", message: message , preferredStyle: .alert)
        //bottom part action
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action);
        present(alert, animated: true, completion: nil)
        startNewRound()
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
    
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        targetValue = Int.random(in:1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    func updateLabels() {
        targetLabel.text = String(targetValue)
    }
}

