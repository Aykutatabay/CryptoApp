//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Aykut ATABAY on 30.11.2022.
//

import Foundation
import Combine

class NetworkingManager {
    
    // in order to access to functşons we dont need to initilize thşs class called type methods and we nedd to use static or class before methods or properties
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url) : return "Bad response from URL: \(url) "
            case .unknown: return "Unknown error occured"
                
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
             .tryMap({ try handleURLResponse(output: $0, url: url) })
             .retry(3) // its gonna know that dataTaskPublisher failed and restart
             .eraseToAnyPublisher()
        // Use eraseToAnyPublisher() to expose an instance of AnyPublisher to the downstream subscriber, rather than this publisher’s actual type.
        
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200, response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
             }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Publishers.Decode<AnyPublisher<Data, Error>, [CoinModel], JSONDecoder>.Failure>) {
        switch completion {
        case .finished:
            break
        case.failure(let error):
            print(error.localizedDescription)
        }
    }
}
