//
//  UploadImageResponse.swift
//  A4
//
//  Created by Christopher Cheng on 12/6/24.
//

import Foundation

// Root response struct
struct UploadImageResponse: Decodable {
    let success: Bool
    let data: ImageData
}

// Data struct for the "data" field in the JSON
struct ImageData: Decodable {
    let id: Int
    let url: String
    let createdAt: String
}
