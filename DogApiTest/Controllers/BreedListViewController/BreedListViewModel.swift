//
//  BreedListViewModel.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import Foundation

final class BreedListViewModel {
    let provider: NetworkManager
    
    var currentPage = 0
    var urlArray = [BreedImageModel]()
    
    var breedsArray: Dynamic<[BreedModel]?> = Dynamic(nil)
    var error: Dynamic<Bool> = Dynamic(false)
    var isActivity: Dynamic<Bool> = Dynamic(false)

    init(provider: NetworkManager) {
        self.provider = provider
    }
    
    // MARK: -
    // MARK: - Functions
    
    func getBreedData() {
        isActivity.value = true
        provider.getBreeds { [weak self] result in
            self?.getImageUrls(array: result, isPaging: false)
            self?.isActivity.value = false
        } failure: { [weak self] _ in
            self?.error.value = true
            self?.isActivity.value = false
        }
    }
    
    func getImageUrls(array: [BreedModel], isPaging: Bool) {
        array.forEach({ model in
            self.provider.getImage(id: model.id) { [weak self] result in
                guard let imageModel = result.first else { return }
                let updatedModel = BreedImageModel(id: model.id, url: imageModel.url)
                self?.urlArray.append(updatedModel)
                if !isPaging {
                    self?.breedsArray.value = array
                }
            } failure: { error in
                print(error)
            }
        })
    }
    
    func getNextPageData() {
        isActivity.value = true
        let nextPage = currentPage + 1
        
        provider.getBreeds(page: nextPage) { [weak self] result in
            self?.isActivity.value = false
            guard let self, !result.isEmpty else { return }
            self.currentPage = nextPage
            self.breedsArray.value?.append(contentsOf: result)
            self.getImageUrls(array: result, isPaging: true)
        } failure: { _ in
            self.isActivity.value = false
        }
    }
    
}
