//
//  BreedCollectionCell.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import UIKit
import SnapKit
import SDWebImage

final class BreedCollectionCell: UICollectionViewCell {
    static let id = String(describing: BreedCollectionCell.self)
    let provider = NetworkManager()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marker Felt", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurate() {
        layoutElements()
        makeConstraints()
    }
    
    func setData(model: BreedModel, urlArray: [BreedImageModel]) {
        self.nameLabel.text = model.name
        guard let model = urlArray.first(where: { $0.id == model.id }) else { return }
        guard let url = model.url else { return }
        cellImage.sd_setImage(with: URL(string: url))
    }
    
    private func layoutElements() {
        contentView.addSubview(cellImage)
        contentView.addSubview(nameLabel)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true

        contentView.backgroundColor = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(white: 0.3, alpha: 1.0)
                default:
                    return UIColor(white: 0.7, alpha: 1.0)
            }
        }
        
        nameLabel.textColor = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .dark:
                    return .systemOrange
                default:
                    return .green
            }
        }
    }
    
    private func makeConstraints() {        
        cellImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
}
