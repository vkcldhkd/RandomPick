//
//  LottoSpotlightViewController.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/3/25.
//
import ReactorKit
import RxSwift

import UIKit
import AudioToolbox
import RxCocoa


final class LottoSpotlightCircleViewController: BaseViewController {
    // MARK: - Constants
    typealias Reactor = LottoSpotlightCircleViewReactor
    private let radius: CGFloat = 120
    
    // MARK: - Properties
    
    private var profileViews: [ProfileView] = []
    private let spotlightLayer = CALayer()
    private var currentIndex = 0
    private var isSpinning = false
    
    private var expandedSnapshot: UIView?
    private var activeSmokeEmitters: [CAEmitterLayer] = []
    
    init() {
        defer { self.reactor = Reactor() }
        super.init()
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
//    // MARK: - Setup Profiles (요술램프 등장 애니메이션 + 타이밍 조정)
//    private func setupProfiles() {
//        let data: [(String, String)] = [
//            ("Alice", "profile1"), ("Bella", "profile2"), ("Clara", "profile3"),
//            ("Diana", "profile4"), ("Eve", "profile5"), ("Fiona", "profile6")
//        ]
//        let center = view.center
//        let lampOrigin = CGPoint(x: center.x, y: center.y + 250)
//        
//        let animationDelayPerProfile: Double = 0.15
//        let totalAnimationTime = Double(data.count) * animationDelayPerProfile + 1.0
//        
//        for (i, item) in data.enumerated() {
//            let angle = CGFloat(i) / CGFloat(data.count) * 2 * .pi
//            let pv = ProfileView()
//            pv.name = item.0
//            pv.image = UIImage(named: item.1)
//            pv.alpha = 0
//            pv.frame = CGRect(x: 0, y: 0, width: 80, height: 100)
//            pv.center = lampOrigin
//            view.addSubview(pv)
//            profileViews.append(pv)
//            
//            createSmokeEmitter(at: lampOrigin)
//            
//            let target = CGPoint(
//                x: center.x + radius * cos(angle),
//                y: center.y + radius * sin(angle)
//            )
//            let delay = Double(i) * animationDelayPerProfile
//            
//            pv.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//            
//            UIView.animate(withDuration: 1.0,
//                           delay: delay,
//                           usingSpringWithDamping: 0.7,
//                           initialSpringVelocity: 0.4,
//                           options: [.curveEaseOut]) {
//                pv.alpha = 1.0
//                pv.center = target
//                pv.transform = .identity
//            } completion: { _ in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    self.removeSmokeEmitters()
//                }
//            }
//        }
//        
//        // 💫 모든 프로필 등장 완료 후 자동 시작
//        DispatchQueue.main.asyncAfter(deadline: .now() + totalAnimationTime) {
//            self.startSpinning()
//        }
//    }
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
//    // MARK: - Spin Animation (이전과 동일)
//    @objc func startSpinning() {
//        guard !isSpinning else { return }
//        isSpinning = true
//        
//        var speed: TimeInterval = 0.05
//        var cycles = 0
//        let maxCycles = Int.random(in: 40...60)
//        
//        func spinStep() {
//            currentIndex = (currentIndex + 1) % profileViews.count
//            highlightCurrentProfile()
//            glow(on: profileViews[currentIndex])
//            AudioServicesPlaySystemSound(1104)
//            
//            cycles += 1
//            if cycles > maxCycles - 10 { speed += 0.04 }
//            else if cycles > maxCycles - 20 { speed += 0.02 }
//            
//            if cycles < maxCycles {
//                DispatchQueue.main.asyncAfter(deadline: .now() + speed, execute: spinStep)
//            } else {
//                finishSpinning(at: currentIndex)
//            }
//        }
//        spinStep()
//    }
//    
//    private func highlightCurrentProfile() {
//        for (i, pv) in profileViews.enumerated() {
//            if i == currentIndex {
//                pv.alpha = 1.0
//                pv.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//            } else {
//                pv.alpha = 0.4
//                pv.transform = .identity
//            }
//        }
//    }
//    
//    private func glow(on profile: ProfileView) {
//        let glow = CALayer()
//        glow.frame = profile.bounds
//        glow.cornerRadius = profile.bounds.width / 2
//        glow.borderWidth = 4
//        glow.borderColor = UIColor.systemYellow.cgColor
//        glow.opacity = 0.0
//        profile.layer.addSublayer(glow)
//        let fade = CABasicAnimation(keyPath: "opacity")
//        fade.fromValue = 0.8
//        fade.toValue = 0.0
//        fade.duration = 0.25
//        glow.add(fade, forKey: "glowFade")
//    }
//    
//    private func finishSpinning(at index: Int) {
//        isSpinning = false
//        showSpotlight(at: index)
//        let selected = profileViews[index]
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.success)
//        
//        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
//                selected.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//            }
//            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
//                selected.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//            }
//        }) { _ in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.expandSelectedProfile(selected)
//            }
//        }
//    }
//    
//    private func showSpotlight(at index: Int) {
//        guard index < profileViews.count else { return }
//        let target = profileViews[index]
//        spotlightLayer.frame = target.frame.insetBy(dx: -10, dy: -10)
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(0.4)
//        spotlightLayer.opacity = 1.0
//        CATransaction.commit()
//    }
//    
//    private func expandSelectedProfile(_ profile: ProfileView) {
//        guard let snapshot = profile.snapshotView(afterScreenUpdates: true) else { return }
//        snapshot.frame = view.convert(profile.frame, from: profile.superview)
//        view.addSubview(snapshot)
//        
//        profileViews.forEach { $0.isHidden = true }
//        spotlightLayer.opacity = 0.0
//        expandedSnapshot = snapshot
//        
//        UIView.animate(withDuration: 1.0,
//                       delay: 0,
//                       usingSpringWithDamping: 0.8,
//                       initialSpringVelocity: 0.4,
//                       options: [.curveEaseInOut]) {
//            snapshot.frame = self.view.bounds
//        } completion: { _ in
//            let tap = UITapGestureRecognizer(target: self, action: #selector(self.shrinkBackToCircle))
//            snapshot.addGestureRecognizer(tap)
//            snapshot.isUserInteractionEnabled = true
//        }
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
    
    // MARK: - Spotlight Layer
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
}

extension LottoSpotlightCircleViewController: ReactorKit.View {
    func bind(reactor: Reactor) {
        // MARK: - Action
        self.rx.methodInvoked(#selector(self.viewDidLoad))
            .map { _ in LottoSpotlightCircleViewReactor.Action.load }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // MARK: - State
    }
}
