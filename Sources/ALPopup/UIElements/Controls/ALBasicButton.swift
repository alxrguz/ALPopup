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

open class ALBasicButton: UIButton {
    
    // MARK: - Ovveride
    
    open override var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    open override func tintColorDidChange() {
        super.tintColorDidChange()
        updateAppearance()
    }
    
    // MARK: - Colorises Process
    
    /**
      This method sets the color scheme for a specific button state
     */
    open func setColorise(_ colorise: Colorise, for state: AppearanceState) {
        switch state {
        case .default:
            defaultColorise = colorise
        case .dimmed:
            dimmedColorise = colorise
        case .disabled:
            disabledColorise = colorise
        }
        updateAppearance()
    }
    
    /**
      Get colorise for specific state.
     */
    open func getColorise(for state: AppearanceState) -> Colorise {
        switch state {
        case .default:
            return defaultColorise
        case .dimmed:
            return dimmedColorise
        case .disabled:
            return disabledColorise
        }
    }
    
    /**
      Set the color scheme for the default state.
     `.dimmed` and `.disabled` states calculate automaticaly.
     */
    open func applyDefaultAppearance(with colorise: Colorise? = nil) {
        defaultColorise = colorise ?? Colorise(content: .tint, background: .custom(.clear))
        let defaultBackgroundColor = colorFromColoriseMode(defaultColorise.background)
        let dimmedBackground = defaultBackgroundColor == .clear ? .clear : dimmedContentColor.alpha(0.1)
        dimmedColorise = Colorise(content: dimmedContentColor, background: dimmedBackground)
        disabledColorise = Colorise(content: dimmedContentColor, background: dimmedBackground)
        updateAppearance()
    }
    
    /**
      Update colors for current state.
     */
    private func updateAppearance() {
        if tintAdjustmentMode == .dimmed {
            applyColorise(dimmedColorise)
        } else if isEnabled {
            applyColorise(defaultColorise)
            var imageTintColor = colorFromColoriseMode(defaultColorise.icon)
            imageTintColor = imageTintColor.withAlphaComponent(isHighlighted ? highlightOpacity : 1)
            imageView?.tintColor = imageTintColor
        } else {
            applyColorise(disabledColorise)
        }
    }
    
    /**
      Apply colors from special colorise.
     */
    private func applyColorise(_ colorise: Colorise) {
        let titleColor = colorFromColoriseMode(colorise.title)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor.withAlphaComponent(highlightOpacity), for: .highlighted)
        imageView?.tintColor = colorFromColoriseMode(colorise.icon)
        backgroundColor = colorFromColoriseMode(colorise.background)
    }
    
    /**
    Get valid color by `Colorise.Mode` for this button.
     
     For example each call can return diffrent color for if changing tint.
     If mode in custom always return this value.
     
     - parameter mode: Colorise mode from which need get color.
     */
    public func colorFromColoriseMode(_ mode: Colorise.Mode) -> UIColor {
        switch mode {
        case .tint: return self.tintColor
        case .custom(let color): return color
        }
    }
    
    // MARK: - Colorises Models
    
    /**
    Colorise for default state.
     */
    private lazy var defaultColorise = Colorise(content: tintColor, background: .clear)
    
    /**
    Colorise for disabled state.
     */
    private lazy var disabledColorise = Colorise(content: dimmedContentColor, background: .clear)
    
    /**
    Colorise for dimmed mode.
     */
    private lazy var dimmedColorise = Colorise(content: dimmedContentColor, background: .clear)
    
    // MARK: - Data
    
    /**
    Opacity of elements when button higlight.
     */
    open var highlightOpacity: CGFloat = 0.7
    
    /**
     Default dimmed content color with compability iOS 12.
     */
    private var dimmedContentColor: UIColor {
        if #available(iOS 13, tvOS 13, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor(hex: "3c3c4399")
        }
    }
    
    // MARK: - Models
    
    /**
    Represent colors for state of button for elements.
     */
    public struct Colorise {
        
        public var title: Mode
        public var icon: Mode
        public var background: Mode
        
        /**
        This init allow create colorise with automatically tint oberving.
         
         - parameter content: Colorise mode for `title` & `icon`.
         - parameter background: Colorise mode for background.
         */
        public init(content: Mode, background: Mode) {
            self.title = content
            self.icon = content
            self.background = background
        }
        
        /**
         - parameter content: Color for `title` & `icon`.
         - parameter background: Color for background.
         */
        public init(content: UIColor, background: UIColor) {
            self.title = .custom(content)
            self.icon = .custom(content)
            self.background = .custom(background)
        }
        
        /**
         - parameter content: Color for `title` & `icon`.
         - parameter background: Color for image.
         - parameter background: Color for background.
         */
        public init(content: UIColor, icon: UIColor, background: UIColor) {
            self.title = .custom(content)
            self.icon = .custom(icon)
            self.background = .custom(background)
        }
        
        /**
         Represent of rendering colors in button.
         
         It need for have dynamic tint color and fixed custom.
         */
        public enum Mode {
            
            /**
             Always specoific color.
             */
            case custom(UIColor)
            
            /**
             Observe and apply tint color of button.
             */
            case tint
        }
    }
    
    /**
     Button state.
     */
    public enum AppearanceState {
        
        /**
         The button is in the normal state.
         */
        case `default`
        
        /**
         The button is in a dimmed state, for example when another `UIViewController` is presented.
         */
        case dimmed
        
        /**
         The button is disabled. Controlled through the `isDisabled` property.
         */
        case disabled
    }
}
