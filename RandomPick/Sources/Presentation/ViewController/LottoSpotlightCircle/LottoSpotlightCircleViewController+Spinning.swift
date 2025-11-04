//
//  LottoSpotlightCircleViewController+Spinning.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//
import UIKit
import AudioToolbox

extension LottoSpotlightCircleViewController {
    func startSpinning() {
        guard !profileViews.isEmpty else { return }
        
        var speed: TimeInterval = 0.05
        var cycles = 0
        let maxCycles = Int.random(in: 40...60)
        
        func spinStep() {
            currentIndex = (currentIndex + 1) % profileViews.count
            self.highlightCurrentProfile()
            self.glow(on: profileViews[currentIndex])
            AudioServicesPlaySystemSound(1104)
            
            cycles += 1
            if cycles > maxCycles - 10 { speed += 0.04 }
            else if cycles > maxCycles - 20 { speed += 0.02 }
            
            if cycles < maxCycles {
                DispatchQueue.main.asyncAfter(deadline: .now() + speed, execute: spinStep)
            } else {
                self.finishSpinning(at: currentIndex)
            }
        }
        spinStep()
    }
}

private extension LottoSpotlightCircleViewController {
    func glow(on profile: ProfileView) {
        let glow = CALayer()
        glow.frame = profile.bounds
        glow.cornerRadius = profile.bounds.width / 2
        glow.borderWidth = 4
        glow.borderColor = UIColor.systemYellow.cgColor
        glow.opacity = 0.0
        profile.layer.addSublayer(glow)
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.8
        fade.toValue = 0.0
        fade.duration = 0.25
        glow.add(fade, forKey: "glowFade")
    }
    
    func highlightCurrentProfile() {
        for (i, pv) in profileViews.enumerated() {
            if i == currentIndex {
                pv.alpha = 1.0
                pv.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            } else {
                pv.alpha = 0.4
                pv.transform = .identity
            }
        }
    }
    
    func finishSpinning(at index: Int) {
//        showSpotlight(at: index)
        let selected = profileViews[index]
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                selected.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                selected.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.expandSelectedProfile(selected)
            }
        }
    }
}
