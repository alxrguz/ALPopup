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

