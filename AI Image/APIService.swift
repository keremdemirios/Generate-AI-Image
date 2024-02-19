//
//  APIService.swift
//  AI Image
//
//  Created by Kerem Demir on 19.02.2024.
//

import UIKit

class APIService {
    let apiKey = "API_KEY"
    
    func fetchImageForPrompt(_ prompt: String) async throws -> UIImage {
//        let fetchImageURL = "https://api.openai.com/v1/images/generations"
        let urlRequest = try createURLRequestFor(httpMethod: "POST", url: APIUrls.getImageUrl(), prompt: prompt)
//        let urlRequest = try createURLRequestFor(httpMethod: "POST", url: fetchImageURL, prompt: prompt)
        
        let (data, resposne) = try await URLSession.shared.data(for: urlRequest)
        let results = try JSONDecoder().decode(Response.self, from: data)
        
        let imageURL = results.data[0].url
        guard let imageUrl = URL(string: imageURL) else {
            throw APIError.unableToCreateImageURL
        }
        
        let (imageData, imageResponse) = try await URLSession.shared.data(from: imageUrl)
        
        guard let image = UIImage(data: imageData) else {
            throw APIError.unableToConvertDataIntoImage
        }
        
        return image
    }
    
    private func createURLRequestFor(httpMethod: String, url: String, prompt: String) throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw APIError.unableToCreateURLForURLRequest
        }
        
        var urlRequest = URLRequest(url: url)
        
        // Method
        urlRequest.httpMethod = httpMethod
        // Headers
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField:"Content-Type")
        // Body
        let jsonBody: [String: Any] = [
            "model":"dall-e-2",
            "prompt": "\(prompt)",
            "n":1,
            "size": "1024x1024"
        ]
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
        return urlRequest
    }
}
