//
//  SearchTableViewCell.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell{
    
    lazy var productsLabel: UILabel = {
        let myTitleLabel = UILabel()
        myTitleLabel.textAlignment = .left
        myTitleLabel.tintColor = .black
        myTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        myTitleLabel.font = UIFont.systemFont(ofSize: 18)
        myTitleLabel.numberOfLines = 0
        myTitleLabel.textColor = .black
     //   myTitleLabel.lineBreakMode = .byWordWrapping
        return myTitleLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
        let myTitleLabel = UILabel()
        myTitleLabel.tintColor = .black
        myTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return myTitleLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let myTitleLabel = UILabel()
        myTitleLabel.tintColor = .black
        myTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return myTitleLabel
    }()
    
    lazy var myImage: UIImageView = {
        let myImage = UIImageView()
        myImage.layer.cornerRadius = 10
        myImage.clipsToBounds = true
        myImage.translatesAutoresizingMaskIntoConstraints = false
        return myImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews(){
        addSubview(myImage)
        addSubview(productsLabel)
        addSubview(subtitleLabel)
        addSubview(priceLabel)
    }
    
    private func setConstraints(){
        myImageContrains()
        productsLabelConstraints()
        subtitleLabelConstraints()
        priceLabelConstraints()
    }
    
    private func myImageContrains(){
        myImage.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        myImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        myImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
        myImage.heightAnchor.constraint(equalToConstant: 131).isActive = true
        myImage.widthAnchor.constraint(equalToConstant: 131).isActive = true
        
    }
    
    private func productsLabelConstraints(){
        productsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        productsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        productsLabel.leadingAnchor.constraint(equalTo: myImage.trailingAnchor, constant: 16).isActive = true

    }
    
    private func subtitleLabelConstraints(){
        subtitleLabel.topAnchor.constraint(equalTo: productsLabel.bottomAnchor, constant: 8).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: myImage.trailingAnchor, constant: 16).isActive = true
    }
    
    private func priceLabelConstraints(){
        priceLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: myImage.trailingAnchor, constant: 16).isActive = true
    }
    
    func setCell(title: String, subtitle: String?, price: Double, myImageLink: String){
        loadFrom(URLAddress: myImageLink)
     //   myImage.image = UIImage(data: imageData?)
        productsLabel.text = title
        subtitleLabel.text = subtitle
        let stringPrice = String(format: "%.2f", price)
        priceLabel.text = "R$ \(stringPrice)"
//        myImage.image = UIImage(named: "cart")
//        productsLabel.text = "Produto Teste"
//        subtitleLabel.text = "Esse é um subittile"
//        priceLabel.text = "R$ 999,99"
        
    }
    
    func loadFrom(URLAddress: String) {
           guard let url = URL(string: URLAddress) else {
               return
           }
           
           DispatchQueue.main.async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let loadedImage = UIImage(data: imageData) {
                       self!.myImage.image = loadedImage
                   }
               }
           }
    }
}
