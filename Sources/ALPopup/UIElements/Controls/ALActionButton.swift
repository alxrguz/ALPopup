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

open class ALActionButton: ALBasicButton {
    public var roundCorners: CGFloat = 14 { didSet { layoutSubviews() } }
    private lazy var indicatorView = UIActivityIndicatorView()
    
    public var isLoading = false {
        didSet {
            loading()
        }
    }
    
    init() {
        super.init(frame: .zero)
        applyDefaultAppearance(with: Colorise(content: Source.Color.overlayAccentColor, background: Source.Color.accent))
        titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        
        
        addSubview(indicatorView)
        translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.priority = .init(999)
        heightConstraint.isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 3.5)
        titleEdgeInsets = .init(top: 0, left: 3.5, bottom: 0, right: 0)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(radius: roundCorners, continuous: true)
    }
    
    open override func applyDefaultAppearance(with colorise: ALBasicButton.Colorise? = nil) {
        super.applyDefaultAppearance(with: colorise)
        if case .custom(let titleColor) = colorise?.title {
            indicatorView.color = titleColor
        }
    }
    
    func loading() {
        if isLoading {
            isUserInteractionEnabled = false
            self.titleLabel?.alpha = 0
            self.imageView?.transform = .init(scaleX: 0, y: 0)
            self.indicatorView.startAnimating()
        } else {
            isUserInteractionEnabled = true
            indicatorView.stopAnimating()
            self.titleLabel?.alpha = 1
            self.imageView?.transform = .init(scaleX: 1, y: 1)
        }
    }
}
