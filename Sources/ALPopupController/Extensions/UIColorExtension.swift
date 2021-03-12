//
//  File.swift
//  
//
//  Created by Alexandr Guzenko on 27.12.2020.
//

import UIKit


extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
    
    convenience init(baseInterfaceLevel: UIColor, elevatedInterfaceLevel: UIColor ) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init { traitCollection in
                switch traitCollection.userInterfaceLevel {
                case .base:
                    return baseInterfaceLevel
                case .elevated:
                    return elevatedInterfaceLevel
                case .unspecified:
                    return baseInterfaceLevel
                @unknown default:
                    return baseInterfaceLevel
                }
            }
        }
        else {
            self.init(cgColor: baseInterfaceLevel.cgColor)
        }
    }
    
    convenience init(hex: String) {
        let hex = UIColor.parseHex(hex: hex, alpha: nil)
        self.init(red: hex.red, green: hex.green, blue: hex.blue, alpha: hex.alpha)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        let hex = UIColor.parseHex(hex: hex, alpha: alpha)
        self.init(red: hex.red, green: hex.green, blue: hex.blue, alpha: hex.alpha)
    }
    
    func alpha(_ alpha: CGFloat) -> UIColor {
        self.withAlphaComponent(alpha)
    }
    
    private static func parseHex(hex: String, alpha: CGFloat?) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var newAlpha: CGFloat = alpha ?? 1.0
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                if alpha == nil {
                    newAlpha = CGFloat(hexValue & 0x000F)      / 15.0
                }
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                if alpha == nil {
                    newAlpha = CGFloat(hexValue & 0x000000FF)  / 255.0
                }
            default:
                print("UIColorExtension - Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
            }
        } else {
            print("UIColorExtension - Scan hex error")
        }
        return (red, green, blue, newAlpha)
    }
}

