//
//  InheritedFromCardController.swift
//  ALPopupController Example
//
//  Created by Alexandr Guzenko on 16.08.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//

import UIKit
import ALPopup

final class InheritedFromCardController: ALCardController {
    // MARK: - UI Elements
    
    private lazy var controllerView = ContentViewForInheritedController()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controllerView.setRandomProgress()
    }
}

// MARK: - Layout Setup
private extension InheritedFromCardController {
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

