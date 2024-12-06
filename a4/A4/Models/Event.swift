//
//  SocialStruct.swift
//  A4
//
//  Created by Aidan Joseph on 11/27/24.
//

//
//  Recipes.swift
//  A4
//
//  Created by Aidan Joseph on 11/25/24.
//

import Foundation

struct Event: Codable {
    let id: Int
    let userId: String
    let title: String
    let imageUrl: String
    let description: String
    let location: String
    let capacity: String
    let date: Date
    let createdAt: Date
}
