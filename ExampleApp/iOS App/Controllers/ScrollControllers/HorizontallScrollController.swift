//
//  HorizontallScrollController.swift
//  ALPopup Example
//
//  Created by Alexandr Guzenko on 16.08.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//

import UIKit
import ALDevKit

final class HorizontallScrollController: UIViewController {
    // MARK: - UI Elements
    
    // MARK: - Public Proporties
    private lazy var collectionView = ALCollectionView(collectionViewLayout: collectionLayout)
    private lazy var collectionLayout = UICollectionViewFlowLayout()
    private lazy var collectionView1 = ALCollectionView(collectionViewLayout: collectionLayout)
    private lazy var collectionLayout1 = UICollectionViewFlowLayout()
    private lazy var actionButton = ALActionButton()
    
    // MARK: - Private Proporties
    
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
        setupActions()
    }
}

// MARK: - Handlers
private extension HorizontallScrollController {
    
}

// MARK: - Open Methods
extension HorizontallScrollController {
    
}

// MARK: - Private Methods
private extension HorizontallScrollController {
    func setupActions() {
        
    }
}

// MARK: - Navigation
private extension HorizontallScrollController {
    
}

// MARK: - Navigation

extension HorizontallScrollController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        cell.backgroundColor = [UIColor.systemGray2, UIColor.systemGray3, UIColor.systemGray4].randomElement()
        cell.roundCorners(radius: 16)
        return cell
    }
}

// MARK: - Layout Setup
private extension HorizontallScrollController {
    func setupColors() {
        
    }
    
    func setupView() {
        setupColors()
        
        [collectionView, collectionView1].forEach {
            $0.dataSource = self
            $0.register(UICollectionViewCell.self)
            $0.showsHorizontalScrollIndicator = false
        }
        
        [collectionLayout, collectionLayout1].forEach {
            $0.scrollDirection = .horizontal
            $0.itemSize = .init(width: 300, height: 200)
            $0.sectionInset = .init(horizontal: 16, vertical: 0)
        }
    }
    
    func setupConstraints() {
        view.addSubviews([collectionView, collectionView1, actionButton])
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        collectionView1.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        actionButton.snp.makeConstraints {
            $0.top.equalTo(collectionView1.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

