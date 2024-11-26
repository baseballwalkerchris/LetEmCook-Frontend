//
//  Recipes.swift
//  A4
//
//  Created by Aidan Joseph on 11/25/24.
//

//MARK: conform with backend, temp data for now
import Foundation

struct RecipePost: Codable {
    // TODO: Create a Post Struct here
    let username: String
    let caption: String
    let message: String
    let imageURL: String
    let time: Date
}
