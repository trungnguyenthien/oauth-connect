//
//  LoginForm.swift
//  OauthConnect
//
//  Created by Trung on 07/10/2021.
//

import Foundation
import WebKit
import SafariServices

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

func loginViewController(info: OauthInfo) -> SFSafariViewController? {
    guard let url = info.loginRequest.url else { return nil }
    return SFSafariViewController(url: url)
}

class SafariLoginWebController: SFSafariViewController {
    private let info: OauthInfo
    init(info: OauthInfo) {
        self.info = info
        super.init(url: info.loginRequest.url!)
    }
}

/**
 curl --location --request POST 'https://www.googleapis.com/oauth2/v4/token' \
 --header 'Content-Type: application/json' \
 --form 'code="4/0AX4XfWifsAOrJGY5c9pMqgUQo7p55b5t2GTvEUY2n8JTpBPKm-5EKo-sLE3fE_1EH5YAYg"' \
 --form 'grant_type="authorization_code"' \
 --form 'client_id="263198911943-l8evgg6iu077ne4kbvj8up1cvtnp8o0h.apps.googleusercontent.com"' \
 --form 'redirect_uri="https://localhost"' \
 --form 'client_secret="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"'
 */

/**
 https://accounts.google.com/o/oauth2/v2/auth?response_type=code&client_id=263198911943-l8evgg6iu077ne4kbvj8up1cvtnp8o0h.apps.googleusercontent.com&scope=openid&redirect_uri=https%3A//localhost
 */

/**
 {
     "access_token": "ya29.a0ARrdaM_cHngaayLbd94soLXvUjfo4XgsLGpDfsLEeuw8lCHC7M0wJAv6YtJJiLXoK7ImEe3OAOH5YUGm7B3M_8G1X7b9UAf7LqPWgxgIVT6xX68iXdDmWFhF3II6Be64Yb1TEgxyaq72oGLpg-l-TmOWC6Ss",
     "expires_in": 3599,
     "refresh_token": "1//0eG4DtEIppfB6CgYIARAAGA4SNwF-L9IrPUj0erSoHKhc82KvFOr57o9TWT_Xlc_7_X5PN6LEa05XlyavpxhIPOe4e6M1Kl20v8Q",
     "scope": "openid",
     "token_type": "Bearer",
     "id_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFkZDhjMGVlNjIzOTU0NGFmNTNmOTM3MTJhNTdiMmUyNmY5NDMzNTIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIyNjMxOTg5MTE5NDMtbDhldmdnNml1MDc3bmU0a2J2ajh1cDFjdnRucDhvMGguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIyNjMxOTg5MTE5NDMtbDhldmdnNml1MDc3bmU0a2J2ajh1cDFjdnRucDhvMGguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDQxMDc2MDg5Mjk2Njg4ODQzMTMiLCJhdF9oYXNoIjoiTE9CQXp0TEdzM1VPZGt2UUpuSUtKQSIsImlhdCI6MTYzNDU2OTI1MywiZXhwIjoxNjM0NTcyODUzfQ.h58DLOykvcTL-vv5BlVXmr1HT1iObUSGD-RZV0bAaIrOe_Ikcnw96ORKAUa-D3epls6lmoVYvk82R1nx4lRP4vSrs-z4jwRWT-3SfEWzIa0mUbH1UrQpDE9ChNCfd4ModQ4eFSGVsxdRzegF_AMDA0t4IhiOEvifG56aWmaF_l915_k8a1aD7X6pEMcE1X4F4wZXKWTbV9ZE3n_oZbtQEsKS6wyGJ7cXuu1mR9OynXj2VY0VMDm8MqDe_8aRXLEVgYoA3QAuwljKAlkkUJ0VxqujwV86_xbiJWO31rdbppBFnW3VBUhs2KD2-BjimHVIUJosG8nc_idFFwuY6p8cag"
 }*/
