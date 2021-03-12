

import UIKit

public class ALPopupContentView: UIView {
    // MARK: - Open Proporties
    public var cornerRadius: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    public var superellipticRounding: Bool = false {
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
