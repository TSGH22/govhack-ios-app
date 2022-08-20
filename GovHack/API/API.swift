//
//  API.swift
//  GovHack
//
//  Created by Max Chuquimia on 20/8/2022.
//

import Foundation

final class API {

    static let shared = API()
    let domain = URL(string: "https://test.com")!
    let session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.timeoutIntervalForRequest = 20.0
        return URLSession(configuration: config)
    }()

    func request<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        print("[API]", request.url ?? "?")
        session.dataTask(with: request) { data, response, error in
            var rawDataString = String(data: data ?? Data(), encoding: .utf8) ?? ""

            DispatchQueue.main.async {
                if let error = error {
                    print("[API]", error)
                    return completion(.failure(error))
                }

                print("[API]", rawDataString)

                if let data = data {
                    do {
                        let r = try JSONDecoder().decode(T.self, from: data)
                        return completion(.success(r))
                    } catch {
                        print("[API]", error)
                        rawDataString = "\(error)"
                    }
                }

                // TODO: decode error response model?

                if rawDataString.isEmpty { rawDataString = "unknown error" }

                completion(.failure(NSError(domain: "com.chuquimianproductions.govhack", code: 1, userInfo: [NSLocalizedDescriptionKey: rawDataString])))
            }
        }
        .resume()
    }

}
