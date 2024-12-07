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

struct EventResponse: Codable {
    let success: Bool
    let data: Event
}

struct FetchEventResponse: Decodable {
    let success: Bool
    let data: EventData
}

struct EventData: Decodable {
    let events: [Event]
}

struct Event: Codable {
    let id: Int
    let userId: Int
    let title: String
    let imageUrl: String
    let caption: String
    let location: String
    let numberGoing: Int
//    let time: Date
    let createdAt: Date
}
