//
//  API Request.swift
//  Explore
//  Created by Developer on 6/18/24.
//

import Foundation
import UIKit
import MapKit
import WeatherKit

extension Model {
    func loadDescription(location: Location) {
        let url = URL(string: "https://api.retool.com/v1/workflows/1448a229-db0f-480f-9a7d-9a16b1a0fb64/startTrigger")!
        
        let parameters: [String: Any] = [
            "name": location.name,
            "location": location.location
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("retool_wk_982d531143404832a333ea9010e5492b", forHTTPHeaderField: "X-Workflow-Api-Key")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data else { print("No data received") ; return }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let description = jsonResult["description"] as? String,
                   let imagesResults = jsonResult["images"] as? [String] {
                    
                    self.description = description
                    self.images = []
                    
                    for imageUrlString in imagesResults {
                        if let imageUrl = URL(string: imageUrlString) {
                            URLSession.shared.dataTask(with: imageUrl) { imageData, _, error in
                                if let imageData = imageData {
                                    if let image = UIImage(data: imageData) {
                                        self.images?.append(image) // crash
                                    }
                                } else {
                                    print("Failed to load image data")
                                }
                            }.resume()
                        }
                    }
                }
                
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
