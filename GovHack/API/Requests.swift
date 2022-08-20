//
//  FeaturedRequest.swift
//  GovHack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import Foundation

extension API {

    func fetchFeaturedProperties(completion: @escaping (Result<[PropertyModel], Error>) -> Void) {
        let r = URLRequest(url: domain.appendingPathComponent("featured"))
        request(r, completion: completion)
    }

    func searchProperties(request body: SearchRequestModel, completion: @escaping (Result<[PropertyModel], Error>) -> Void) {
        var r = URLRequest(url: domain.appendingPathComponent("search"))
        r.httpBody = try! JSONEncoder().encode(body)
        r.httpMethod = "POST"
        request(r, completion: completion)
    }

    func bookProperty(request body: BookRequestModel, completion: @escaping (Result<EmptyResponse, Error>) -> Void) {
        var r = URLRequest(url: domain.appendingPathComponent("book"))
        r.httpBody = try! JSONEncoder().encode(body)
        r.httpMethod = "POST"
        request(r, completion: completion)
    }

}

extension API {

    struct EmptyResponse: Codable {

    }

}
