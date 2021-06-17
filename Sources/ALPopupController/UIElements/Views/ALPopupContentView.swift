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

public class ALPopupContentView: UIView {
    
    // MARK: - Open Proporties
    
    /// Rounding corners in superellipse. Gives nicer and more correct rounding, but does not work well with frame animations. Default is `true`
    public var superellipticRounding: Bool = true {
        didSet {
            layoutSubviews()
        }
    }
    
    // MARK: - Internal Proporties
    
    internal var cornerRadius: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        backgroundColor = Source.Color.contentColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        makeRoundCorners(radius: cornerRadius, superelliptic: superellipticRounding)
    }
}
