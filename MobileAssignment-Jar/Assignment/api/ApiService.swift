//
//  ApiService.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation

class ApiService {
    private let baseUrl = "https://api.restful-api.dev/objects"
    
    func fetchDeviceDetails(completion: @escaping (Result<[DeviceData], Error>) -> ()) {
        guard let url = URL(string: baseUrl) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.cannotParseResponse)))
                return
            }
            
            do {
                let deviceData = try JSONDecoder().decode([DeviceData].self, from: data)
                completion(.success(deviceData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
