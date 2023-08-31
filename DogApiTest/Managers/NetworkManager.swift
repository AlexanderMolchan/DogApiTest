//
//  NetworkManager.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import Foundation
import Moya

typealias ObjectBlock<T: Decodable> = ((T) -> Void)
typealias ArrayBlock<T: Decodable> = (([T]) -> Void)
typealias Failure = ((Error) -> Void)

final class NetworkManager {
    let provider = MoyaProvider<ApiManager>(plugins: [NetworkLoggerPlugin()])
    
    func getBreeds(page: Int = 0, success: ArrayBlock<BreedModel>?, failure: Failure?) {
        provider.request(.getBreedList(page: page)) { result in
            switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode([BreedModel].self, from: response.data)
                        success?(data)
                    } catch let error {
                        failure?(error)
                    }
                case .failure(let error):
                    failure?(error)
            }
        }
    }
    
    func getImage(id: String, success: ArrayBlock<BreedImageModel>?, failure: Failure?) {
        provider.request(.getImage(id: id)) { result in
            switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode([BreedImageModel].self, from: response.data)
                        success?(data)
                    } catch let error {
                        failure?(error)
                    }
                case .failure(let error):
                    failure?(error)
            }
        }
    }
}
    
    

