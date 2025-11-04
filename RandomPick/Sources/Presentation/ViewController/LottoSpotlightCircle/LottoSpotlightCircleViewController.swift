//
//  LottoSpotlightViewController.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/3/25.
//
import ReactorKit
import RxSwift

import UIKit

import RxCocoa


final class LottoSpotlightCircleViewController: BaseViewController {
    // MARK: - Constants
    typealias Reactor = LottoSpotlightCircleViewReactor
    private let radius: CGFloat = 120
    
    // MARK: - Properties (Private)
    
    private let spotlightLayer = CALayer()
    
    // MARK: - Properties (Public)
    var currentIndex = 0
    var profileViews: [ProfileView] = []
    
    // MARK: - UI
    private var expandedSnapshot: UIView?
    private var activeSmokeEmitters: [CAEmitterLayer] = []
    
    init(fetchProfilesUseCase: FetchProfilesUseCase) {
        defer { self.reactor = Reactor(fetchProfilesUseCase: fetchProfilesUseCase) }
        super.init()
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
//
//    // MARK: - Smoke
//    private func createSmokeEmitter(at position: CGPoint) {
//        let smoke = CAEmitterLayer()
//        smoke.emitterPosition = position
//        smoke.emitterShape = .line
//        smoke.emitterSize = CGSize(width: 40, height: 2)
//        
//        let cell = CAEmitterCell()
//        cell.birthRate = 60
//        cell.lifetime = 2.5
//        cell.velocity = 40
//        cell.velocityRange = 20
//        cell.yAcceleration = -20
//        cell.scale = 0.06
//        cell.scaleRange = 0.1
//        cell.alphaSpeed = -0.5
//        cell.emissionLongitude = -.pi / 2
//        cell.contents = UIImage(systemName: "circle.fill")?.withTintColor(.yellow).cgImage
//        
//        smoke.emitterCells = [cell]
//        view.layer.addSublayer(smoke)
//        activeSmokeEmitters.append(smoke)
//    }
//    
//    private func removeSmokeEmitters() {
//        for smoke in activeSmokeEmitters {
//            smoke.birthRate = 0
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                smoke.removeFromSuperlayer()
//            }
//        }
//        activeSmokeEmitters.removeAll()
//    }

//    
//    @objc private func shrinkBackToCircle() {
//        guard let snapshot = expandedSnapshot else { return }
//        let lampCenter = CGPoint(x: view.center.x, y: view.center.y + 200)
//        createSmokeEmitter(at: lampCenter)
//        
//        let path = UIBezierPath()
//        path.move(to: snapshot.center)
//        path.addQuadCurve(to: lampCenter, controlPoint: CGPoint(x: view.center.x, y: snapshot.center.y + 300))
//        
//        let move = CAKeyframeAnimation(keyPath: "position")
//        move.path = path.cgPath
//        move.duration = 1.2
//        
//        let scale = CABasicAnimation(keyPath: "transform.scale")
//        scale.fromValue = 1.0
//        scale.toValue = 0.1
//        scale.duration = 1.2
//        
//        let fade = CABasicAnimation(keyPath: "opacity")
//        fade.fromValue = 1.0
//        fade.toValue = 0.0
//        fade.duration = 1.2
//        
//        let group = CAAnimationGroup()
//        group.animations = [move, scale, fade]
//        group.duration = 1.2
//        group.fillMode = .forwards
//        group.isRemovedOnCompletion = false
//        snapshot.layer.add(group, forKey: "lampDisappear")
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//            snapshot.removeFromSuperview()
//            self.expandedSnapshot = nil
//            self.reloadProfiles()
//        }
//    }
//    
//    private func reloadProfiles() {
//        profileViews.forEach { $0.removeFromSuperview() }
//        profileViews.removeAll()
//        setupProfiles()
//        // startSpinning()은 setupProfiles 내부에서 호출됨
//    }
}

private extension LottoSpotlightCircleViewController {
    // MARK: - setupUI
    func setupUI() {
        self.view.backgroundColor = .black
        self.setupSpotlight()
    }
    
    // MARK: - setupSpotlight
    func setupSpotlight() {
        self.spotlightLayer.backgroundColor = UIColor.yellow.withAlphaComponent(0.25).cgColor
        self.spotlightLayer.cornerRadius = 50
        self.spotlightLayer.shadowColor = UIColor.yellow.cgColor
        self.spotlightLayer.shadowRadius = 25
        self.spotlightLayer.shadowOpacity = 0.8
        self.spotlightLayer.shadowOffset = .zero
        self.spotlightLayer.opacity = 0.0
        self.view.layer.addSublayer(self.spotlightLayer)
    }
    
    // MARK: - Profile Setup Animation
    func setupProfiles(
        with profiles: [ProfileViewReactor],
        completion: @escaping () -> Void
    ) {
        
        self.profileViews.removeAll()
        
        let center = view.center
        let lampOrigin = CGPoint(x: center.x, y: center.y + 250)
        let delayPerItem = 0.15
        
        
        for (index, user) in profiles.enumerated() {
            let pv = ProfileView()
            pv.reactor = user
            pv.alpha = 0
            pv.center = lampOrigin
            pv.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            view.addSubview(pv)
            self.profileViews.append(pv)
            
            let angle = CGFloat(index) / CGFloat(profiles.count) * 2 * .pi
            let target = CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )
            
            UIView.animate(
                withDuration: 1.0,
                delay: Double(index) * delayPerItem,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.4,
                options: [.curveEaseOut],
                animations: {
                    pv.alpha = 1
                    pv.center = target
                    pv.transform = .identity
                },
                completion: { _ in
                    // 전체 애니메이션이 끝난 시점에 completion 호출
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        completion()
                    }
                }
            )
        }
        

    }
}

extension LottoSpotlightCircleViewController: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        self.rx.methodInvoked(#selector(self.viewDidLoad))
            .map { _ in LottoSpotlightCircleViewReactor.Action.load }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: - State
        
        reactor.state.map { $0.profileItems }
            .distinctUntilChanged()
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                $0.0.setupProfiles(with: $0.1) {
                    reactor.action.onNext(.loadAnimationFinished)
                }
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isSpotlightActive }
            .distinctUntilChanged()
            .filter { $0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                self?.startSpinning()
            })
            .disposed(by: self.disposeBag)
    }
}
