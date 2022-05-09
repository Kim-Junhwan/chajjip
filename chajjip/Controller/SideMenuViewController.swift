//
//  SideMenuViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/27.
//

import UIKit

class SideMenuViewController: UIViewController {
    

    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var loginStatusView: UIView!
    @IBOutlet weak var loginProfileLabel: UILabel!
    @IBOutlet weak var loginLogOutButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    
    let menuItem = ["공지사항","내프로필","여행지지도","식당지도"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        //menuTableView set separatorStyle
        setMenuTableView()
        
        if UserDefaults.standard.bool(forKey: "status"){
            logInSideMenuSetUp()
        }else{
            nonLogInSideMenuSetUp()
        }
    }
    
    //MARK: - Set MenuTableViewUI
    func setMenuTableView(){
        menuTableView.separatorStyle = .none
    }
    
    //MARK: - loginSideMenu Setting
    func logInSideMenuSetUp(){
        print("LogInSideMenu")
        loginProfileLabel.text = "ABC님"
        loginLogOutButton.setImage(UIImage(named: "logOut_icon"), for: .normal)
        
        //setTitle 적용시 font 적용이 안됨. 추후 수정
        loginLogOutButton.titleLabel?.font = UIFont(name: "ArialHebrew", size: 30.0)
        loginLogOutButton.setTitle("로그아웃", for: .normal)
    }
    
    //MARK: - nonLoginSideMenu Setting
    func nonLogInSideMenuSetUp(){
        print("nonLogInSideMenu")
        loginProfileLabel.text = "로그인해 주세요."
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
        let largeImage = UIImage(systemName: "lock.fill", withConfiguration: largeConfig)
        loginLogOutButton.setImage(largeImage, for: .normal)
    }
    
    @IBAction func pressLogInOutButton(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: "status"){
            UserDefaults.standard.set(false, forKey: "status")
            self.dismiss(animated: true, completion: nil)
        }else{
            self.performSegue(withIdentifier: "loginPage", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(true, animated: true) // 뷰 컨트롤러가 나타날 때 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(false, animated: true) // 뷰 컨트롤러가 사라질 때 나타내기
    }
}

extension SideMenuViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = menuItem[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
