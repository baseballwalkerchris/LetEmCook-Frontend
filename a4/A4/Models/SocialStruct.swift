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

//MARK: conform with backend, temp data for now
import Foundation

struct SocialEventPost: Codable {
    // TODO: Create a Post Struct here
    let eventName: String
    let author: String
    let maxCount: Int
    let date: String
    let location: String
    let descriptionOfEvent: String
    let currentAttendees: Int
    let imageURL: String
}
