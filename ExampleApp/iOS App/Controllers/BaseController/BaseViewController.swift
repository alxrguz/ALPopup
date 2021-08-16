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
import ALRadioButtons

final class BaseViewController: UIViewController {
    // MARK: - UI Elements
    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()
    private lazy var radioGroup = ALRadioGroup(items: [
        .init(title: "First item", subtitle: "Subtitle for 1st item", detail: "Info"),
        .init(title: "Second item", subtitle: "Subtitle for 2nd item", detail: "Info"),
    ], style: .grouped)
    private lazy var actionButton = ALActionButton()
    
    // MARK: - Public Proporties
    var needCloseController: (() -> Void)?
    
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
private extension BaseViewController {
    
}

// MARK: - Open Methods
extension BaseViewController {
    @objc func actionButtonTapped() {
        needCloseController?()
    }
}

// MARK: - Private Methods
private extension BaseViewController {
    func setupActions() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Navigation
private extension BaseViewController {
    
}

// MARK: - Layout Setup
private extension BaseViewController {
    func setupColors() {
        view.backgroundColor = .systemGroupedBackground
        titleLabel.textColor = .label
        subtitleLabel.textColor = .secondaryLabel
    }
    
    func setupView() {
        setupColors()
        
        titleLabel.do {
            $0.font = .preferredFont(forTextStyle: .title2, weight: .bold)
            $0.text = "Base View Controller"
            $0.textAlignment = .center
        }
        
        subtitleLabel.do {
            $0.font = .preferredFont(forTextStyle: .callout)
            $0.text = "This controller provides the ALRadioButtons library"
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
        
        actionButton.do {
            $0.setTitle("Choose")
        }
    }
    
    func setupConstraints() {
        view.addSubviews([titleLabel, subtitleLabel, radioGroup, actionButton])
        
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.leading.trailing.equalTo(safeArea).inset(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(safeArea).inset(16)
        }
        
        radioGroup.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(safeArea).inset(16)
        }
        
        actionButton.snp.makeConstraints {
            $0.top.equalTo(radioGroup.snp.bottom).offset(35)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeArea).priority(999)
            $0.bottom.lessThanOrEqualToSuperview().offset(-17)
        }
    }
}

