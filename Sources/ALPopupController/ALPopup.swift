//
//  File.swift
//  
//
//  Created by Alexandr Guzenko on 28.12.2020.
//

import UIKit

public enum ALPopup {
    private static var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public static func card(template: ALTemplateSettings) -> ALCardTemplateController {
        let vc = ALCardTemplateController()
        vc.tempateView.configuration = template
        return vc
    }
    
    public static func card(controller: UIViewController) -> ALCardController {
        let vc = ALCardController()
        vc.addChild(controller)
        vc.contentView.addSubview(controller.view)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: vc.contentView.topAnchor).isActive = true
        controller.view.leftAnchor.constraint(equalTo: vc.contentView.leftAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: vc.contentView.bottomAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: vc.contentView.rightAnchor).isActive = true
        
        controller.didMove(toParent: vc)
        
        if controller is UINavigationController {
            let offset: CGFloat = isPhone ? 12 : 8
            controller.additionalSafeAreaInsets = .init(top: offset, left: 0, bottom: 0, right: 0)
        }
        
        return vc
    }
    
    public static func popup(template: ALTemplateSettings) -> ALPopupTemplateController {
        let vc = ALPopupTemplateController()
        vc.tempateView.configuration = template
        return vc
    }
    
    public static func popup(controller: UIViewController) -> ALPopupController {
        let vc = ALPopupController()
        vc.addChild(controller)
        vc.contentView.addSubview(controller.view)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: vc.contentView.topAnchor).isActive = true
        controller.view.leftAnchor.constraint(equalTo: vc.contentView.leftAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: vc.contentView.bottomAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: vc.contentView.rightAnchor).isActive = true
        
        controller.didMove(toParent: vc)
        
        if controller is UINavigationController {
            let offset: CGFloat = isPhone ? 12 : 8
            controller.additionalSafeAreaInsets = .init(top: offset, left: 0, bottom: 0, right: 0)
        }
        
        return vc
    }
}

