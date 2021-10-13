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

open class ALCardController: ALBaseOverlayController {
    
    // MARK: - Private Proporties
    
    private var bottomConstraint: NSLayoutConstraint?
    private var centerConstraint: NSLayoutConstraint?
    private var isPresented = false
    
    // MARK: UIViewController
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.frame.width >= 500 {
            bottomConstraint?.isActive = false
            centerConstraint?.isActive = true
            
        } else {
            bottomConstraint?.isActive = true
            centerConstraint?.isActive = false
        }
        updateContentCorners()
    }
    
    // MARK: - ALBaseOverlayController
 
    open override func presentAnimation() {
        guard isPresented == false else { return }
        isPresented = true
        let height = contentView.frame.maxY
        contentView.transform = .init(translationX: 0, y: height)
        backgroundView.alpha = 0
        contentView.alpha = 1
        resetAnimation()
    }
    
    open override func dismissAnimation(competion: @escaping () -> Void) {
        let frame = contentView.frame
        ALAnimate.spring(time: 0.6) {
            self.backgroundView.alpha = 0
            self.contentView.transform = .init(translationX: 0, y: UIScreen.main.bounds.height - frame.origin.y)
        } completion: {
            competion()
        }
    }
    
    open override func resetAnimation() {
        ALAnimate.spring(time: 0.4, damping: 1) {
            self.backgroundView.alpha = 1
        }
        
        ALAnimate.spring(time: 0.5, damping: 0.85, velocity: 0.8) {
            self.contentView.transform = .identity
        }
    }
}

// MARK: - Layout Setup

private extension ALCardController {
    func setupView() {
        backgroundView.alpha = 0
        backgroundView.backgroundColor = UIColor.black.alpha(0.6)
        
        contentView.alpha = 0
    }
    
    func setupConstraints() {
        view.addSubview(backgroundView)
        view.addSubview(contentView)
        
        let cardOffset: CGFloat = 5
        
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
        bottomConstraint = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -cardOffset)
        centerConstraint = contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        bottomConstraint?.priority = .defaultLow
    }
    
    func updateContentCorners() {
        var isRoundDisplay: Bool {
            view.safeAreaInsets.bottom > 0
        }
        
        var isBottomPosition: Bool {
            bottomConstraint?.isActive == true
        }
        
        var isIpad: Bool {
            UIDevice.current.userInterfaceIdiom == .pad
        }
        
        contentView.cornerRadius =  isIpad ? 12 : (isRoundDisplay ? 36 : 18)
    }
}
