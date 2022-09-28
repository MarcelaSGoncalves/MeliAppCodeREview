//
//  ItensManager.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import Foundation

class Itens2Manager {
    
    
    static let shared = Itens2Manager()
    private let baseURl = "https://api.mercadolibre.com/highlights/MLB/category/"
    private let token = "APP_USR-7169050861406625-091714-976198d497639c44613f1aa59a0fbdf3-45988325"
    //let category = "MLB271578"
    
    func getMultiGet(products: String, completed: @escaping (Result<NewContent, MLError>) -> Void) {
        let endpoint = URL(string: baseURl + "\(products)")
        
        
        guard let url = endpoint else {
            completed(.failure(.invalidProducts))
            return
        }
        
        var request1 = URLRequest(url: url)
        request1.httpMethod = "GET"
        request1.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
                print(categoryDecoded)
                completed(.success(categoryDecoded))
            }
            catch{
                completed(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
}
