//
//  ApiManager.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import Foundation
import Moya

enum ApiManager {
    case getBreedList(page: Int)
    case getImage(id: String)
}

extension ApiManager: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.thecatapi.com/v1")!
    }
    
    var path: String {
        switch self {
            case .getBreedList:
                return "breeds"
            case .getImage:
                return "images/search"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var parameters: [String : Any]? {
        var parameters = [String : Any]()
        switch self {
            case .getBreedList(let page):
                parameters["limit"] = "10"
                parameters["page"] = page
            case .getImage(let id):
                parameters["breed_ids"] = id
        }
        return parameters
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
}
