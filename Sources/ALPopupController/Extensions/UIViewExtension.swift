

import UIKit

extension UIView {
    func makeRoundCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat, superelliptic: Bool = false) {
        if superelliptic {
            let maskPath = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            layer.mask = shape
        } else {
            layer.cornerRadius = radius
            layer.masksToBounds = true
        }
    }
}
