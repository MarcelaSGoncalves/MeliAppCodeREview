//
//  TokenManager.swift
//  appMercadoLivre
//
//  Created by Marcela De Souza Goncalves on 13/09/22.
//

import Foundation



class Token2Manager {

    static var shared = Token2Manager()
    let url = "https://api.mercadolibre.com/oauth/token"
    var teste = ""
    var token = ""
    
    func getToken() {
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        let body: [String: AnyHashable] = [
            "grant_type": "authorization_code",
            "client_id": 7169050861406625,
            "client_secret": "YXlwLGmzU2OSzSTI3zr2LutZ1XxU3clx",
            "code" : "TG-63232df884f8f000016ef513-45988325",
            "redirect_uri" : "https://www.alkemy.org/"]
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        //Make request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error as Any)
                return
            }
            do {
                let response = try JSONDecoder().decode(TokenModel.self, from: data)
                self.token = response.access_token
                print(self.token)
            }
            catch{
                print(error)
            }
        }
        task.resume()
}
}
