//
//  TokenResponse.swift
//  OauthConnect
//
//  Created by Trung on 09/10/2021.
//

import Foundation

struct TokenEntity: Codable {
    let accessToken, tokenType, refreshToken: String
    let expiresIn: Int
    let idToken: String
    
    init?(data: Data) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            self = try decoder.decode(TokenEntity.self, from: data)
        } catch {
            return nil
        }
    }
}
