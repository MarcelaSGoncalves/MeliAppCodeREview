//
//  ItensModel.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 17/09/22.
//

import Foundation

struct NewContent: Codable {
    var content: [ItensModel]
}

struct ItensModel: Codable{
    var id: String
    var position : Int
}


