

import UIKit

public class ALPopupContentView: UIView {
    
    // MARK: - Open Proporties
    
    /// Rounding corners in superellipse. Gives nicer and more correct rounding, but does not work well with frame animations. Default is `true`
    public var superellipticRounding: Bool = true {
        didSet {
            layoutSubviews()
        }
    }
    
    // MARK: - Internal Proporties
    
    internal var cornerRadius: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        backgroundColor = Source.Color.contentColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        makeRoundCorners(radius: cornerRadius, superelliptic: superellipticRounding)
    }
}
