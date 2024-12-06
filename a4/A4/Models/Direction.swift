//
//  Direction.swift
//  A4
//
//  Created by Christopher Cheng on 12/3/24.
//

// MARK: Conform with backend
import Foundation

public struct Direction: Codable {
    let stepNumber: Int
    let description: String
    var isCompleted: Bool
}

