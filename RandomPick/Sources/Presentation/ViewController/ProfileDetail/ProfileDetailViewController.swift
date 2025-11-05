//
//  ProfileDetailViewController.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/5/25.
//

import UIKit
import Kingfisher
import FlexLayout
import PinLayout
import ReactorKit
import RxKingfisher
import RxCocoa


final class ProfileDetailViewController: BaseViewController {
    // MARK: - Constants
    typealias Reactor = ProfileDetailViewReactor
    
    // MARK: - UI
    private let rootContainer = UIView()
    private let closeButton = UIButton(type: .system)
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    // MARK: - Init
    init(profile: RandomUser) {
        defer { self.reactor = Reactor(profile: profile) }
        super.init()
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootContainer.pin.all()
        rootContainer.flex.layout(mode: .adjustHeight)
    }
}

private extension ProfileDetailViewController {
    // MARK: - setupUI
    func setupUI() {
        self.view.backgroundColor = .black
        self.view.addSubview(self.rootContainer)
        
        self.closeButton.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.closeButton.tintColor = .white
        
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        
        self.nameLabel.textColor = .white
        self.nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        self.nameLabel.textAlignment = .center
    }
    
    // MARK: - setupLayout
    func setupLayout() {
        self.rootContainer.flex
            .direction(.column)
            .alignItems(.center)
            .justifyContent(.start)
            .paddingHorizontal(20)
            .paddingTop(60)
            .define { flex in
                flex.addItem(self.closeButton)
                    .alignSelf(.end)
                    .width(40)
                    .height(40)
                    .marginBottom(40)
                
                flex.addItem(self.imageView)
                    .width(100%)
                    .aspectRatio(1)
                
                flex.addItem(self.nameLabel)
                    .marginTop(20)
            }
    }
}

extension ProfileDetailViewController: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        self.closeButton.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: { $0.0.dismiss(animated: true) })
            .disposed(by: self.disposeBag)
        
        // MARK: - State
        reactor.state.map { $0.profile.picture?.large }
            .distinctUntilChanged()
            .compactMap { URLHelper.createEncodedURL(url: $0) }
            .bind(to: self.imageView.kf.rx.image())
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.profile.createName() }
            .distinctUntilChanged()
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}
