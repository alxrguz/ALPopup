// The MIT License (MIT)
//
// Copyright (c) 2021 Alexandr Guzenko (alxrguz@icloud.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import ALDevKit

final class MixedScrollViewController: UIViewController {
    // MARK: - UI Elements
    
    // MARK: - Public Proporties
    private lazy var scrollView = ALScrollView()
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
    }
}

// MARK: - Navigation

extension MixedScrollViewController: UICollectionViewDataSource {
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
private extension MixedScrollViewController {
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
        

        scrollView.do {
            $0.alwaysBounceVertical = true
        }
    }
    
    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.contentView.addSubviews([collectionView, collectionView1, actionButton])
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(600)
        }
        
        scrollView.contentView.snp.makeConstraints {
            $0.height.equalTo(scrollView.safeAreaLayoutGuide)
        }
        
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
            $0.top.greaterThanOrEqualTo(collectionView1.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}


