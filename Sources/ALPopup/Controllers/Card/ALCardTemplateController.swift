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

public final class ALCardTemplateController: ALCardController {
    
    // MARK: - UI Elements
    
    public lazy var tempateView = ALTemplateView()
    
    // MARK: UIViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        tempateView.insetsLayoutMarginsFromSafeArea = true
    }
}

// MARK: - Layout Setup

private extension ALCardTemplateController {
    func setupConstraints() {
        contentView.addSubview(tempateView)
        
        let sideOffset: CGFloat = 26
        let maxWidth: CGFloat = 380
        
        tempateView.translatesAutoresizingMaskIntoConstraints = false
        tempateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36).isActive = true
        
        let leadingConstraint = tempateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideOffset)
        leadingConstraint.priority = .init(999)
        leadingConstraint.isActive = true
        
        let trailingConstraint = tempateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideOffset)
        trailingConstraint.priority = .init(999)
        trailingConstraint.isActive = true
        
        tempateView.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        tempateView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        tempateView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20).isActive = true
        let bottomSafeAreaConstraint = tempateView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        bottomSafeAreaConstraint.priority = .init(990)
        bottomSafeAreaConstraint.isActive = true
    }
}
