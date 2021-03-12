//
//  File.swift
//  
//
//  Created by Alexandr Guzenko on 28.12.2020.
//

import UIKit

public enum ALPopup {
    public static func card(title: String, subtitle: String? = nil, image: UIImage? = nil) -> ALCardTemplateController {
        let vc = ALCardTemplateController()
        vc.titleLabel.text = title
        vc.subtitleLabel.text = subtitle
        vc.imageView.image = image
        return vc
    }
}

