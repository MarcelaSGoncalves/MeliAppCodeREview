//
//  SearchViewController.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import UIKit


protocol SearchViewControllerProtocol {
    func reloadData()
}

class SearchViewController: UIViewController, UISearchBarDelegate{
    
    var myViewModel: HomeViewModel
    var screen = SearchView()
    var category = "teste"

    override func viewDidLoad() {
        super.viewDidLoad()
        screen.configTableViewController(delegateTable: self, dataSourceTable: self)
        myViewModel.delegate = self
    }
    
    override func loadView() {
        self.screen = SearchView()
        self.view = screen
    }
    
    init(myViewModel: HomeViewModel){
        self.myViewModel = myViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(myViewModel.productsDetails.count)
        return myViewModel.productsDetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = screen.myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let index = indexPath.row
        let product = myViewModel.productsDetails[index]
        cell.setCell(title: product.body.title, subtitle: product.body.subtitle, price: product.body.price, myImageLink: product.body.secure_thumbnail)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    func reloadData() {
            screen.myTableView.reloadData()
    }
}


