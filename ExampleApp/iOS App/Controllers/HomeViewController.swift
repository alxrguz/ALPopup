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
import SparrowKit
import ALDevKit
import ALPopup

final class HomeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var settingsButton = UIBarButtonItem(image: .init(systemName: "gear"), style: .plain, target: self, action: #selector(presentSettings))
    private lazy var segmentControl = UISegmentedControl()
    private lazy var navigationView = ALFakeNavigationView()
    private lazy var tableView = ALFakeTableView()
    
    // MARK: - Private Proporties
    
    private var isEnableCloseButton = true
    private var dismissByTapAround = true
    private var allowsSwipeInteraction = true
    private var controllerStyle: ControllerStyle = .card
    
    // MARK: - Life cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupActions()
    }
}

// MARK: - Handlers

private extension HomeViewController {
    @objc func segmentChanged() {
        guard let style = ControllerStyle(rawValue: segmentControl.selectedSegmentIndex) else { return }
        UIFeedbackGenerator.impactOccurred(.selectionChanged)
        controllerStyle = style
    }
}


// MARK: - Private Methods

private extension HomeViewController {
    func setupActions() {
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    func configureALPopup(_ controller: ALBaseOverlayController) {
        controller.isEnableCloseButton = isEnableCloseButton
        controller.dismissByTapAround = dismissByTapAround
        controller.allowsSwipeInteraction = allowsSwipeInteraction
    }
}

// MARK: - Navigation

private extension HomeViewController {
    func showTemplate() {
        let vc: ALBaseOverlayController
        
        switch controllerStyle {
            case .popup:
                let popupVC = ALPopup.popup(template: .init(
                                        title: "Wi-Fi Password",
                                        subtitle: "Share the Wi-Fi password?\n(Template controller Example)",
                                        image: UIImage(systemName: "wifi"),
                                        privaryButtonTitle: "Share Password",
                                        secondaryButtonTitle: "Not Now")
                )
                
                popupVC.tempateView.do {
                    $0.primaryButton.applyDefaultAppearance(with: .init(content: .systemBlue, background: .systemGroupedBackground))
                    $0.secondaryButton.applyDefaultAppearance(with: .init(content: .systemGray2, background: .clear))
                    $0.imageView.tintColor = .secondarySystemFill
                    $0.primaryButtonAction = {
                        popupVC.pop()
                    }
                    $0.secondaryButtonAction = {
                        popupVC.pop()
                    }
                }
                
                vc = popupVC
            case .card:
                let cardVC = ALPopup.card(template: .init(
                                            title: "Wi-Fi Password",
                                            subtitle: "Do u want to share the Wi-Fi password?\n(Template controller Example)",
                                            image: UIImage(systemName: "wifi"),
                                            privaryButtonTitle: "Share Password",
                                            secondaryButtonTitle: nil)
                )
                
                cardVC.tempateView.do {
                    $0.primaryButton.applyDefaultAppearance(with: .init(content: .systemBlue, background: .systemGroupedBackground))
                    $0.imageView.tintColor = .secondarySystemFill
                    $0.primaryButtonAction = {
                        cardVC.pop()
                    }
                    $0.secondaryButtonAction = {
                        cardVC.pop()
                    }
                }
                
                vc = cardVC
        }
        
        configureALPopup(vc)
        vc.push(from: self)
    }
    
    func showBaseController() {
        let vc: ALBaseOverlayController
        let baseViewController = BaseViewController()
        
        switch controllerStyle {
            case .popup:
                let popupVC = ALPopup.popup(controller: baseViewController)
                vc = popupVC
            case .card:
                let cardVC = ALPopup.card(controller: baseViewController)
                vc = cardVC
        }
        
        baseViewController.needCloseController = { vc.pop() }
        
        configureALPopup(vc)
        vc.push(from: self)
    }
    
    func showNavigationController() {
        let vc: ALBaseOverlayController
        let navVC = UINavigationController(rootViewController: TableViewController())
        navVC.view.snp.makeConstraints {
            $0.height.equalTo(380)
        }
        
        switch controllerStyle {
            case .popup:
                let popupVC = ALPopup.popup(controller: navVC)
                vc = popupVC
            case .card:
                let cardVC = ALPopup.card(controller: navVC)
                vc = cardVC
        }
        
        configureALPopup(vc)
        vc.push(from: self)
    }
    
    func showInheritedController() {
        let vc: ALBaseOverlayController
        
        switch controllerStyle {
            case .popup:
                vc = InheritedFromPopupController()
            case .card:
                vc = InheritedFromCardController()
        }
        configureALPopup(vc)
        vc.push(from: self)
    }
    
    func showHorizontalScrrolledController() {
        let vc: ALBaseOverlayController
        
        switch controllerStyle {
            case .popup:
                vc = ALPopup.popup(controller: HorizontallScrollController())
            case .card:
                vc = ALPopup.card(controller: HorizontallScrollController())
        }
        configureALPopup(vc)
        vc.push(from: self)
    }
    
    func showMixedScrrolledController() {
        let vc: ALBaseOverlayController
        
        switch controllerStyle {
            case .popup:
                vc = ALPopup.popup(controller: MixedScrollViewController())
            case .card:
                vc = ALPopup.card(controller: MixedScrollViewController())
        }
        configureALPopup(vc)
        vc.push(from: self)
    }
    
    @objc func presentSettings() {
        let vc = SettingsViewController(
            isEnableCloseButton: isEnableCloseButton,
            dismissByTapAround: dismissByTapAround,
            allowsSwipeInteraction: allowsSwipeInteraction)
        
        vc.allowsSwipeInteractionChanged = { [weak self] value in
            self?.allowsSwipeInteraction = value
        }
        
        vc.isEnableCloseButtonChanged = { [weak self] value in
            self?.isEnableCloseButton = value
        }
        
        vc.dismissByTapAroundChanged = { [weak self] value in
            self?.dismissByTapAround = value
        }
        
        let cardVC = ALPopup.card(controller: vc)
        
        cardVC.push(from: self)
    }
}

// MARK: - Layout Setup
private extension HomeViewController {
    func setupColors() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    func setupView() {
        setupColors()
        
        navigationController?.navigationBar.do {
            $0.makeTransparent()
        }
        
        navigationItem.do {
            $0.title = "ALPopupController"
            $0.rightBarButtonItem = settingsButton
        }
        
        segmentControl.do { segment in
            ControllerStyle.allCases.forEach {
                segment.insertSegment(withTitle: $0.title, at: $0.rawValue, animated: false)
            }
            segment.selectedSegmentIndex = controllerStyle.rawValue
        }
        
        let templateSetction = ALFakeTableSection().do {
            $0.title = "Template".uppercased()
            $0.footer = "The controller is already contained in the library, you only need to configure the content"
            let cell = ALFakeCell().do {
                $0.titleLabel.text = "Show template"
                $0.titleLabel.textColor = .systemBlue
                $0.tapped = { [weak self] _ in self?.showTemplate() }
            }
            $0.addCell(cell)
        }
        
        let viewControllerSection = ALFakeTableSection().do {
            $0.title = "View Controller".uppercased()
            $0.footer = "Show any of your controller. Everything happens automatically, you only need to specify your controller"
            //
            let cell = ALFakeCell().do {
                $0.titleLabel.text = "Show View Controller"
                $0.titleLabel.textColor = .systemBlue
                $0.tapped = { [weak self] _ in self?.showBaseController() }
            }
            $0.addCell(cell)
        }
        
        let navigationControllerSection = ALFakeTableSection().do {
            $0.title = "Navigation Controller".uppercased()
            $0.footer = "Show any of your Navigation controller. Be careful not to forget to specify the height of the controller"
            let cell = ALFakeCell().do {
                $0.titleLabel.text = "Show Navigation Controller"
                $0.titleLabel.textColor = .systemBlue
                $0.tapped = { [weak self] _ in self?.showNavigationController() }
            }
            $0.addCell(cell)
        }
        
        let inheritedControllerSection = ALFakeTableSection().do {
            $0.title = "Inherited Controller".uppercased()
            $0.footer = "In this example, you yourself inherit from the desired controller and manage it."
            let cell = ALFakeCell().do {
                $0.titleLabel.text = "Show Inherited Controller"
                $0.titleLabel.textColor = .systemBlue
                $0.tapped = { [weak self] _ in self?.showInheritedController() }
            }
            $0.addCell(cell)
        }
        
        let scrolledControllerSection = ALFakeTableSection().do {
            $0.title = "Scrolled Controller".uppercased()
            $0.footer = "This section is only for performing tests with scrollViews"
            let cell = ALFakeCell().do {
                $0.titleLabel.text = "Show Horizontal Scroll"
                $0.titleLabel.textColor = .systemBlue
                $0.tapped = { [weak self] _ in self?.showHorizontalScrrolledController() }
            }
            
            let cell1 = ALFakeCell().do {
                $0.titleLabel.text = "Show Mexid Scroll"
                $0.titleLabel.textColor = .systemBlue
                $0.tapped = { [weak self] _ in self?.showMixedScrrolledController() }
            }
            $0.addCells([cell, cell1])
        }
        
        tableView.do {
            $0.scrollView.contentInset = .init(top: 75, left: 0, bottom: 0, right: 0)
            $0.sectionsStack.spacing = 35
            $0.addSections([templateSetction, viewControllerSection, navigationControllerSection, inheritedControllerSection])
        }
    }
    
    func setupConstraints() {
        view.addSubviews([tableView, navigationView, segmentControl])
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(segmentControl).offset(10)
        }
        
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(5)
            $0.leading.trailing.equalTo(safeArea).inset(16)
        }
    }
}


// MARK: - Data Structures

extension HomeViewController {
    enum ControllerStyle: Int, CaseIterable {
        case card, popup
        
        var title: String {
            switch self {
                case .card: return "Card"
                case .popup: return "Popup"
            }
        }
    }
}
