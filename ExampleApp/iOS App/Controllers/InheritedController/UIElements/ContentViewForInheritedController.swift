//
//  ContentViewForInheritedController.swift
//  ALPopupController Example
//
//  Created by Alexandr Guzenko on 16.08.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//

import UIKit
import ALDevKit
import ALProgressView

final class ContentViewForInheritedController: UIView {
    
    // MARK: - UI Elements
    
    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()
    private lazy var percentLabel = UILabel()
    private lazy var progressRing = ALProgressRing()
    private lazy var progressBar = ALProgressBar()
    private lazy var actionButton = ALActionButton()
    
    // MARK: - Public Proporties
    
    // MARK: - Private Proporties
    
    // MARK: - Life cycle
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Handlers
private extension ContentViewForInheritedController {
    
}

// MARK: - Public Methods
extension ContentViewForInheritedController {
    @objc func setRandomProgress() {
        let randomProgress = Float.random(in: 0...1)
        
        progressRing.setProgress(randomProgress, animated: true)
        progressBar.setProgress(randomProgress, animated: true)
        percentLabel.text = String(Int(randomProgress * 100))
    }
}

// MARK: - Private Methods
private extension ContentViewForInheritedController {
    func setupActions() {
        actionButton.addTarget(self, action: #selector(setRandomProgress), for: .touchUpInside)
    }
}

// MARK: - Layout Setup
private extension ContentViewForInheritedController {
    func setupColors() {
        progressRing.startColor = .systemBlue.alpha(0.7)
        progressRing.endColor = .systemBlue
        
        progressBar.startColor = .systemBlue.alpha(0.8)
        progressBar.endColor = .systemBlue
        
        titleLabel.textColor = .label
        subtitleLabel.textColor = .secondaryLabel
        percentLabel.textColor = .tertiaryLabel
        
        actionButton.applyDefaultAppearance(with: .init(content: .systemBlue, background: .systemGroupedBackground))
    }
    
    func setupView() {
        setupColors()
        
        titleLabel.do {
            $0.font = .preferredFont(forTextStyle: .title2, weight: .bold)
            $0.text = "Inherited View Controller"
            $0.textAlignment = .center
        }
        
        subtitleLabel.do {
            $0.font = .preferredFont(forTextStyle: .callout)
            $0.text = "This controller provides the ALProgressView library"
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        
        percentLabel.do {
            $0.font = .systemFont(ofSize: 40, weight: .bold).rounded
            $0.text = "0"
        }
        
        actionButton.do {
            $0.setTitle("Randomize")
        }
    }
    
    func setupConstraints() {
        addSubviews([titleLabel, subtitleLabel, progressRing, progressBar, percentLabel, actionButton])
        
        let safeArea = safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.leading.trailing.equalTo(safeArea).inset(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(safeArea).inset(16)
        }
        
        progressRing.snp.makeConstraints {
            $0.size.equalTo(150)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints {
            $0.height.equalTo(10)
            $0.top.equalTo(progressRing.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(safeArea).inset(40)
        }
        
        percentLabel.snp.makeConstraints {
            $0.center.equalTo(progressRing)
        }
        
        actionButton.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeArea).priority(999)
            $0.bottom.lessThanOrEqualToSuperview().offset(-17)
        }
    }
}

