//
//  MoreInfoViewController.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import UIKit

final class MoreInfoViewController: BaseViewController<MoreInfoViewControllerView> {
    private let viewModel: MoreInfoViewModel
    
    init(viewModel: MoreInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
    }
    
    private func request() {
        guard let url = URL(string: viewModel.wikiLink) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        contentView.webView.load(urlRequest)
    }
}
