//
//  ProfileSideViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/30.
//

import UIKit

class ProfileSideViewController: UIViewController {
    
    @IBOutlet weak var loginProfileName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var items = ["프로필 설정","설정","로그아웃"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loginProfileName.text = UserDefaults.standard.string(forKey: "id")
        // Do any additional setup after loading the view.
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

extension ProfileSideViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMenuItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
}

extension ProfileSideViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UserDefaults.standard.set(false, forKey: "status")
        dismiss(animated: true, completion: nil)
    }
}
