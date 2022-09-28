//
//  SearchView.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import UIKit

class SearchView: UIView {
    
    lazy var categoryLabel: UILabel = {
        let myLAbel = UILabel()
        myLAbel.text = ""
        myLAbel.tintColor = .black
        myLAbel.translatesAutoresizingMaskIntoConstraints = false
        return myLAbel
    }()
   
    lazy var myTableView: UITableView = {
        let mytableView = UITableView()
        mytableView.translatesAutoresizingMaskIntoConstraints = false
        mytableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        mytableView.rowHeight = 147
        return mytableView
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
        addSubview(myTableView)
    }
    
    func setupConstrains(){
        myTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func configTableViewController(delegateTable:UITableViewDelegate, dataSourceTable: UITableViewDataSource){
        backgroundColor = .white
        myTableView.delegate = delegateTable
        myTableView.dataSource = dataSourceTable
     }

}
