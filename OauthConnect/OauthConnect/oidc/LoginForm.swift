//
//  LoginForm.swift
//  OauthConnect
//
//  Created by Trung on 07/10/2021.
//

import Foundation
import WebKit

private typealias AccessTokenHandler = (_ result: Result<TokenEntity, Error>) -> Void

private func requestToken(
    code: String,
    info: OauthInfo,
    completion: @escaping AccessTokenHandler
) {
    // Create the HTTP request
    let request = info.tokenRequest(code: code)
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data, let entity = TokenEntity.init(data: data) {
            completion(.success(entity))
        } else {
            completion(.failure(error ?? NSError()))
        }
    }.resume()
}

class OauthLoginWebview: WKWebView {

}
