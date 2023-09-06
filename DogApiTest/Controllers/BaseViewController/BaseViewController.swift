//
//  BaseViewController.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {
    var contentView: T {
        self.view as? T ?? T()
    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
}
