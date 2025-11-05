//
//  ProfileTransition.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/6/25.
//

import UIKit

public protocol ProfileTransitionSourceProvider: AnyObject {
    /// present 시, 확대될 origin view를 반환 (예: 선택된 ProfileView의 image 컨테이너)
    func profileTransitionOriginView() -> UIView?
}

public protocol ProfileTransitionDestinationProvider: AnyObject {
    /// dismiss 시, 축소될 destination view를 반환 (예: 이전 화면의 선택된 ProfileView)
    func profileTransitionDestinationView() -> UIView?
}

/// 전환 컨트롤러 (transitioningDelegate + animated transitioning 통합)
public final class ProfileTransitionController: NSObject, UIViewControllerTransitioningDelegate {
    public typealias ViewProvider = () -> UIView?

    private let originProvider: ViewProvider
    private let destinationProvider: ViewProvider

    /// dimming / 재사용 뷰 (성능)
    private let dimmingView = UIView()
    private let usesSpring: Bool

    public init(origin: @escaping ViewProvider,
                destination: @escaping ViewProvider,
                usesSpring: Bool = true) {
        self.originProvider = origin
        self.destinationProvider = destination
        self.usesSpring = usesSpring
        super.init()
        dimmingView.backgroundColor = UIColor.black
        dimmingView.alpha = 0
        dimmingView.isUserInteractionEnabled = false
    }

    // MARK: UIViewControllerTransitioningDelegate
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        Animator(mode: .present(origin: originProvider, dimming: dimmingView, usesSpring: usesSpring))
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Animator(mode: .dismiss(destination: destinationProvider, dimming: dimmingView, usesSpring: usesSpring))
    }
}

// MARK: - Animator
extension ProfileTransitionController {
    private final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
        enum Mode {
            case present(origin: () -> UIView?, dimming: UIView, usesSpring: Bool)
            case dismiss(destination: () -> UIView?, dimming: UIView, usesSpring: Bool)
        }

        private let mode: Mode
        init(mode: Mode) { self.mode = mode }

        func transitionDuration(using ctx: UIViewControllerContextTransitioning?) -> TimeInterval { 0.60 }

        func animateTransition(using ctx: UIViewControllerContextTransitioning) {
            switch mode {
            case let .present(originProvider, dimming, usesSpring):
                present(using: ctx, originProvider: originProvider, dimming: dimming, usesSpring: usesSpring)
            case let .dismiss(destinationProvider, dimming, usesSpring):
                dismiss(using: ctx, destinationProvider: destinationProvider, dimming: dimming, usesSpring: usesSpring)
            }
        }

        // MARK: - Present
        private func present(
            using ctx: UIViewControllerContextTransitioning,
            originProvider: () -> UIView?,
            dimming: UIView,
            usesSpring: Bool
        ) {

            guard let toVC = ctx.viewController(forKey: .to),
                let container = Optional(ctx.containerView),
                let originView = originProvider(),
                let snapshot = originView.snapshotView(afterScreenUpdates: false) else { ctx.completeTransition(false); return }

            // 최종 프레임 세팅
            let finalFrame = ctx.finalFrame(for: toVC)
            toVC.view.frame = finalFrame
            toVC.view.alpha = 0

            // 좌표 변환
            let startFrame = originView.convert(originView.bounds, to: container)

            // 성능: rasterize
            snapshot.layer.shouldRasterize = true
            snapshot.layer.rasterizationScale = UIScreen.main.scale
            snapshot.layer.masksToBounds = true
            snapshot.layer.cornerRadius = originView.layer.cornerRadius

            // 계층
            if dimming.superview == nil { // 재사용
                dimming.frame = container.bounds
                container.addSubview(dimming)
            }
            container.addSubview(toVC.view)
            container.addSubview(snapshot)

            // 초기 상태
            dimming.alpha = 0
            snapshot.frame = startFrame

            let duration = transitionDuration(using: ctx)
            let animations = {
                dimming.alpha = 0.35
                snapshot.frame = finalFrame
                snapshot.layer.cornerRadius = 0
                toVC.view.alpha = 1
            }

            let completion: (Bool) -> Void = { _ in
                snapshot.removeFromSuperview()
                ctx.completeTransition(true)
            }

            if usesSpring {
                UIView.animate(
                    withDuration: duration,
                    delay: 0,
                    usingSpringWithDamping: 0.86,
                    initialSpringVelocity: 0.35,
                    options: [.curveEaseInOut],
                    animations: animations,
                    completion: completion
                )
            } else {
                UIView.animate(
                    withDuration: duration,
                    delay: 0,
                    options: [.curveEaseInOut],
                    animations: animations,
                    completion: completion
                )
            }
        }

        // MARK: - Dismiss
        private func dismiss(
            using ctx: UIViewControllerContextTransitioning,
            destinationProvider: () -> UIView?,
            dimming: UIView,
            usesSpring: Bool
        ) {

            guard
                let fromVC = ctx.viewController(forKey: .from),
                let toVC = ctx.viewController(forKey: .to)
            else { ctx.completeTransition(false); return }

            let container = ctx.containerView
            container.insertSubview(toVC.view, belowSubview: fromVC.view)

            // 현재 화면 전체를 스냅샷 (1장) → 성능상 충분히 가볍고 안전
            guard let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true) else {
                ctx.completeTransition(true); return
            }
            snapshot.frame = fromVC.view.frame
            snapshot.layer.shouldRasterize = true
            snapshot.layer.rasterizationScale = UIScreen.main.scale
            container.addSubview(snapshot)
            fromVC.view.isHidden = true

            // 목적지 좌표
            let endFrame: CGRect = {
                guard let dest = destinationProvider() else { return CGRect(x: container.bounds.midX, y: container.bounds.midY, width: 2, height: 2) }
                return dest.convert(dest.bounds, to: container)
            }()

            let duration = transitionDuration(using: ctx)
            let animations = {
                snapshot.frame = endFrame
                snapshot.layer.cornerRadius = 16 // 필요 시 dest.cornerRadius로 동기화
                dimming.alpha = 0.0
            }

            let completion: (Bool) -> Void = { _ in
                snapshot.removeFromSuperview()
                fromVC.view.isHidden = false
                ctx.completeTransition(true)
            }

            if usesSpring {
                UIView.animate(
                    withDuration: duration,
                    delay: 0,
                    usingSpringWithDamping: 0.92,
                    initialSpringVelocity: 0.25,
                    options: [.curveEaseInOut],
                    animations: animations,
                    completion: completion
                )
            } else {
                UIView.animate(
                    withDuration: duration,
                    delay: 0,
                    options: [.curveEaseInOut],
                    animations: animations,
                    completion: completion
                )
            }
        }
    }
}
