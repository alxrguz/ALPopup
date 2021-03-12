
import UIKit

open class ALActionButton: ALBasicButton {
    var roundCorners: CGFloat = 14 { didSet { layoutSubviews() } }
    private lazy var indicatorView = UIActivityIndicatorView()
    
    var isLoading = false {
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
        makeRoundCorners(radius: roundCorners)
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
