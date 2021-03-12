
import UIKit

open class ALCardController: ALPopupController {
    
    private var bottomConstraint: NSLayoutConstraint?
    private var centerConstraint: NSLayoutConstraint?
    private var isPresented = false
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.setImage(Source.Image.smallCloseButton, for: .normal)
        contentView.bringSubviewToFront(closeButton)
        if view.frame.width >= 500 {
            bottomConstraint?.isActive = false
            centerConstraint?.isActive = true
        } else {
            bottomConstraint?.isActive = true
            centerConstraint?.isActive = false
        }
        updateContentCorners()
    }
    
    // MARK: - Animations
    /**
     Animation that will fire when the controller is presented
     */
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
        let height = contentView.frame.maxY
        ALAnimate.spring(time: 0.5) {
            self.backgroundView.alpha = 0
            self.contentView.transform = .init(translationX: 0, y: height)
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
        contentView.addSubview(closeButton)
        
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
        bottomConstraint = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -cardOffset)
        centerConstraint = contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        bottomConstraint?.isActive = true
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
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
