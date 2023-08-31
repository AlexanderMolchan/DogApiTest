//
//  MoreInfoViewControllerView.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import UIKit
import WebKit

final class MoreInfoViewControllerView: UIView {
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateUI() {
        layoutElements()
        makeConstraints()
    }
    
    private func layoutElements() {
        addSubview(webView)
    }
    
    private func makeConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()

        }
    }
}


