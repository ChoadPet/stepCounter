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
    
    // MARK: - Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nickanameTextField.delegate = self
    }

    // MARK: - Actions
    @IBAction func nextPressed(_ sender: UIButton) {
        
        if !(nickanameTextField.text?.isEmpty)! {
            UserDefaults.standard.set(nickanameTextField.text, forKey: "name")
            performSegue(withIdentifier: "toMainScreen", sender: self)
        } else {
            print("Empty nicknameTextField!")
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nickanameTextField.resignFirstResponder()
    }

}
