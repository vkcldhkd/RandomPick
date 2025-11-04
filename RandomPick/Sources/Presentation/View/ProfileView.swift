//
//  ProfileView.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/3/25.
//

import UIKit

final class ProfileView: UIView {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    var image: UIImage? {
        didSet { imageView.image = image }
    }
    
    var name: String? {
        didSet { nameLabel.text = name }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(nameLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

