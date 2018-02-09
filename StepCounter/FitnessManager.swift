//
//  FitnessManager.swift
//  StepCounter
//
//  Created by Vetaliy Poltavets on 2/9/18.
//  Copyright © 2018 vpoltave. All rights reserved.
//

import Foundation
import CoreMotion

class StepManager {
    
    static let shared = StepManager()
    
    private let stepCounter = CMPedometer()
    private let currentDateTime = Date()
    
    private init() {}
    
    func countSteps(completion: @escaping (NSNumber?, Error?) -> Void) {
        if CMPedometer.isStepCountingAvailable() {
            print("Available")
            stepCounter.startUpdates(from: currentDateTime, withHandler: { (data, error) in
                if error != nil {
                    completion(nil, error)
                } else if error == nil {
                    
                    if let steps = data?.numberOfSteps {
                        completion(steps, nil)
                    }
                }
            })
        } else {
            print("not available")
        }
        
        
    }
    
//    if CMPedometer.isStepCountingAvailable() {
//    print("Step counting is available.")
//    stepCounter.startUpdates(from: currentDateTime, withHandler: { [weak self] (data, error) in
//    if error == nil {
//
//    /// Start timer here
//
//    if let steps = data?.numberOfSteps {
//    print("Number of steps: \(steps)")
//    DispatchQueue.main.async {
//    self?.stepsLbl.text = String(describing: steps)
//    }
//    }
//    } else {
//    print("Error happened: \(error!.localizedDescription)")
//    }
//    })
//    } else {
//    print("Device doesn't support step counter.")
//    }
//
    
    
}
