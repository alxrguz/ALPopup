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

/**
 The structure of the template controller.
 
 If any of the parameters is not specified in the initializer, then it will not be added to the controller.
*/
public struct ALTemplateSettings {
    /// Title for `ALTemplateView.titleLabel`
    public let title: String?
    
    /// Subtitle for `ALTemplateView.subtitleLabel`
    public let subtitle: String?
    
    /// Image for `ALTemplateView.imageView`
    public let image: UIImage?
    
    /// Button title for `ALTemplateView.primaryButton`
    public let primaryButtonTitle: String?
    
    /// Button title for `ALTemplateView.secondaryButton`
    public let secondaryButtonTitle: String?
    
    public init(title: String?, subtitle: String?, image: UIImage? = nil, privaryButtonTitle: String? = nil, secondaryButtonTitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.primaryButtonTitle = privaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
    }
}
