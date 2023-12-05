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

enum ALAnimate {
    static func spring(time: TimeInterval, delay: TimeInterval = 0, damping: CGFloat = 0.8, velocity: CGFloat = 0.3, animate: @escaping() -> Void, completion: @escaping () -> Void) {
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
    
    static func spring(time: TimeInterval, delay: TimeInterval = 0, damping: CGFloat = 0.8, velocity: CGFloat = 0.3, animate: @escaping() -> Void) {
        UIView.animate(withDuration: time,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: [.curveEaseInOut,
                                    .allowUserInteraction,
                                    .preferredFramesPerSecond60],
                       animations: {
                        animate()
        }, completion: { _ in })
    }
    
    static func base(time: TimeInterval, delay: TimeInterval = 0 , animate: @escaping() -> Void, completion: @escaping () -> Void) {
        UIView.animate(withDuration: time,
                       delay: delay,
                       animations: {
                        animate()
        }, completion: { _ in
            completion()
        })
    }
    
    static func base(time: TimeInterval, delay: TimeInterval = 0 , animate: @escaping() -> Void) {
        UIView.animate(withDuration: time,
                       delay: delay,
                       animations: {
                        animate()
        }, completion: { _ in })
    }
    
    static func transition(with view: UIView, time: TimeInterval, options: UIView.AnimationOptions = .transitionCrossDissolve, animate: @escaping() -> Void) {
        UIView.transition(with: view, duration: time, options: options) {
            animate()
        } completion: { _ in }
    }
    
    static func transition(with view: UIView, time: TimeInterval, options: UIView.AnimationOptions = .transitionCrossDissolve, animate: @escaping() -> Void, completion: @escaping () -> Void) {
        UIView.transition(with: view, duration: time, options: options) {
            animate()
        } completion: { _ in  completion() }
    }
}

