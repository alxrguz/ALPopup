//
//  DetailViewController.swift
//  ALPopupController Example
//
//  Created by Alexandr Guzenko on 16.08.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - UI Elements
    lazy var titleLabel = UILabel()
    
    // MARK: - Life cycle
    init() {
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


// MARK: - Layout Setup
private extension DetailViewController {
    func setupColors() {
        view.backgroundColor = .systemBackground
    }
    
    func setupView() {
        setupColors()
        
        navigationItem.do {
            $0.title = "Detail"
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 152, weight: .bold)
        }
    }
    
    func setupConstraints() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

