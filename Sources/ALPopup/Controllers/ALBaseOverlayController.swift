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

open class ALBaseOverlayController: UIViewController {
    
    // MARK:  UI Elements
    
    public lazy var contentView = ALPopupContentView()
    public lazy var closeButton = UIButton()
    public lazy var backgroundView = UIView()
    
    // MARK:  Open Proporties
    
    /**
     Is Close Button show on controller
     */
    public var isEnableCloseButton = true { didSet { closeButton.isHidden = !isEnableCloseButton } }
    
    /**
     Should the controller be closed by tap on the darkened area
     */
    public var dismissByTapAround = true
    
    /**
     Whether swipe to dismiss should be allowed. Defaults to true.
     
     If you set this to false, the pan gesture will continue to be recognized, but with noticeable resistance and the user won't be able to close the controller with a swipe.
     */
    public var allowsSwipeInteraction = true
    
    /**
     The home indicator for iPhone X should be hidden or not. Defaults is true.
     */
    public var isHomeIndicatorVisible = true {
        didSet {
            setNeedsUpdateOfHomeIndicatorAutoHidden()
        }
    }
    
//    /**
//     If you are placing scroll views (UITableView, UICollectionView, etc.) on a controller, then set this property to true to leave it possible to close with a swipe
//     */
//    public var isContainsScrollView = false {
//        didSet {
//            pan.delegate = isContainsScrollView == true ? self : nil
//        }
//    }
    
    // MARK:  Private Proporties
    
    private lazy var pan = UIPanGestureRecognizer(target: self, action: #selector(swipeHandler(_:)))
    
    // MARK: - Life cycle
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupConstraints()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentAnimation()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.setImage(Source.Image.smallCloseButton, for: .normal)
        contentView.bringSubviewToFront(closeButton)
    }
    
    open override var prefersHomeIndicatorAutoHidden: Bool {
        return !isHomeIndicatorVisible
    }
    
    // MARK: - Custom Present & Dissmiss
    
    public func push(from viewController: UIViewController, haptic: ALHaptic = .none) {
        viewController.present(self, animated: false) {
            haptic.impact()
        }
    }
    
    public func pop(completion: (() -> Void)? = nil) {
        dismissAnimation {
            self.dismiss(animated: false, completion: completion)
        }
    }
    
    // MARK: - Animations
    
    /**
     Animation that will fire when the controller is presented
     */
    open func presentAnimation() {
        fatalError("Method must be overridden")
    }
    
    /**
     Animation that will fire when the controller is dismiss
     */
    open func dismissAnimation(competion: @escaping () -> Void) {
        fatalError("Method must be overridden")
    }
    
    /**
     An animation that returns the controller to its original position. For example, when the gesture was canceled
     */
    open func resetAnimation() {
        fatalError("Method must be overridden")
    }
}

// MARK: - Actions
extension ALBaseOverlayController {
    @objc func closeController() {
        pop()
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        pan.cancelsTouchesInView = false
        contentView.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAround))
        backgroundView.addGestureRecognizer(tap)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ALBaseOverlayController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let otherPan = otherGestureRecognizer as? UIPanGestureRecognizer else { return true }
        
//        guard isContainsScrollView == true else { return false }
        
        let velosity = otherPan.velocity(in: contentView)
        return abs(velosity.y) > abs(velosity.x)
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        var scrollViews = [UIScrollView]()
        
        for view in contentView.subviews {
            if let scrollView = view as? UIScrollView {
                scrollViews.append(scrollView)
            }
        }
        guard let scrollView = scrollViews.first else { return true }
        
        let touchPoint = pan.location(in: scrollView)
        guard touchPoint.x >= 0 && touchPoint.y >= 0 else { return true }
        
        let translate = pan.translation(in: contentView).y
        guard translate > 0 else { return false }
        
        if -scrollView.contentInset.top == scrollView.contentOffset.y {
            scrollView.isScrollEnabled = false
            return true
        } else {
            scrollView.isScrollEnabled = true
            return false
        }
    }
}

// MARK: - Handlers
private extension ALBaseOverlayController {
    @objc func tapAround() {
        guard dismissByTapAround else { return }
        closeController()
    }
    
    @objc func swipeHandler(_ gestureRecognizer : UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began: gestureRecognizer.setTranslation(.zero, in: contentView)
        case .cancelled, .ended: swipeCanceled()
        case .changed: swipeChanged()
        default: break
        }
    }
    
    func swipeCanceled() {
        var scrollViews = [UIScrollView]()
        for view in contentView.subviews {
            if let scrollView = view as? UIScrollView {
                scrollViews.append(scrollView)
            }
        }
        scrollViews.forEach { $0.isScrollEnabled = true }
        
        guard allowsSwipeInteraction else {
            resetAnimation()
            return
        }
        let maxSwipeHeight = contentView.frame.height
        let velocity = pan.velocity(in: contentView)
        if velocity.y > 1000 { pop(); return }
        let verticalTranslation = pan.translation(in: contentView).y
        if abs(verticalTranslation) > (maxSwipeHeight / 2) && verticalTranslation > 0 {
            pop()
        } else {
            resetAnimation()
        }
    }
    
    func swipeChanged() {
        let maxSwipeHeight = contentView.frame.height
        let verticalTranslation = pan.translation(in: contentView).y
        
        guard allowsSwipeInteraction else {
            contentView.transform = .init(translationX: 0, y: verticalTranslation * 0.08)
            return
        }
        
        func swipeTop() {
            let translation =  verticalTranslation * 0.2
            let maxSwipe: CGFloat = -70
            if translation > maxSwipe {
                contentView.transform = .init(translationX: 0, y: translation)
            } else {
                var coefficient = 1 - (abs(translation) / 100)
                if coefficient < 0.3 {
                    coefficient = 0.3
                } else if coefficient > 1 {
                    coefficient = 1
                }
                let offset = (translation - maxSwipe) * coefficient
                contentView.transform = .init(translationX: 0, y: maxSwipe + offset)
            }
        }
        
        func swipeDown() {
            let translation =  verticalTranslation * 0.95
            backgroundView.alpha = 1 - (translation / maxSwipeHeight)
            contentView.transform = .init(translationX: 0, y: translation)
        }
        verticalTranslation < 0 ? swipeTop() : swipeDown()
    }
}

// MARK: - Layout Setup

private extension ALBaseOverlayController {
    func setupConstraints() {
        contentView.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
    }
}
