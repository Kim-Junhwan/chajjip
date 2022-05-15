//
//  SearchResultTableViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/01.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    //dummy data
    var searchResultViewModel : RecommendViewModel!
    var searchManager = SearchManager()
    var text = ""
    var selectedShop : Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("text : \(text)")
        
        searchManager.search(text: text) { result in
            self.searchResultViewModel = RecommendViewModel(shopList: result)
        }
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResultViewModel.numOfShopList()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexShop = searchResultViewModel.shopAtIndex(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! SearchResultCell
        cell.resultLabel.text = indexShop.name
        cell.resultImage.image = indexShop.shopImage
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //info = DummyData.shop[indexPath.row]
        selectedShop = searchResultViewModel.shopAtIndex(indexPath.row).shop
        performSegue(withIdentifier: "showMoreInfo", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedShop = selectedShop else {return}
        if segue.identifier == "showMoreInfo"{
            let vc = segue.destination as! MoreInfoViewController
            vc.shop = selectedShop
        }
    }

}
