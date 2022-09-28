//
//  MultiGetManager.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 16/09/22.
//

import Foundation



class MultiGet2Manager{
    
    static let shared = MultiGet2Manager()
    private let baseURl = "https://api.mercadolibre.com/items?ids="
    let token = "APP_USR-7169050861406625-091714-976198d497639c44613f1aa59a0fbdf3-45988325"
    
    private init() { }
    
    func getDetailsProducts(params: String, completed: @escaping (Result<[ArrayMultiGet], MLError>) -> Void) {
        let endpoint = URL(string: baseURl + "\(params)")
        
        guard let url = endpoint else {
            completed(.failure((.invalidDetailProducts)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
                let categoryDecoded = try decoder.decode(ArrayMultiGet.self, from: data)
                completed(.success([categoryDecoded]))
            }
            catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
