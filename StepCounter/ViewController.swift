//
//  ViewController.swift
//  StepCounter
//
//  Created by Vetaliy Poltavets on 2/9/18.
//  Copyright © 2018 vpoltave. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var stepsLbl: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    let stepsManager = StepManager.shared
    
    // class lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepsLbl.text = ""
        startButton.layer.cornerRadius = startButton.layer.frame.size.height / 2
        startButton.isSelected = false
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        
        if sender.isSelected == false {
            buttonCustomize(button: sender, title: "Stop", color: UIColor.stopRed(), state: true)
            
            stepsManager.startCounts { [weak self] (stepsCount, error) in
                if error != nil {
                    print("not autor. error")
                } else {
                    DispatchQueue.main.async {
                        self?.stepsLbl.text = String(describing: stepsCount!)
                    }
                }
            }
        } else {
            stepsLbl.text = ""
            buttonCustomize(button: sender, title: "Start", color: UIColor.startVolt(), state: false)
            stepsManager.stopCounts()
        }
        
    }
    
    func buttonCustomize(button: UIButton, title: String, color: UIColor, state: Bool) {
        button.isSelected = state
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
    }
    
    
}

extension UIColor {
    class func stopRed() -> UIColor {
        return UIColor(red:0.70, green:0.00, blue:0.04, alpha:1.0)
    }
    class func startVolt() -> UIColor {
        return UIColor(red:0.81, green:1.00, blue:0.00, alpha:1.0)
    }
}

