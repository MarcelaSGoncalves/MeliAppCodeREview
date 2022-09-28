//
//  MultiGetModel.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 17/09/22.
//

import Foundation

typealias ArrayMultiGet = [MultiGet]

struct Body: Codable{
    var id: String
    var title: String
    var subtitle : String?
    var base_price: Double
    var price: Double
    var category_id: String
    var descriptions: [String]
    var thumbnail: String
    var secure_thumbnail: String
    var pictures : [Pictures]
}

struct MultiGet: Codable {
    var code : Int
    var body : Body
}

struct Pictures: Codable {
    var id: String
    var url: String
    var secure_url: String
}


