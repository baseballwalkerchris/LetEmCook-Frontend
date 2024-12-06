//
//  Recipes.swift
//  A4
//
//  Created by Aidan Joseph on 11/25/24.
//

//MARK: conform with backend, temp data for now
import Foundation

struct Recipe: Codable {
    let id: Int
    let userId: String
    let title: String
    let imageUrl: String
    let time: String
    let servings: String
    let ratings: String
    let description: String
    let ingredients: [Ingredient]
    let directions: [Direction]
    let createdAt: Date
}
