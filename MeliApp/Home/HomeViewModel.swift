//
//  HomeViewModel.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 17/09/22.
//

import Foundation
import UIKit

protocol HomeViewDelegate {
    func setProductsDetails(arrayProduct: [MultiGet])
}

class HomeViewModel {
    

    let service = Service()
    var products: [MyProducts] = []
    var categories = [CategoryModel]()
    var productsList: NewContent = {
        return NewContent(content: [])
    }()
    var productsDetails: [MultiGet] = []
    var delegate: SearchViewControllerProtocol?
    
    
    
    func getToken(category: String) {
        let group = DispatchGroup()
        group.enter()
        Service.shared.getToken() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let token):
                self.service.token = token.access_token
//                self.getCategory(category: category)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.getCategory(category: category)
        }
    }
    
    func getCategory(category: String){
        let group = DispatchGroup()
        group.enter()
        Service.shared.getCategory(search: category) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let categories):
                self.categories = categories
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.getProducts(category: self.categories[0].category_id)
        }
    }
    
    func getProducts(category: String){
        let group = DispatchGroup()
        group.enter()
        Service.shared.getProducts(products: category) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let productsList):
                self.productsList = productsList
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.getDetailsProducts(productsList: self.productsList)
        }
    }
    
    func getDetailsProducts(productsList : NewContent){
        
        
        let ids = productsList.content.map { product in
            return product.id
        }
        let params = ids.joined(separator: ",")
        
        let group = DispatchGroup()
        group.enter()
        Service.shared.getDetailsProducts(params: params){ result in
            
            switch result {
            case .success(let productsDetails1):
                self.productsDetails = productsDetails1
                print(self.productsDetails)
            case .failure(let error):
                print(error)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.delegate?.reloadData()
        }
    }
}



