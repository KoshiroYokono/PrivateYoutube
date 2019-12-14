//
//  ApiClient.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/16.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


struct ApiClient {
    static func request(_ api: Api,method: HTTPMethod = .get,parameters: String = "", headers: HTTPHeaders = [:], completion: @escaping ApiResultHandler) {
        let request = Alamofire.request(api.url + parameters, method: method, headers: headers)
        request.responseJSON { (response) in
            print("----------------------------")
            print(response)
            print("----------------------------")
            switch response.result {
            case .success(let data):
                completion(.success(JSON(data)))
            case .failure(_):
                print("失敗")
                completion(.failure(.http))
            }
        }
    }
}
