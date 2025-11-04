//
//  LottoSpotlightCircleViewController+Spotlight.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import UIKit

extension LottoSpotlightCircleViewController {
    
}


//    private func showSpotlight(at index: Int) {
//        guard index < profileViews.count else { return }
//        let target = profileViews[index]
//        spotlightLayer.frame = target.frame.insetBy(dx: -10, dy: -10)
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(0.4)
//        spotlightLayer.opacity = 1.0
//        CATransaction.commit()
//    }

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
