//
//  HomeViewController.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import UIKit
import Foundation


class HomeViewController: UIViewController{
    
    var myViewModel = HomeViewModel()
    var screen = HomeView()
    var categoryText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = screen
        screen.configNavigationController(viewController: self, delegateBar: self)
    }
}

extension HomeViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ barSearchBar: UISearchBar) {
        search(shouldShow: true)
    }
    
    func searchBarTextDidEndEditing(_ barSearchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBarCancelButtonClicked(_ barSearchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ barSearchBar: UISearchBar, textDidChange searchText: String) {
        categoryText = searchText
        search(shouldShow: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        screen.createDismissKeyboard()
        searchBar.resignFirstResponder()
        self.myViewModel.getToken(category: self.categoryText)
        self.callNextScreen()   
    }
    
    
    func callNextScreen(){
        let searchViewController = SearchViewController(myViewModel: myViewModel)
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }

    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        screen.barSearchBar.showsCancelButton = shouldShow
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(handleShowSearchBar))
            
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func handleShowSearchBar(){
        screen.barSearchBar.becomeFirstResponder()
        search(shouldShow: true)
    }
}

