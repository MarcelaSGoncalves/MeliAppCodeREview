//
//  FavoritesViewController.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import UIKit

class FavoritesViewController: UIViewController, UISearchBarDelegate {
    
    var screen = FavoritesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = screen
        screen.configNavigationController(viewController: self, delegateBar: self)
    }
}
