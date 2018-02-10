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
    
    let APPLICATION_ID = "28C19918-1E3D-DCC8-FF9F-EC6960A35800"
    let API_KEY = "F25BE17E-A48A-6A87-FF08-B7AB35ABAD00"
    let SERVER_URL = "https://api.backendless.com"
    let backendless = Backendless.sharedInstance()!
    
    @IBOutlet weak var stepsLbl: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var welcomeLbl: UILabel!
    
    let stepsManager = StepManager.shared
    
    /// class lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backendless.hostURL = SERVER_URL
        backendless.initApp(APPLICATION_ID, apiKey: API_KEY)
        if let name = UserDefaults.standard.value(forKey: "name") {
            welcomeLbl.text = "Welcome, \(name)!"
        }
        stepsLbl.text = ""
        startButton.layer.cornerRadius = startButton.layer.frame.size.height / 2
        startButton.isSelected = false
    }
    
    // actions
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

