//
//  ApiController.swift
//  API-Project
//
//  Created by Lars Dansie on 12/15/23.
//

import Foundation
import UIKit

class ApiController {
    enum ApiControllerError: Error, LocalizedError {
        case repNotFound
    }
    
    
    func fetchReps(matching items: [URLQueryItem]) async throws -> [Rep] {
        var components = URLComponents(string: "http://whoismyrepresentative.com/getall_mems.php")!
        components.queryItems = items
        
        let (data, response) = try await URLSession.shared.data(from: components.url!)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw ApiControllerError.repNotFound
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(RepResult.self, from: data)
        print("\(result.results.count)")
        return result.results
    }
}
