//
//  SearchViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/01.
//

import UIKit


class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SearchResultTableViewController{
            guard let vc = segue.destination as? SearchResultTableViewController else {return}
            vc.text = searchBar.text!
        }
    }
    
}

//여기서 검색이 아닌 검색키워드를 tableView에 넘겨준 후 SearchManager를 통해 검색
extension SearchViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.performSegue(withIdentifier: "searchResult", sender: nil)
    }
}
