//
//  ALAnimate.swift
//  ALDevKit
//
//  Created by Alexandr Guzenko on 18.05.2020.
//  Copyright © 2020 Alexandr Guzenko. All rights reserved.
//

import UIKit

enum ALAnimate {
    public static func spring(time: TimeInterval, delay: TimeInterval = 0, damping: CGFloat = 0.8, velocity: CGFloat = 0.3, animate: @escaping() -> Void, completion: @escaping () -> Void) {
        UIView.animate(withDuration: time,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                        animate()
        }, completion: { _ in
            completion()
        })
    }
    
    public static func spring(time: TimeInterval, delay: TimeInterval = 0, damping: CGFloat = 0.8, velocity: CGFloat = 0.3, animate: @escaping() -> Void) {
        UIView.animate(withDuration: time,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                        animate()
        }, completion: { _ in })
    }
    
    public static func base(time: TimeInterval, delay: TimeInterval = 0 , animate: @escaping() -> Void, completion: @escaping () -> Void) {
        UIView.animate(withDuration: time,
                       delay: delay,
                       animations: {
                        animate()
        }, completion: { _ in
            completion()
        })
    }
    
    public static func base(time: TimeInterval, delay: TimeInterval = 0 , animate: @escaping() -> Void) {
        UIView.animate(withDuration: time,
                       delay: delay,
                       animations: {
                        animate()
        }, completion: { _ in })
    }
    
    public static func transition(with view: UIView, time: TimeInterval, options: UIView.AnimationOptions = .transitionCrossDissolve, animate: @escaping() -> Void) {
        UIView.transition(with: view, duration: time, options: options) {
            animate()
        } completion: { _ in }
    }
    
    public static func transition(with view: UIView, time: TimeInterval, options: UIView.AnimationOptions = .transitionCrossDissolve, animate: @escaping() -> Void, completion: @escaping () -> Void) {
        UIView.transition(with: view, duration: time, options: options) {
            animate()
        } completion: { _ in  completion() }
    }
}

