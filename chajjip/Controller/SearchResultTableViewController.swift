//
//  SearchResultTableViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/01.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    //dummy data
    var searchList = DummyData()
    var info : TouristAndRestaurant?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DummyData.places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! SearchResultCell
        cell.resultLabel.text = DummyData.places[indexPath.row].name
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        info = DummyData.places[indexPath.row]
        performSegue(withIdentifier: "showMoreInfo", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMoreInfo"{
            let vc = segue.destination as! MoreInfoViewController
            vc.moreInfo = info
        }
    }

}
