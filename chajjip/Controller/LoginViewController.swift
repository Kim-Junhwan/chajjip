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
    
    //임시 로그인 유저 정보
    let dummyUser = User(name: "Jaoson Park", email: "abcde@gmail.com", password: "12345", age: 22, sex: true, phoneNumber: "010-1234-5678")
    
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
        UserManager.shared.saveUserInfo(model: dummyUser)
    }
}
