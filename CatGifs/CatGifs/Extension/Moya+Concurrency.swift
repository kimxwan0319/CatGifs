//
//  Moya+Concurrency.swift
//  CatGifs
//
//  Created by 김수완 on 2023/07/20.
//

import Foundation

import Moya

extension MoyaProvider {
    
    class MoyaConcurrency {
        
        private let provider: MoyaProvider
        private let jsonDecoder = JSONDecoder()
        
        init(provider: MoyaProvider) {
            self.provider = provider
        }
        
        func request<T: Decodable>(_ target: Target) async throws -> T {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        guard let res = try? self.jsonDecoder.decode(T.self, from: response.data) else {
                            continuation.resume(throwing: MoyaError.jsonMapping(response))
                            return
                        }
                        continuation.resume(returning: res)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    var async: MoyaConcurrency {
        MoyaConcurrency(provider: self)
    }
    
}
