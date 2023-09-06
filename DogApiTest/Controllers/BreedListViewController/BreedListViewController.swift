//
//  BreedListViewController.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import UIKit

final class BreedListViewController: BaseViewController<BreedListViewControllerView> {
    private let viewModel: BreedListViewModel
    
    init(viewModel: BreedListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerConfigurate()
    }
    
    private func controllerConfigurate() {
        collectionViewConfigurate()
        viewModel.getBreedData()
        bindElements()
    }
    
    private func collectionViewConfigurate() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.collectionView.register(BreedCollectionCell.self, forCellWithReuseIdentifier: BreedCollectionCell.id)
        contentView.collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
    private func bindElements() {
        viewModel.breedsArray.bind { [weak self] _ in
            self?.contentView.collectionView.reloadData()
        }
        
        viewModel.error.bind { [weak self] isError in
            if isError {
                self?.showAlert(title: "Network Error", message: "Try again later")
            }
        }
        
        viewModel.isActivity.bind { [weak self] isActive in
            if isActive {
                self?.contentView.spinner.startAnimating()
            } else {
                self?.contentView.spinner.stopAnimating()
            }
        }
    }
    
}

// MARK: -
// MARK: - CollectionView Extensions

extension BreedListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.breedsArray.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = contentView.collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionCell.id, for: indexPath)
        guard let breedCell = cell as? BreedCollectionCell,
              let model = viewModel.breedsArray.value?[indexPath.row]
        else { return cell }
        
        breedCell.setData(model: model, urlArray: viewModel.urlArray)
        return breedCell
    }
}

extension BreedListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let link = viewModel.breedsArray.value?[indexPath.row].wikiLink ?? ""
        let moreInfoViewModel = MoreInfoViewModel(provider: viewModel.provider, wikiLink: link)
        let moreInfoVc = MoreInfoViewController(viewModel: moreInfoViewModel)
        navigationController?.pushViewController(moreInfoVc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let arrayCount = viewModel.breedsArray.value?.count else { return }
        if indexPath.row == arrayCount - 1 {
            viewModel.getNextPageData()
        }
    }
    
}

extension BreedListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
            let width = ((screenWidth - 30) / 2)
            let height = width * 1.2
            return CGSize(width: width, height: height)
    }
}
