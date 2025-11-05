//
//  ProfileDetailViewController.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/5/25.
//

import UIKit
import Kingfisher

final class ProfileDetailViewController: BaseViewController {
    private let profile: RandomUser
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    init(profile: RandomUser) {
        self.profile = profile
        super.init()
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        imageView.contentMode = .scaleAspectFill
        imageView.kf.setImage(with: URLHelper.createEncodedURL(url: profile.picture?.large))
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        
        nameLabel.text = profile.createName()
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textAlignment = .center
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
