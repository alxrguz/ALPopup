//
//  Source.swift
//  
//
//  Created by Alexandr Guzenko on 27.12.2020.
//

import UIKit


enum Source {
    enum Color {
        static var contentColor: UIColor {
            .init(light: .init(hex: "fff"), dark: .init(hex: "1C1C1E"))
        }
        
        static var accent: UIColor {
            .init(hex: "237EF0")
        }
        
        static var overlayAccentColor: UIColor {
            .init(hex: "fff")
        }
        
        static var labelPrimary: UIColor {
            .init(light: .init(hex: "000"), dark: .init(hex: "fff"))
        }
        
        static var labelSecondary: UIColor {
            .init(light: .init(hex: "#3C3C43", alpha: 0.6), dark: .init(hex: "#EBEBF5", alpha: 0.6))
        }
    }
    
    enum Image {
        static var smallCloseButton: UIImage? {
            UIImage(named: "smallCloseButton", in: Bundle.module, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        }
    }
}
