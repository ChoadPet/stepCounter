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
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var totalStepsLbl: UILabel!
    
    let stepsManager = StepManager.shared
    
    // MARK: - Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = UserDefaults.standard.value(forKey: "name") {
            welcomeLbl.text = "Welcome, \(name)!"
        }
        stepsLbl.text = ""
        startButton.layer.cornerRadius = startButton.layer.frame.size.height / 2
        startButton.isSelected = false
    }
    
    // MARK: - Actions
    @IBAction func startPressed(_ sender: UIButton) {
        
        if sender.isSelected == false {
            buttonCustomize(button: sender, title: "Stop", color: UIColor.stopRed(), state: true)
            stepsManager.startCounts { [weak self] (stepsCount, error) in
                if error != nil {
                    print("not autor. error")
                } else {
                    User.currentSessionSteps = stepsCount as! Int
                    DispatchQueue.main.async {
                        self?.stepsLbl.text = String(describing: stepsCount!)
                    }
                }
            }
        } else {
            stepsLbl.text = ""
            buttonCustomize(button: sender, title: "Start", color: UIColor.startVolt(), state: false)
            stepsManager.stopCounts()
            User.updateSteps()
            totalStepsLbl.text = String(describing: User.totalSteps)
            print("Number of total steps: \(User.totalSteps)")
        }
        
    }
    
    func buttonCustomize(button: UIButton, title: String, color: UIColor, state: Bool) {
        button.setTitle(title, for: .normal)
        button.isSelected = state
        button.backgroundColor = color
    }
    
    
}

// MARK: - Extensions
extension UIColor {
    class func stopRed() -> UIColor {
        return UIColor(red:0.70, green:0.00, blue:0.04, alpha:1.0)
    }
    class func startVolt() -> UIColor {
        return UIColor(red:0.81, green:1.00, blue:0.00, alpha:1.0)
    }
}

