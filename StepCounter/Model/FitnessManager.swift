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
    
    private init() {}
    
    func startCounts (completion: @escaping (NSNumber?, Error?) -> Void) {
        if CMPedometer.isStepCountingAvailable() {
            print("Available")
            stepCounter.startUpdates(from: Date(), withHandler: { (data, error) in
                print("start updates")
                if error != nil {
                    completion(nil, error)
                } else if error == nil {
                    if let steps = data?.numberOfSteps {
                        completion(steps, nil)
                    }
                }
            })
        } else {
            print("Not available!")
        }
    }
    
    func stopCounts () {
        print("Stops updates")
        stepCounter.stopUpdates()
    }
    
    
}










