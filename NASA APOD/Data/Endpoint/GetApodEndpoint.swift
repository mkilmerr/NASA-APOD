//
//  GetApodEndpoint.swift
//  NASA APOD
//
//  Created by longarinas on 31/01/25.
//

import Foundation

struct GetApodEndpoint: Endpoint {
    let query: GetApodEndpoint.Query

    init(query: GetApodEndpoint.Query) {
        self.query = query
    }

    var path: String {
        return "/apod"
    }
    
    var method: HTTPMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: query.apiKey)
        ]
        
        if let date = query.date {
            queryItems.append(
                URLQueryItem(name: "date", value: date)
            )
        }
        
        return queryItems
    }
}

// MARK: - Query
extension GetApodEndpoint {
    struct Query {
        let apiKey: String = "<YOUR API KEY>"
        let date: String?
    }
}
