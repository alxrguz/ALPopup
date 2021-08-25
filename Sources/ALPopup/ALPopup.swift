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

public class ALPopup {
    
    // MARK:  Private Proporties
    
    private static var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    // MARK:  Open Methods
    
    /**
     Returns a controller that is presented as a card (AirPods style). On iPhone, it will appear at the bottom of the screen, and on iPad - centered.
     
     See the description for the `ALTemplateSettings` properties for a better understanding.
     
     **Example:**
     ```
     let template = ALTemplateSettings(
         title: "Privacy Policy",
         subtitle: "Subtitle",
         privaryButtonTitle: "Agree & Continue"
     )
     let cardVC = ALPopup.card(template: template)
     cardVC.push(from: self)
     ```
     - Parameter template: Structure describing the template for the controller. If 1 or several properties of the structure are not specified, then no UI will be created for it.
     */
    public static func card(template: ALTemplateSettings) -> ALCardTemplateController {
        let vc = ALCardTemplateController()
        vc.tempateView.configuration = template
        return vc
    }
    
    /**
     Returns a controller that is presented as a card (AirPods style). On iPhone, it will appear at the bottom of the screen, and on iPad - centered.
     
     For the UIViewController classes, the height is calculated automatically if the content has a height, the first element is nailed to the top border of the controller, and the last to the bottom (except for elements inherited from UIScrollViews)

     In other cases (UINavigationController, UITabBarController, etc.) you need to explicitly specify the height for the view controller.
     
     **Example:**
     ```
     let myNavigationVC = UINavigationController(rootViewController: UIViewController())
     myNavigationVC.view.translatesAutoresizingMaskIntoConstraints = false
     myNavigationVC.view.heightAnchor.constraint(equalToConstant: 500).isActive = true
     let cardVC = ALPopup.card(controller: myNavigationVC)
     cardVC.push(from: self)
     ```
     
     - Parameter controller: Your controller that you want to wrap in ALCardController
     */
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
    
    /**
     Returns a controller that is presented as a popup or window (like UIAlertView). Displayed in the center of the screen.
     
     See the description for the `ALTemplateSettings` properties for a better understanding.

     **Example:**
     ```
     let template = ALTemplateSettings(
         title: "Privacy Policy",
         subtitle: "Subtitle",
         privaryButtonTitle: "Agree & Continue"
     )
     let popupVC = ALPopup.popup(template: template)
     popupVC.push(from: self)
     ```
     - Parameter template: Structure describing the template for the controller. If 1 or several properties of the structure are not specified, then no UI will be created for it.
     */
    public static func popup(template: ALTemplateSettings) -> ALPopupTemplateController {
        let vc = ALPopupTemplateController()
        vc.tempateView.configuration = template
        return vc
    }
    
    /**
     Returns a controller that is presented as a popup or window (like UIAlertView). Displayed in the center of the screen.
     
     For the UIViewController classes, the height is calculated automatically if the content has a height, the first element is nailed to the top border of the controller, and the last to the bottom (except for elements inherited from UIScrollViews)

     In other cases (UINavigationController, UITabBarController, etc.) you need to explicitly specify the height for the view controller.
     
     **Example:**
     ```
     let myNavigationVC = UINavigationController(rootViewController: UIViewController())
     myNavigationVC.view.translatesAutoresizingMaskIntoConstraints = false
     myNavigationVC.view.heightAnchor.constraint(equalToConstant: 500).isActive = true
     let popupVC = ALPopup.popup(controller: myNavigationVC)
     popupVC.push(from: self)
     ```
     
     - Parameter controller: Your controller that you want to wrap in ALCardController
     */
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
    
    // MARK: - Life cycle
    
    private init() {}
}

