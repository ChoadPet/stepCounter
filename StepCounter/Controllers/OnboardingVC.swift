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
    @IBOutlet weak var errorLbl: UILabel!
    
    // MARK: - Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLbl.isHidden = true
        self.nickanameTextField.delegate = self
    }
    
    // MARK: - Actions
    //TODO: - create func for saving new user into table.
    @IBAction func nextPressed(_ sender: UIButton) {
        
        if !(nickanameTextField.text?.isEmpty)! {
            let newUser: [String: Any] = ["Nickname" : nickanameTextField.text!, "numberOfSteps" : 0]
            let backendless = Backendless.sharedInstance()!
            let dataStore = backendless.data.ofTable("Runners")
            
            dataStore?.save(newUser,
                            response: {
                                (result) -> () in
                                print("Object is saved in Backendless. Please check in the console.")
                                DispatchQueue.main.async {
                                    self.errorLbl.isHidden = true
                                    UserDefaults.standard.set(self.nickanameTextField.text, forKey: "name")
                                    self.performSegue(withIdentifier: "toMainScreen", sender: self)
                                }
            },
                            error: {
                                (fault : Fault?) -> () in
                                print("Server reported an error: \(String(describing: fault))")
                                if fault?.faultCode == "1155" {
                                    print("There is already user with this nickname!")
                                    DispatchQueue.main.async {
                                        self.customizeErroLbl(color: UIColor.red, text: "There is already user with this nickname!", hidden: false)
                                    }
                                } else {
                                    print("Some error!")
                                    self.customizeErroLbl(color: UIColor.red, text: "\(String(describing: fault))!", hidden: false)
                                }
            })
        } else {
            print("Empty nicknameTextField!")
            DispatchQueue.main.async {
                self.customizeErroLbl(color: UIColor.yellow, text: "Warning: Empty nickname field!", hidden: false)
            }
        }
        
    }
    
    func customizeErroLbl(color: UIColor, text: String, hidden: Bool) {
        self.errorLbl.isHidden = hidden
        self.errorLbl.text = text
        self.errorLbl.textColor = color
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
