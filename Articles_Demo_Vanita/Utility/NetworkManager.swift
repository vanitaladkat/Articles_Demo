//
//  NetworkManager.swift
//  Articles_Demo_Vanita
//
//  Created by Vanita Ladkat on 02/07/20.
//  Copyright © 2020 Vanita Ladkat. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkCompletionHander = (_ success: Bool, _ response: Any?, _ error: Error?) -> Void
typealias DataParsedCompletion = (_ success: Bool, _ error: Error?) -> Void

enum NetworkError: Error {
    case paramMissing
    case invalidUrl
}

struct WebAPI {
    static let articles = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs" //?page= 1&limit=10
}


class NetworkManager {
    static let sharedInstance = NetworkManager()
    private init() {}

    func sendNetworkRequest(urlStr: String, httpMethod: HTTPMethod, parameters: [String: Any], completionHanlder: @escaping NetworkCompletionHander) {
        guard let url = URL(string: urlStr) else {
            completionHanlder(false, nil, NetworkError.invalidUrl)
            return
        }

        
        AF.request(url, method: httpMethod, parameters: parameters,  headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                completionHanlder(true, json, nil)
            case .failure(let error):
                completionHanlder(false, nil, error)
            }
        }
    }
}
