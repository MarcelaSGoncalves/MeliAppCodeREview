//
//  Error.swift
//  MeliApp
//
//  Created by Marcela De Souza Goncalves on 17/09/22.
//

import Foundation

enum MLError: String, Error {
    case invalidProducts   = "This products created an invalid request. Please try again."
    case invalidCategory   = "This category created an invalid request. Please try again."
    case invalidDetailProducts   = "This products Detail created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this product. Please try again."
    case alreadyInFavorites = "You've already favorited this product. You must REALLY like them!"
    case invalidToken =  "THis Token doesn't exist or has been expired. Please try again."
}

