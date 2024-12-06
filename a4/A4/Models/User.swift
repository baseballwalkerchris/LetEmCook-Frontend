//
//  User.swift
//  A4
//
//  Created by Aidan Joseph on 12/5/24.
//

//MARK: conform with backend, temp data for now
import Foundation

struct User: Decodable {
    let id: Int
    let username: String
    let userImage: String
}
