//
//  PushAnimation.swift
//  LXJieMeng
//
//  Created by John LXThyme on 2017/4/17.
//  Copyright © 2017年 John LXThyme. All rights reserved.
//

import UIKit

class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    var _transitionContext: UIViewControllerContextTransitioning?
}
extension PushAnimation {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        _transitionContext = transitionContext

        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!// as! LXMengSecondCategoryVC

        let containerView = transitionContext.containerView

        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view)

        let parentView = NSKeyedUnarchiver.unarchiveObject(with: UserDefaults.standard.value(forKey: UserDefaultsKey.parentView.rawValue) as! Data) as! CGRect

        var realRect = parentView
        let min = realRect.size.width > realRect.size.height ? realRect.size.height: realRect.size.width
        let halfMin = min / 2.0
        realRect = CGRect(x: realRect.midX - halfMin, y: realRect.midY - halfMin, width: min, height: min)
        let radius = sqrt(realRect.origin.x * realRect.origin.x + realRect.origin.y * realRect.origin.y)
        let finalRect = realRect.insetBy(dx: -radius, dy: -radius)
        let maskStartBP = UIBezierPath(ovalIn: realRect)
        let maskFinalBP = UIBezierPath(ovalIn: finalRect)
        //创建一个 CAShapeLayer 来负责展示圆形遮罩
        let maskLayer = CAShapeLayer()
        //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
//        maskLayer.path = maskStartBP.cgPath
        maskLayer.path = maskFinalBP.cgPath
        toVC.view.layer.mask = maskLayer

        let keyPath = "path"
        let maskAnimation = CABasicAnimation(keyPath: keyPath)
        maskAnimation.fromValue = maskStartBP.cgPath
        maskAnimation.toValue = maskFinalBP.cgPath
        maskAnimation.duration = self.transitionDuration(using: transitionContext)
        maskAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        maskAnimation.delegate = self

        maskLayer.add(maskAnimation, forKey: keyPath)

//        DispatchQueue.main.async {
//            toVC.view.layer.contentsCenter = maskLayer.presentation()!.contentsCenter
//            toVC.view.layer.removeAllAnimations()
//        }
    }
}
// MARK: - CAAnimationDelegate
extension PushAnimation {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        _transitionContext?.completeTransition(true)

        let fromVC = _transitionContext?.viewController(forKey: .from)!
        let toVC = _transitionContext?.viewController(forKey: .to)!
        fromVC?.view.layer.mask = nil
        toVC?.view.layer.mask = nil
    }
}
