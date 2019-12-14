//
//  ModelDefinition.swift
//  TinderApp
//
//  Created by 横野公至郎 on 2019/11/20.
//  Copyright © 2019 横野公至郎. All rights reserved.
//

import Foundation

typealias ModelHandler<T> = (_ result:ModelResult<T>) -> Void

enum ModelResult<T> {
    case success(T?)
    case failure(ModelError)
}

enum ModelError: Error {
    case api(ApiError)
    case logic(String)
    
    var message:String {
        switch self {
        case .api(let apierror):
            return apierror.message
        case .logic(let message):
            return message
        }
    }
}
