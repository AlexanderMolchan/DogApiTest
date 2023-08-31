//
//  MoreInfoViewModel.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import Foundation

final class MoreInfoViewModel {
    let provider: NetworkManager
    let wikiLink: String
    
    init(provider: NetworkManager, wikiLink: String) {
        self.provider = provider
        self.wikiLink = wikiLink
    }
    
}
