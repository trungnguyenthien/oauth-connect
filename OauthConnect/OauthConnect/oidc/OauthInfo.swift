//
//  OauthInfo.swift
//  OauthConnect
//
//  Created by Trung on 09/10/2021.
//

import Foundation

struct OauthInfo {
    let clientID: String
    let clientSecret: String
    let redirectUri: String
    let scopes: [String]
    
    let authEndpoint: String
    let tokenEndpoint: String
    
    var loginRequest: URLRequest {
        let params = [
            "client_id": clientID,
//            "client_secret": clientSecret,
            "redirect_uri": redirectUri,
            "scope": scopes.joined(separator: ","),
//            "grant_type": "authorization_code",
            "response_type": "code"
        ].queryString
        
        let url = URL(string: authEndpoint + "?\(params)")!
        print(url.absoluteString)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func tokenRequest(code: String) -> URLRequest {
        let tokenParams = [
            "code": code,
            "client_id": clientID,
            "client_secret": clientSecret,
            "redirect_uri": redirectUri,
            "scope": scopes.joined(separator: ","),
            "grant_type": "authorization_code"
        ]
        
        let bodyData = try? JSONSerialization.data(
            withJSONObject: tokenParams,
            options: []
        )
        let url = URL(string: tokenEndpoint)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = bodyData
        return request
    }
}

private extension Dictionary {
    var queryString: String {
        let keyValues = reduce("") { "\($0)\($1.0)=\($1.1)&" }
        return keyValues.trimmingCharacters(in: CharacterSet(charactersIn: "&"))
    }
}
