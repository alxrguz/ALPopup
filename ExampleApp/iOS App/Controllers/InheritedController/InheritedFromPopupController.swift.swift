//
//  InheritedFromPopupController.swift.swift
//  ALPopupController Example
//
//  Created by Alexandr Guzenko on 16.08.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//

import UIKit
import ALPopup

final class InheritedFromPopupController: ALPopupController {
    // MARK: - UI Elements
    
    private lazy var controllerView = ContentViewForInheritedController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
}

// MARK: - Layout Setup
private extension InheritedFromPopupController {
    func setupColors() {
        
    }
    
    func setupView() {
        setupColors()
    }
    
    func setupConstraints() {
        contentView.addSubview(controllerView)
        
        controllerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}