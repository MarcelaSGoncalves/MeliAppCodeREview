//
//  HomeView.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import UIKit

class HomeView: UIView {
    
    var viewcontroller = UIViewController()
    var categoryText: String = ""
//    var delegate = self
   

    let barSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.backgroundColor = .white
        searchBar.placeholder = "Buscar no Mercado Livre"
        return searchBar
    }()
    
    lazy var logoImage: UIImageView = {
        var myLogo = UIImageView()
        myLogo.contentMode = UIView.ContentMode.scaleAspectFit
        myLogo.frame.size.width = 80
        myLogo.frame.size.height = 80
        myLogo.translatesAutoresizingMaskIntoConstraints = false
        return myLogo
    }()
    
    
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
        
        logoImage.image = UIImage(named: "mercadolivrelogo.png")
        addSubview(logoImage)
    }
    
    func setupConstrains(){
        logoImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
   func configNavigationController(viewController: UIViewController, delegateBar:UISearchBarDelegate){
        backgroundColor = .white
        barSearchBar.sizeToFit()
        barSearchBar.delegate = delegateBar
        viewController.navigationController?.navigationBar.tintColor = .black

        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = UIColor(named: "maincolor")

        viewcontroller = viewController
        viewcontroller.navigationItem.titleView = barSearchBar
        viewcontroller.navigationController?.navigationBar.isTranslucent = false
        viewcontroller.navigationController?.navigationBar.standardAppearance = appearence
        viewcontroller.navigationController?.navigationBar.scrollEdgeAppearance = appearence
//        viewcontroller.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(tryThis))
        barSearchBar.showsCancelButton = false
       
    }
    
//    @objc func tryThis(){
//        print("Carrinho funcionando")
//    }

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


    

