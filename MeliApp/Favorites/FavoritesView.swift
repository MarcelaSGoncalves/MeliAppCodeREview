//
//  FavoritesView.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import UIKit

class FavoritesView: UIView {
    
    let barSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.placeholder = "Buscar nos seus itens Favoritos"
        return searchBar
    }()
    
//    let myScrollView: UIScrollView{
//
//    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){

    }
    
    func setupConstrains(){
        
    }
    
   func configNavigationController(viewController: UIViewController, delegateBar:UISearchBarDelegate){
        backgroundColor = .white
        barSearchBar.sizeToFit()
        barSearchBar.delegate = delegateBar
        viewController.navigationController?.navigationBar.tintColor = .black

        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = UIColor(named: "maincolor")

        let viewcontroller = viewController
        viewcontroller.navigationItem.titleView = barSearchBar
        viewcontroller.navigationController?.navigationBar.isTranslucent = false
        viewcontroller.navigationController?.navigationBar.standardAppearance = appearence
        viewcontroller.navigationController?.navigationBar.scrollEdgeAppearance = appearence
        barSearchBar.showsCancelButton = false
       
    }
    
    func createDismissKeyboard(){
        barSearchBar.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        endEditing(true)
    }
}
