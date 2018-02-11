//
//  UserInfo.swift
//  StepCounter
//
//  Created by Vetaliy Poltavets on 2/10/18.
//  Copyright © 2018 vpoltave. All rights reserved.
//

import Foundation

final class User {
    
    static var totalSteps = UserDefaults.standard.value(forKey: "totalSteps") as? Int ?? 0
    static var currentSessionSteps = 0
    
    static func updateSteps() {
        self.totalSteps += self.currentSessionSteps
        UserDefaults.standard.set(self.totalSteps, forKey: "totalSteps")
        currentSessionSteps = 0
    }
    
    //    class func newRunner(newUser: [String: Any], completion: () -> Void) {
    //        let backendless = Backendless.sharedInstance()!
    //        let dataStore = backendless.data.ofTable("Runners")
    //
    //        dataStore?.save(newUser,
    //                        response: {
    //                            (result) -> () in
    //                            print("Object is saved in Backendless. Please check in the console.")
    //                            DispatchQueue.main.async {
    //                                UserDefaults.standard.set(self.nickanameTextField.text, forKey: "name")
    //                                self.performSegue(withIdentifier: "toMainScreen", sender: self)
    //                            }
    //        },
    //                        error: {
    //                            (fault : Fault?) -> () in
    //                            print("Server reported an error: \(String(describing: fault))")
    //                            if fault?.faultCode == "1155" {
    //                                print("There is already user with this nickname!")
    //                            } else {
    //                                print("Some error!")
    //                            }
    //        })
    //    } else {
    //    print("Empty nicknameTextField!")
    //    }
    //}
    
    class func updateTable() {
        print("Table updating...")
        if let nickname = UserDefaults.standard.value(forKey: "name") {
            let whereClause = "Nickname = '\(nickname)'"
            let queryBuilder = DataQueryBuilder()
            queryBuilder!.setWhereClause(whereClause)
            let backendless = Backendless.sharedInstance()!
            
            let dataStore = backendless.data.ofTable("Runners")
            dataStore?.find(queryBuilder,
                            response: {
                                (foundContacts) -> () in
                                var foundConts = foundContacts as! [[String : Any]]
                                updateRunnerSteps(currentUser: &foundConts[0])
            },
                            error: {
                                (fault : Fault?) -> () in
                                print("Server reported an error: \(fault!)")
            })
            
        }
    }
    
    class private func updateRunnerSteps(currentUser: inout [String: Any]) {
        let backendless = Backendless.sharedInstance()!
        let dataStore = backendless.data.ofTable("Runners")
        currentUser["numberOfSteps"] = totalSteps
        dataStore?.save(currentUser,
                        response: {
                            (updatedContact) -> () in
                            print("Contact saved")
        },
                        error: {
                            (fault : Fault?) -> () in
                            if let fault = fault {
                                print("Server error: \(fault)")
                            }
        })
    }
    
}
