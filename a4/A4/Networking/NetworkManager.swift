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
    
    let dateFormatter = DateFormatter()

    
    func createStory(userId: String, caption: String, imageUrl: String, completion: @escaping (Story) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let endpoint: String = "\(devEndpoint)/users/1/stories/"
        
        let parameters: Parameters = [
            "user_id": "test",
            "caption": "test",
            "title": "testTitle",
            "image_url": "test"
/*            "created_at": "test",  */      ]
        
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: StoryResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let storyResponse):
                    print("Successfully added story with ID: \(storyResponse.data.id)")
                    print(storyResponse.data)
                    completion(storyResponse.data)
                case .failure(let error):
                    if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response: \(rawResponse)") // Log the raw JSON response
                    }
                    print("Error in NetworkManager.createStory: \(error.localizedDescription)")
                }
            }
    }
    
    /**
     Fetch posts from backend
     */
    func fetchStories(completion: @escaping ([Story]) -> Void) {
        // Specify the endpoint
        let endpoint = "\(devEndpoint)/stories/"
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: FetchStoryResponse.self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let storyResponse):
                    print("Successfully fetched \(storyResponse.data.stories.count) posts")
                    completion(storyResponse.data.stories)
                case .failure(let error):
                    if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response: \(rawResponse)") // Log the raw JSON response
                    }
                    print("Error in NetworkManager.fetchPosts: \(error.localizedDescription)")
                }
            }
    }
        
    func createRecipe(
        userId: String, title: String, imageUrl: String, time: String, servings: String, ratings: String, description: String,
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
            .responseDecodable(of: Recipe.self, decoder: decoder) { response in
                switch response.result {
                case .success(let recipe):
                    print("Successfully added recipe with ID: \(recipe.id)")
                    completion(recipe)
                case .failure(let error):
                    print("Error in NetworkManager.createRecipe: \(error.localizedDescription)")
                    print("No response data")
                }
            }
    }
    
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        // Specify the endpoint
        let endpoint = ""
        
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Recipe].self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let recipes):
                    print("Successfully fetched \(recipes.count) posts")
                    completion(recipes)
                case .failure(let error):
                    print("Error in NetworkManager.fetchRecipes: \(error.localizedDescription)")
                }
            }
    }
    
    
    func createEvent(
        userId: String, title: String, imageUrl: String, description: String,
        location: String, capacity: String, date: Date, completion: @escaping (Event) -> Void) {
            
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let endpoint: String = "\(devEndpoint)/users/1/stories/"
        
            
        
        let parameters: Parameters = [
            "user_id": userId,
            "title": title,
            "image_url": imageUrl,
            "description": description,
            "location": location,
            "capacity": capacity,
            "date": date
        ]
                    

        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Event.self, decoder: decoder) { response in
                switch response.result {
                case .success(let event):
                    print("Successfully added recipe with ID: \(event.id)")
                    completion(event)
                case .failure(let error):
                    print("Error in NetworkManager.createEvent: \(error.localizedDescription)")
                    print("No response data")
                }
            }
    }
}
