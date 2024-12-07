//
//  NetworkManager.swift
//  A4
//
//  Created by Christopher Cheng on 12/4/24.
//

import Alamofire
import Foundation
import UIKit

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
            "user_id": userId,
            "caption": caption,
            "title": userId,
            "image_url": imageUrl
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
        ingredients: [Ingredient], directions: [String], completion: @escaping (Recipe) -> Void) {
            
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let endpoint: String = "\(devEndpoint)/users/1/recipes/"
        
         
                    

        
        let parameters: Parameters = [
            "user_id": userId,
            "title": title,
            "image_url": imageUrl,
            "time": time,
            "servings": servings,
            "ratings": ratings,
            "description": description,
            "ingredients": ingredients,
            "instructions": directions
        ]

        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: RecipeResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let recipe):
                    print("Successfully added recipe with ID: \(recipe.data.id)")
                    completion(recipe.data)
                case .failure(let error):
                    if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response: \(rawResponse)") // Log the raw JSON response
                    }
                    print("Error in NetworkManager.createRecipe: \(error.localizedDescription)")
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
        userId: Int, title: String, imageUrl: String, description: String,
        location: String, capacity: Int, date: Date, completion: @escaping (Event) -> Void) {
            
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
            
        let endpoint: String = "\(devEndpoint)/users/1/events/"
        
        let parameters: Parameters = [
            "user_id": userId,
            "title": title,
            "image_url": imageUrl,
            "caption": description,
            "location": location,
            "number_going": capacity
        ]
                    

        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: EventResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let eventResponse):
                    print("Successfully added event with ID: \(eventResponse.data.id)")
                    completion(eventResponse.data)
                case .failure(let error):
                    if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response: \(rawResponse)") // Log the raw JSON response
                    }
                    print("Error in NetworkManager.createEvent: \(error.localizedDescription)")
                }
            }
    }
    
    func fetchEvents(completion: @escaping ([Event]) -> Void) {
        // Specify the endpoint
        let endpoint = "\(devEndpoint)/events/"
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: FetchEventResponse.self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let eventResponse):
                    print("Successfully fetched \(eventResponse.data.events.count) events")
                    completion(eventResponse.data.events)
                case .failure(let error):
                    if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response: \(rawResponse)") // Log the raw JSON response
                    }
                    print("Error in NetworkManager.fetchEvents: \(error.localizedDescription)")
                }
            }
    }

    func fetchIngredients(completion: @escaping ([Ingredient]) -> Void ) {
        let endpoint = "\(devEndpoint)/users/1/ingredients/"
        
        // Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: FetchIngredientResponse.self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let ingredientResponse):
                    print("Successfully fetched \(ingredientResponse.data.ingredients.count) events")
                    completion(ingredientResponse.data.ingredients)
                case .failure(let error):
                    if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response: \(rawResponse)") // Log the raw JSON response
                    }
                    print("Error in NetworkManager.fetchEvents: \(error.localizedDescription)")
                }
            }
    }

    
    func postImage(image: UIImage, completion: @escaping (String?) -> Void) {
        // Convert the UIImage to Base64
        print("hi")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert UIImage to Data")
            completion(nil)
            return
        }

        let base64ImageString = "data:image/jpeg;base64,\(imageData.base64EncodedString())"
        
        print("Base64 Encoded String (First 100 Characters): \(base64ImageString.prefix(100))")
        // Prepare the request
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        let endpoint: String = "\(devEndpoint)/upload/"
        
        let parameters: Parameters = [
            "image_data": base64ImageString
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: UploadImageResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let uploadResponse):
                    if uploadResponse.success {
                        print("Image uploaded successfully. URL: \(uploadResponse.data.url)")
                        completion(uploadResponse.data.url)
                    } else {
                        print("Failed to upload image: Success flag is false")
                        completion(nil)
                    }
                case .failure(let error):
                    if let data = response.data, let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Response: \(rawResponse)") // Log the raw JSON response
                    }
                    print("Error in postImage: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
}
