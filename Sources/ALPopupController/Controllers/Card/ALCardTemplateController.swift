
import UIKit

public final class ALCardTemplateController: ALCardController {
    // MARK: - UI Elements
    public lazy var titleLabel = UILabel()
    public lazy var subtitleLabel = UILabel()
    public lazy var imageView = UIImageView()
    public lazy var primaryButton = ALActionButton()
    public lazy var secondaryButton = ALActionButton()
    private lazy var titleStackView = UIStackView()
    private lazy var buttonStackView = UIStackView()
    
    // MARK: - Open Proporties
    public var primaryButtonAction: (() -> Void)?
    public var secondaryButtonAction: (() -> Void)?
    
    // MARK: - Private Proporties
    
    // MARK: - Life cycle
    public override init() {
        super.init()
        setupView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions
private extension ALCardTemplateController {
    @objc func primaryButtonTapped() {
        primaryButtonAction?()
    }
    
    @objc func secondaryButtonTapped() {
        secondaryButtonAction?()
    }
    
    func setupActions() {
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
    }
}


// MARK: - Layout Setup
private extension ALCardTemplateController {
    func setupView() {
        contentView.superellipticRounding = true
        
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = Source.Color.labelPrimary
        titleLabel.text = "Title"
        titleLabel.textAlignment = .center
        
        subtitleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        subtitleLabel.textColor = Source.Color.labelSecondary
        subtitleLabel.text = "Subtitle"
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        
        contentView.superellipticRounding = true
        
        imageView.contentMode = .scaleAspectFit
        
        primaryButton.setTitle("Ok", for: .normal)
        
        secondaryButton.setTitle("Cancel", for: .normal)
        secondaryButton.applyDefaultAppearance(with: .init(content: Source.Color.accent, background: .clear))
        secondaryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        titleStackView.axis = .vertical
        titleStackView.spacing = 6
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
    }
    
    func setupConstraints() {
        contentView.addSubview(titleStackView)
        contentView.addSubview(imageView)
        contentView.addSubview(buttonStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        buttonStackView.addArrangedSubview(primaryButton)
        buttonStackView.addArrangedSubview(secondaryButton)
        
        let sideOffset: CGFloat = 26
        let maxWidth: CGFloat = 380
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36).isActive = true
        let titleLeading = titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideOffset)
        titleLeading.priority = .init(990)
        titleLeading.isActive = true
        let titleTrailing = titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideOffset)
        titleTrailing.priority = .init(990)
        titleTrailing.isActive = true
        titleStackView.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        titleStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 130).isActive = true
        let imageWidthConstraint = imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4)
        imageWidthConstraint.priority = .init(999)
        imageWidthConstraint.isActive = true
        
        let imageHeightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        imageHeightConstraint.priority = .init(999)
        imageHeightConstraint.isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25).isActive = true
        let imageLeading = buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideOffset)
        imageLeading.priority = .init(990)
        imageLeading.isActive = true
        let imageTrailing = buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideOffset)
        imageTrailing.priority = .init(990)
        imageTrailing.isActive = true
        buttonStackView.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        buttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
//
        secondaryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

