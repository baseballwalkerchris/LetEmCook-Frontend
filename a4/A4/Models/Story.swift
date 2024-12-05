//
//  Post.swift
//  A4
//
//  Created by Christopher Cheng on 12/4/24.
//

import Foundation

struct StoryResponse: Decodable {
    let success: Bool
    let data: Story
}

struct Story: Decodable {
    let id: Int
    let imageUrl: String
    let title: String
    let caption: String
    let createdAt: String // Use `Date` if preferred with ISO 8601 decoding
}
