//
//  NetworkManager.swift
//  A4
//
//  Created by Christopher Cheng on 12/4/24.
//

import Alamofire
import Foundation

class NetworkManager {
    
    /// Shared singleton instance
    static let shared = NetworkManager()
    
    private init() { }
    
    private let devEndpoint: String = "http://35.199.37.180"
    
    let decoder: JSONDecoder = JSONDecoder()
    
    func createStory(userId: String, caption: String, imageUrl: String, completion: @escaping (Story) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let endpoint: String = "\(devEndpoint)/users/1/stories/"
        
        let parameters: Parameters = [
            "user_id": userId,
            "caption": caption,
            "title": "testTitle",
            "image_url": imageUrl,
        ]
        
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: StoryResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let storyResponse):
                    print("Successfully added story with ID: \(storyResponse.data.id)")
                    print(storyResponse.data)
                    completion(storyResponse.data)
                case .failure(let error):
                    print("Error in NetworkManager.createStory: \(error.localizedDescription)")
                    print("No response data")
                }
            }
    }
    
    /**
     Fetch posts from backend
     */
    func fetchStories(completion: @escaping ([Story]) -> Void) {
        // Specify the endpoint
        let endpoint = ""
        
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Story].self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let posts):
                    print("Successfully fetched \(posts.count) posts")
                    completion(posts)
                case .failure(let error):
                    print("Error in NetworkManager.fetchRoster: \(error.localizedDescription)")
                }
            }
    }
        
    func createRecipe(
        userId: String, title: String, imageUrl: String, time: Int, servings: Int, ratings: Int, description: String,
        ingredients: [Ingredient], directions: [Direction], completion: @escaping (Recipe) -> Void) {
            
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let endpoint: String = "\(devEndpoint)/users/1/stories/"
        
        let parameters: Parameters = [
            "user_id": userId,
            "title": title,
            "image_url": imageUrl,
            "time": time,
            "servings": servings,
            "ratings": ratings,
            "description": description,
            "ingredients": ingredients,
            "directions": directions
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: StoryResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let storyResponse):
                    print("Successfully added recipe with ID: \(storyResponse.data.id)")
                    print(storyResponse.data)
                    completion(storyResponse.data)
                case .failure(let error):
                    print("Error in NetworkManager.createRecipe: \(error.localizedDescription)")
                    print("No response data")
                }
            }
    }
}
