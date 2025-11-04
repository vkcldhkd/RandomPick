//
//  ProfileView.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/3/25.
//

import UIKit
import ReactorKit
import RxCocoa
import Kingfisher
import RxKingfisher
import FlexLayout
import PinLayout

final class ProfileView: BaseView {
    // MARK: - Constants
    typealias Reactor = ProfileViewReactor
    
    // MARK: - UI
    private let rootFlexContainer = UIView()
    private let userImageView = UIImageView()
    private let userNameLabel = UILabel()
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all()
        rootFlexContainer.flex.layout()
    }
}

private extension ProfileView {
    // MARK: - setupUI
    func setupUI() {
        self.addSubview(self.rootFlexContainer)
        
        self.userImageView.layer.cornerRadius = 35
        self.userImageView.clipsToBounds = true
        self.userImageView.contentMode = .scaleAspectFill
        
        self.userNameLabel.font = .systemFont(ofSize: 13, weight: .medium)
        self.userNameLabel.textColor = .white
        self.userNameLabel.textAlignment = .center
    }

    // MARK: - setupConstraints
    func setupConstraints() {
        self.rootFlexContainer.flex
            .direction(.column)
            .alignItems(.center)
            .define { flex in
                flex.addItem(self.userImageView)
                    .width(70)
                    .height(70)
                flex.addItem(self.userNameLabel)
                    .marginTop(6)
            }
    }
}


extension ProfileView: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
        reactor.state.map { $0.user.picture?.medium }
            .distinctUntilChanged()
            .compactMap { URLHelper.createEncodedURL(url: $0) }
            .bind(to: self.userImageView.kf.rx.image())
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.user.createName() }
            .distinctUntilChanged()
            .debug()
            .bind(to: self.userNameLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}
