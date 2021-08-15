//
//  ALFakeNavigationView.swift
//  ALPopupController Example
//
//  Created by Alexandr Guzenko on 15.08.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//

import UIKit

final class ALFakeNavigationView: UIView {
    // MARK: - UI Elements
    lazy var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
    lazy var separator = UIView()
    
    // MARK: - Life cycle
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Setup
private extension ALFakeNavigationView {
    func setupColors() {
        separator.backgroundColor = .separator
    }
    
    func setupView() {
        setupColors()
    }
    
    func setupConstraints() {
        addSubview(blurView)
        addSubview(separator)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        separator.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
