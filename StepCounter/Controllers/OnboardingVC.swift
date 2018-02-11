//
//  OnboardingVC.swift
//  StepCounter
//
//  Created by Vetaliy Poltavets on 2/10/18.
//  Copyright © 2018 vpoltave. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nickanameTextField: UITextField!
    
    let APPLICATION_ID = "28C19918-1E3D-DCC8-FF9F-EC6960A35800"
    let API_KEY = "F25BE17E-A48A-6A87-FF08-B7AB35ABAD00"
    let SERVER_URL = "https://api.backendless.com"
    let backendless = Backendless.sharedInstance()!

    // MARK: - Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        backendless.hostURL = SERVER_URL
        backendless.initApp(APPLICATION_ID, apiKey: API_KEY)
        self.nickanameTextField.delegate = self
    }

    // MARK: - Actions
    @IBAction func nextPressed(_ sender: UIButton) {
        
        if !(nickanameTextField.text?.isEmpty)! {
            let dataStore = backendless.data.ofTable("Runners")
            let newUser = ["Nickname" : nickanameTextField.text]
            dataStore?.save(newUser,
                            response: {
                                (result) -> () in
                                print("Object is saved in Backendless. Please check in the console.")
                                DispatchQueue.main.async {
                                    UserDefaults.standard.set(self.nickanameTextField.text, forKey: "name")
                                    self.performSegue(withIdentifier: "toMainScreen", sender: self)
                                }
            },
                            error: {
                                (fault : Fault?) -> () in
                                print("Server reported an error: \(String(describing: fault))")
                                if fault?.faultCode == "1155" {
                                    print("There is already user with this nickname!")
                                } else {
                                    print("Some error!")
                                }
            })
        } else {
            print("Empty nicknameTextField!")
        }
        
    }
    
    // MARK: - Keyboard hidding 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nickanameTextField.resignFirstResponder()
    }

}
