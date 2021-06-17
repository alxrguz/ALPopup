

import UIKit

public class ALTemplateView: UIView {
    
    // MARK: - UI Elements
    
    public lazy var titleLabel = UILabel()
    public lazy var subtitleLabel = UILabel()
    public lazy var imageView = UIImageView()
    public lazy var primaryButton = ALActionButton()
    public lazy var secondaryButton = ALActionButton()
    private lazy var titleStackView = UIStackView()
    private lazy var buttonStackView = UIStackView()
    private lazy var contentStackView = UIStackView()
    
    // MARK: - Public Proporties
    
    /// Template configuration. The corresponding views will be created for the specified parameters.
    public var configuration: ALTemplateSettings? { didSet { updateUI() } }
    
    /// A closure indicating that the primary button was pressed
    public var primaryButtonAction: (() -> Void)? = nil
    
    /// A closure indicating that the secondary button was pressed
    public var secondaryButtonAction: (() -> Void)? = nil
    
    // MARK: - Life cycle
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Handlers

private extension ALTemplateView {
    @objc func primaryButtonTapped() {
        primaryButtonAction?()
    }
    
    @objc func secondaryButtonTapped() {
        secondaryButtonAction?()
    }
}

// MARK: - Private Methods

private extension ALTemplateView {
    func setupActions() {
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Layout Setup

private extension ALTemplateView {
    func setupView() {
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = Source.Color.labelPrimary
        titleLabel.text = "Title"
        titleLabel.textAlignment = .center
        
        subtitleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        subtitleLabel.textColor = Source.Color.labelSecondary
        subtitleLabel.text = "Subtitle"
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFit
        
        primaryButton.setTitle("Ok", for: .normal)
        
        secondaryButton.setTitle("Cancel", for: .normal)
        secondaryButton.applyDefaultAppearance(with: .init(content: Source.Color.accent, background: .clear))
        secondaryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        titleStackView.axis = .vertical
        titleStackView.spacing = 6
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        
        contentStackView.axis = .vertical
        contentStackView.alignment = .center
    }
    
    func updateUI() {
        if let title = configuration?.title {
            titleLabel.text = title
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
        
        if let subtitle = configuration?.subtitle {
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = false
        } else {
            subtitleLabel.isHidden = true
        }
        
        if let image = configuration?.image {
            imageView.image = image
            imageView.isHidden = false
        } else {
            imageView.isHidden = true
        }
        
        if let primaryButtonTitle = configuration?.primaryButtonTitle {
            primaryButton.setTitle(primaryButtonTitle, for: .normal)
            primaryButton.isHidden = false
        } else {
            primaryButton.isHidden = true
        }
        
        if let secondaryButtonTitle = configuration?.secondaryButtonTitle {
            secondaryButton.setTitle(secondaryButtonTitle, for: .normal)
            secondaryButton.isHidden = false
        } else {
            secondaryButton.isHidden = true
        }
    }
    
    func setupConstraints() {
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(titleStackView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(buttonStackView)
        
        contentStackView.setCustomSpacing(20, after: titleStackView)
        contentStackView.setCustomSpacing(25, after: imageView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        buttonStackView.addArrangedSubview(primaryButton)
        buttonStackView.addArrangedSubview(secondaryButton)
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 130).isActive = true
        let imageWidthConstraint = imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
        imageWidthConstraint.priority = .init(999)
        imageWidthConstraint.isActive = true
        let imageHeightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        imageHeightConstraint.priority = .init(999)
        imageHeightConstraint.isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        

        secondaryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

