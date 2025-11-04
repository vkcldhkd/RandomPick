//
//  BaseView.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import UIKit
import RxSwift
import RxCocoa

class BaseView: UIView {
    
    // MARK: Properties
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    // MARK: Rx
    var disposeBag = DisposeBag()
    
    deinit {
        print("DEINIT : \(self.className)")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
