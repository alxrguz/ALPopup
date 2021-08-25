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


enum Source {
    static var bundle: Bundle {
        
        // If installed via SPM, will be available bundle .module.
        
        #if ALPOPUP_SPM
        return .module
        #else
        
        // If installed via Cocoapods, should use bundle from podspec.
        
        let path = Bundle(for: SPConfetti.self).path(forResource: "ALPopup", ofType: "bundle") ?? ""
        let bundle = Bundle(path: path) ?? Bundle.main
        return bundle
        #endif
    }
    
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
            UIImage(named: "smallCloseButton", in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        }
    }
}
