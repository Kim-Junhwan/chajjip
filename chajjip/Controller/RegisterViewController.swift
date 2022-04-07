//
//  RegisterViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/29.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var profileImage: UIButton!
    
    @IBAction func addProfileImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "선택", message: "어디서 사진을 가져오시겠습니까?", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) { action in
            //self.openLibrary()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressedRegister(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
