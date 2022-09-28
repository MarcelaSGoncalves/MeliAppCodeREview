//
//  Service.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 17/09/22.
//

import Foundation
import UIKit

class Service {
    
    static var shared = Service()
    var token = "APP_USR-7169050861406625-091909-3d83ea30539c34568e0dc2716d66dc83-45988325"
    
    private let baseUrl = "https://api.mercadolibre.com/"
    
    func getToken(completed: @escaping (Result<TokenModel, MLError>) -> Void) {
        let tokenUrl = "oauth/token"
        let endpoint = URL(string: baseUrl + tokenUrl)
        
        guard let url = endpoint else {
            completed(.failure(.invalidToken))
            return
        }
        
        var request = URLRequest(url: url)
        let body: [String: AnyHashable] = [
            "grant_type": "authorization_code",
            "client_id": 7169050861406625,
            "client_secret": "YXlwLGmzU2OSzSTI3zr2LutZ1XxU3clx",
            "code": "TG-6328ae1bbb8bfc0001c673c3-45988325",
            "redirect_uri" : "https://www.alkemy.org/"]
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        //Make request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { //400, 401, 500, 200(quando é sucess
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
            return
            }
            do {
                let response = try JSONDecoder().decode(TokenModel.self, from: data)
                self.token = response.access_token
                completed(.success(response))
            }
            catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
}
    
    func getCategory(search: String, completed: @escaping (Result<[CategoryModel], MLError>) -> Void) {
        let categoryURl = "sites/MLB/domain_discovery/search?limit=1&q="
        let endpoint = URL(string: baseUrl + categoryURl + "\(search)")
        
        guard let url = endpoint else {
            completed(.failure(.invalidCategory))
            return
        }
                      
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    completed(.failure(.unableToComplete))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let categoryDecoded = try decoder.decode([CategoryModel].self, from: data)
                completed(.success((categoryDecoded)))
                return
            }
            catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    

    func getProducts(products: String, completed: @escaping (Result<NewContent, MLError>) -> Void) {
        let itensDetailsURl = "highlights/MLB/category/"
        let endpoint = URL(string: baseUrl + itensDetailsURl + "\(products)")
        guard let url = endpoint else {
            completed(.failure(.invalidProducts))
            return
        }
        var request1 = URLRequest(url: url)
        request1.httpMethod = "GET"
        request1.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request1) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let categoryDecoded = try decoder.decode(NewContent.self, from: data)
                completed(.success(categoryDecoded))
            }
            catch{
                completed(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
    
    func getDetailsProducts(params: String, completed: @escaping (Result<[MultiGet], MLError>) -> Void) {
        let itensURl = "items?ids="
        let endpoint = URL(string: baseUrl + itensURl + "\(params)")
        
        guard let url = endpoint else {
            completed(.failure((.invalidDetailProducts)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let categoryDecoded = try decoder.decode([MultiGet].self, from: data)
                completed(.success(categoryDecoded))
            }
            catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
