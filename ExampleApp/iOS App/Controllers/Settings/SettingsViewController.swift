//
//  SettingsViewController.swift
//  ALPopupController Example
//
//  Created by Alexandr Guzenko on 16.08.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//

import UIKit
import ALDevKit

final class SettingsViewController: UIViewController {
    // MARK: - UI Elements
    
    private lazy var titleLabel = UILabel()
    private lazy var closeButtonSection = ALFakeTableSection()
    private lazy var tapAroundSection = ALFakeTableSection()
    private lazy var swipeInteractionSection = ALFakeTableSection()
    private lazy var sectionStack = UIStackView()
    
    // MARK: - Public Proporties
    
    var isEnableCloseButtonChanged: ((Bool) -> Void)?
    var dismissByTapAroundChanged: ((Bool) -> Void)?
    var allowsSwipeInteractionChanged: ((Bool) -> Void)?
    
    
    // MARK: - Private Proporties
    
    private let isEnableCloseButton: Bool
    private let dismissByTapAround: Bool
    private let allowsSwipeInteraction: Bool
    
    // MARK: - Life cycle
    init(isEnableCloseButton: Bool, dismissByTapAround: Bool, allowsSwipeInteraction: Bool) {
        self.isEnableCloseButton = isEnableCloseButton
        self.dismissByTapAround = dismissByTapAround
        self.allowsSwipeInteraction = allowsSwipeInteraction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
}

// MARK: - Handlers
private extension SettingsViewController {
    @objc func closeButtonUptaded(_ sender: UISwitch) {
        isEnableCloseButtonChanged?(sender.isOn)
    }
    
    @objc func tapAroundUptaded(_ sender: UISwitch) {
        dismissByTapAroundChanged?(sender.isOn)
    }
    
    @objc func swipeInteractionUptaded(_ sender: UISwitch) {
        allowsSwipeInteractionChanged?(sender.isOn)
    }
}

// MARK: - Layout Setup
private extension SettingsViewController {
    func setupColors() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    func setupView() {
        setupColors()
        
        titleLabel.do {
            $0.font = .preferredFont(forTextStyle: .title2, weight: .bold)
            $0.text = "Settings"
            $0.textAlignment = .center
        }
        
        closeButtonSection.do {
            $0.style = .insertGroup
            $0.footer = "Is Close Button show on controller"
            let switchCell = ALFakeSwitchCell().do {
                $0.switchControl.isOn = isEnableCloseButton
                $0.titleLabel.text = "Close Button"
                $0.switchControl.addTarget(self, action: #selector(closeButtonUptaded), for: .valueChanged)
            }
            $0.addCell(switchCell)
        }
        
        tapAroundSection.do {
            $0.style = .insertGroup
            $0.footer = "Should the controller be closed by tap on the darkened area"
            let switchCell = ALFakeSwitchCell().do {
                $0.switchControl.isOn = dismissByTapAround
                $0.titleLabel.text = "Dissmiss by tap Around"
                $0.switchControl.addTarget(self, action: #selector(tapAroundUptaded), for: .valueChanged)
            }
            $0.addCell(switchCell)
        }
        
        swipeInteractionSection.do {
            $0.style = .insertGroup
            $0.footer = "Whether swipe to dismiss should be allowed"
            let switchCell = ALFakeSwitchCell().do {
                $0.switchControl.isOn = allowsSwipeInteraction
                $0.titleLabel.text = "Swipe to Close"
                $0.switchControl.addTarget(self, action: #selector(swipeInteractionUptaded), for: .valueChanged)
            }
            $0.addCell(switchCell)
        }
        
        sectionStack.do {
            $0.axis = .vertical
            $0.spacing = 25
        }
    }
    
    func setupConstraints() {
        sectionStack.addArrangedSubviews([closeButtonSection, tapAroundSection, swipeInteractionSection])
        view.addSubviews([titleLabel, sectionStack])
        
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.leading.trailing.equalTo(safeArea).inset(16)
        }
        
        sectionStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeArea).offset(-8).priority(999)
            $0.bottom.lessThanOrEqualToSuperview().offset(-17)
        }
    }
}

