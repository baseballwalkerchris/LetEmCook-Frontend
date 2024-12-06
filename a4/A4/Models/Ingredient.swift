//
//  Ingredient.swift
//  A4
//
//  Created by Christopher Cheng on 12/5/24.
//

import Foundation

struct FetchIngredientResponse: Decodable {
    let success: Bool
    let data: IngredientData
}

struct IngredientData: Decodable {
    let ingredients: [Ingredient]
}

public struct Ingredient: Codable {
    let id: Int
    let name: String
    let imageUrl: String
}
