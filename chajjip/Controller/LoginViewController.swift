//
//  LoginViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/27.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func pressedLogin(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "status")
        UserDefaults.standard.set(idTextField.text, forKey: "id")
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
