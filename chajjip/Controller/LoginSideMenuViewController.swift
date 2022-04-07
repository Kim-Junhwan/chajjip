//
//  SideMenuViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/27.
//

import UIKit

class LoginSideMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var items = ["로그인","설정"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension LoginSideMenuViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let vc = segue.destination as! LoginViewController
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
}

extension LoginSideMenuViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row{
        case 0:
            performSegue(withIdentifier: "login", sender: nil)
            break
        default:
            break
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
