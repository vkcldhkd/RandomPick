//
//  Untitled.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/6/25.
//

import ObjectiveC
import UIKit

private var kTransitionControllerKey: UInt8 = 0

extension UIViewController {
    var transitionController: ProfileTransitionController? {
        get { objc_getAssociatedObject(self, &kTransitionControllerKey) as? ProfileTransitionController }
        set { objc_setAssociatedObject(self, &kTransitionControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
