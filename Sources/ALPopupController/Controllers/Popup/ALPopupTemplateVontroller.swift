import UIKit

public final class ALPopupTemplateController: ALPopupController {
    
    // MARK: - UI Elements
    
    public lazy var tempateView = ALTemplateView()
    
    // MARK: - Life cycle
    
    public override init() {
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        tempateView.insetsLayoutMarginsFromSafeArea = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout Setup

private extension ALPopupTemplateController {
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
