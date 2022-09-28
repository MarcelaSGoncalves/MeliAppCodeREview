//
//  ProductsManager.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import Foundation
import UIKit

class Products2Manager {
    
    static let shared = Products2Manager()
    private let baseURl = "https://api.mercadolibre.com/sites/MLB/domain_discovery/search?limit=1&q="
    let token = "APP_USR-7169050861406625-091714-976198d497639c44613f1aa59a0fbdf3-45988325"
    
    func getCategory(search: String, completed: @escaping (Result<[CategoryModel], MLError>) -> Void) {
        
        let endpoint = URL(string: baseURl + "\(search)")
        
        guard let url = endpoint else {
            completed(.failure(.invalidCategory))
            return
        }
                      
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
}

