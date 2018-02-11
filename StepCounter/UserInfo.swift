//
//  UserInfo.swift
//  StepCounter
//
//  Created by Vetaliy Poltavets on 2/10/18.
//  Copyright © 2018 vpoltave. All rights reserved.
//

import Foundation

class User {
    
    static var totalSteps = 0
    static var currentSessionSteps = 0
    
    static func updateSteps() {
        self.totalSteps += self.currentSessionSteps
        currentSessionSteps = 0
    }
}
