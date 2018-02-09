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
    let stepsManager = StepManager.shared
    
    // class lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        stepsManager.countSteps { [weak self] (stepsCount, error) in
            if error != nil {
                print("error happened.")
            } else {
                DispatchQueue.main.async {
                    self?.stepsLbl.text = String(describing: stepsCount)
                }
            }
        }
//        StepManager.countSteps()
    }
    
}

