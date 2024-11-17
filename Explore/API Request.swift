//
//  API Request.swift
//  Explore
//  Created by Developer on 6/18/24.
//

import Foundation
import UIKit
import MapKit
import WeatherKit

class APIService {
    static let shared = APIService()
    private let apiKey = "retool_wk_982d531143404832a333ea9010e5492b"
    private let baseUrl = "https://api.retool.com/v1/workflows/1448a229-db0f-480f-9a7d-9a16b1a0fb64/startTrigger"
    
    private init() {}
    
    func loadData(for location: Location) async throws -> (description: String, imageUrls: [String]) {
        let url = URL(string: baseUrl)!
        
        let parameters: [String: Any] = [
            "name": location.name,
            "location": location.location
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "X-Workflow-Api-Key")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let jsonResult = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let description = jsonResult["description"] as? String,
              let imageUrls = jsonResult["images"] as? [String] else {
            throw APIError.invalidResponse
        }
        
        return (description, imageUrls)
    }
    
//    func loadImage(from urlString: String) async throws -> UIImage {
//        guard let url = URL(string: urlString) else {
//            throw APIError.invalidURL
//        }
//        
//        let (data, _) = try await URLSession.shared.data(from: url)
//        
//        guard let image = UIImage(data: data) else {
//            throw APIError.invalidImageData
//        }
//        
//        return image
//    }
    
    enum APIError: Error {
        case invalidResponse
        case invalidURL
        case invalidImageData
    }
}

