//
//  RegisterViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/29.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    let imagePickerController = UIImagePickerController()
    let alterController = UIAlertController(title: "올릴 방식을 선택하세요", message: "카메라 또는 앨범", preferredStyle: .actionSheet)
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //profile image setting
        addGestureRecognizer()
        enrollAlertEvent()
        self.imagePickerController.delegate = self
        
        setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp(){
        let navBarAppearance = UINavigationBarAppearance()
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func pressedRegister(_ sender: UIButton) {
        guard let email = self.emailTextField.text else {return}
        guard let name = self.nameTextField.text else {return}
        guard let password = self.passwordTextField.text else {return}
        let registerModel = RegisterReqModel(name: name, email: email, password: password)
        UserManager.shared.register(model: registerModel){ (isSuccess) in
            if isSuccess{
                let alert = UIAlertController(title: "성공", message: "회원가입완료", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
            }else{
                print("Error")
            }
        }
        
    }
    
    func enrollAlertEvent(){
        let photoLibraryAlertAction = UIAlertAction(title: "앨범", style: .default) { (action) in
            self.openAlbum()
        }
        let cameraAlertAction = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        self.alterController.addAction(photoLibraryAlertAction)
        self.alterController.addAction(cameraAlertAction)
        self.alterController.addAction(cancelAlertAction)
        guard let alertControllerPopoverPresentationController = alterController.popoverPresentationController else {return}
        prepareForPopoverPresentation(alertControllerPopoverPresentationController)
    }
    
    func addGestureRecognizer(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedProfileImageView(_:)))
        self.profileImage.addGestureRecognizer(tapGestureRecognizer)
        self.profileImage.isUserInteractionEnabled = true
    }
    
    @objc func tappedProfileImageView(_ gesture : UITapGestureRecognizer){
        self.present(alterController, animated: true, completion: nil)
    }
    
}

extension RegisterViewController : UIPopoverPresentationControllerDelegate{
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController){
        if let popoverPresentationController = self.alterController.popoverPresentationController{
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        
    }
}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func openAlbum(){
        self.imagePickerController.sourceType = .photoLibrary
        present(self.imagePickerController, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            profileImage.image = image
        }else{
            print("Error detected in didFinishPickingMediaWithInfo method")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.imagePickerController.sourceType = .camera
            present(self.imagePickerController, animated: false, completion: nil)
        }else{
            print("Camera not available as for now")
        }
    }
}
