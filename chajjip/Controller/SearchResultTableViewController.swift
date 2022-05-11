//
//  SearchResultTableViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/01.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    //dummy data
    var searchResultViewModel = DummyData.shop

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultViewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! SearchResultCell
        cell.resultLabel.text = DummyData.shop[indexPath.row].name
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //info = DummyData.shop[indexPath.row]
        performSegue(withIdentifier: "showMoreInfo", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMoreInfo"{
            let vc = segue.destination as! MoreInfoViewController
           // vc.moreInfo = info
        }
    }

}

extension SearchResultTableViewController : SearchDelegate{
    
    func searchResultDidSave(vm: SearchResultViewModel) {
        print("Search View Model : \(vm)")
    }
    
    
}
