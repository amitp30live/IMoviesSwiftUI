//
//  APIManager.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 10/08/24.
//

import Foundation
import SwiftUI

class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func request<T: Codable>(
        endpoint: Endpoint?,
        method: HTTPMethod = .GET,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url =  endpoint?.url else {
            completion(.failure(.requestFailed))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = parameters, method == .POST {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.invalidResponse))
            }
        }.resume()
    }
}
