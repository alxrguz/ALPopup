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

