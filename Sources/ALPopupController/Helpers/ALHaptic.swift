

import UIKit

/**
 Wrapper of haptic styles.
 */
public enum ALHaptic {
    
    case success
    case warning
    case error
    case none
    
    func impact() {
        let generator = UINotificationFeedbackGenerator()
        switch self {
        case .success:
            generator.notificationOccurred(.success)
        case .warning:
            generator.notificationOccurred(.warning)
        case .error:
            generator.notificationOccurred(.error)
        case .none:
            break
        }
    }
}
