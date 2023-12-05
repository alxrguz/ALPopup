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

open class ALPopupController: ALBaseOverlayController {
    
    // MARK: - Private Proporties
    
    private var isPresented = false
    
    // MARK: - Life cycle
    
    public override init() {
        super.init()
        allowsSwipeInteraction = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContentCorners()
    }
    
    // MARK: - ALBaseOverlayController

    open override func presentAnimation() {
        guard isPresented == false else { return }
        isPresented = true
        contentView.transform = .init(translationX: 0, y: 50)
        backgroundView.alpha = 0
        contentView.alpha = 0
        resetAnimation()
    }
    
    open override func dismissAnimation(competion: @escaping () -> Void) {
        let translationY: CGFloat = {
            let currentTranlation = contentView.transform.ty
            if currentTranlation > 0 {
                return currentTranlation + currentTranlation * 0.7
            } else {
                return 50
            }
        }()
        
        popupWillClose?()
        ALAnimate.spring(time: 0.4) {
            self.backgroundView.alpha = 0
            self.contentView.alpha = 0
            self.contentView.transform = .init(translationX: 0, y: translationY)
        } completion: { [weak self] in
            competion()
            self?.popupDidClose?()
        }
    }
    
    open override func resetAnimation() {
        ALAnimate.spring(time: 0.4, damping: 1) {
            self.backgroundView.alpha = 1
        }
        
        ALAnimate.spring(time: 0.4, damping: 0.85, velocity: 0.8) {
            self.contentView.transform = .identity
            self.contentView.alpha = 1
        }
    }
}

// MARK: - Layout Setup
private extension ALPopupController {
    func setupView() {
        backgroundView.alpha = 0
        backgroundView.backgroundColor = dimmedBackgroudColor ?? .black.alpha(0.6)
        contentView.alpha = 0
    }
    
    func setupConstraints() {
        view.addSubview(backgroundView)
        view.addSubview(contentView)
        
        let cardOffset: CGFloat = 16
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let leadingContent = contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: cardOffset)
        leadingContent.priority = .init(999)
        leadingContent.isActive = true
        let trailingContent = contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -cardOffset)
        trailingContent.priority = .init(999)
        trailingContent.isActive = true
        contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 485).isActive = true
        contentView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func updateContentCorners() {
        contentView.cornerRadius = 24
        contentView.layer.masksToBounds = true
    }
}
