//
//  SearchViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/01.
//

import UIKit

protocol SearchDelegate{
    func searchResultDidSave(vm : SearchResultViewModel)
}

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var delegate : SearchDelegate?
    var searchManager = SearchManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SearchViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        self.performSegue(withIdentifier: "searchResult", sender: nil)
        
//        if searchBar.text! != nil{
//            searchManager.search(text: searchBar.text!) { vm in
//                print("move search result page")
//                self.delegate?.searchResultDidSave(vm: vm)
//
//            }
//        }
        
    }
}
