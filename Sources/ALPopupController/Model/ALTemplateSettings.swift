
import UIKit

public struct ALTemplateSettings {
    public let title: String?
    public let subtitle: String?
    public let image: UIImage?
    public let primaryButtonTitle: String?
    public let secondaryButtonTitle: String?
    
    public init(title: String?, subtitle: String?, image: UIImage? = nil, privaryButtonTitle: String? = nil, secondaryButtonTitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.primaryButtonTitle = privaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
    }
}
