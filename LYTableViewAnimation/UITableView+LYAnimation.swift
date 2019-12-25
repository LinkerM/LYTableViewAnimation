//
//  LYAnimation.swift
//  LYTableViewAnimation
//
//  Created by Joint on 2019/12/19.
//  Copyright © 2019 Joint. All rights reserved.
//

import Foundation
import UIKit

enum LYTableViewAnimationType: Int{
    case LYTableViewAnimationTypeMove = 0
    case LYTableViewAnimationTypeMoveSpring
    case LYTableViewAnimationTypeAlpha
    case LYTableViewAnimationTypeFall
    case LYTableViewAnimationTypeShake
    case LYTableViewAnimationTypeOverTurn
    case LYTableViewAnimationTypeToTop
    case LYTableViewAnimationTypeSpringList
    case LYTableViewAnimationTypeShrinkToTop
    case LYTableViewAnimationTypeRote
}
extension UITableView {
    
    func ly_cellAnimationWithType(animate: LYTableViewAnimationType)
    {
        switch animate{
        case .LYTableViewAnimationTypeMove:
            self.ly_moveAnimation()
            
        case .LYTableViewAnimationTypeMoveSpring:
            self.ly_moveSpringAnimation()
            
        case .LYTableViewAnimationTypeAlpha:
            self.ly_alphaAnimation()
           
        case .LYTableViewAnimationTypeFall:
            self.ly_fallAnimation()
        
        case .LYTableViewAnimationTypeShake:
            self.ly_shakeAnimation()
        
        case .LYTableViewAnimationTypeOverTurn:
            self.ly_overTurnAnimation()
            
        case .LYTableViewAnimationTypeToTop:
            self.ddy_toTopAnimation()
            
        case .LYTableViewAnimationTypeSpringList:
            self.ly_springListAnimation()
            
        case .LYTableViewAnimationTypeShrinkToTop:
            self.ly_shrinkToTopAnimation()
            
        case .LYTableViewAnimationTypeRote:
            self.ly_roteAnimation()
            
        default: break
            
        }
    }
    
    private func ly_moveAnimation()
    {
        let totalTime = 0.3
        let toTime = totalTime / Double(self.visibleCells.count)
        let timeInterval = TimeInterval(toTime)
        
        for (index, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            cell.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
            /// withDuration 动画执行时间
            /// delay 动画延迟执行时间
            /// options 运动动画速度曲线
            /// animations 执行动画的函数
            /// completion 动画完成时执行的回调，可选性，可以为 nil
            UIView.animateKeyframes(withDuration: 0.25, delay: timeInterval * Double(index), options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    
    private func ly_moveSpringAnimation()
    {
        let totalTime = 0.4
        let timeInterval = TimeInterval(totalTime / Double(self.visibleCells.count))
        for (index, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            cell.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
            /// usingSpringWithDamping 弹簧阻力，取值范围为0.0-1.0，数值越小“弹簧”振动效果越明显。
            /// initialSpringVelocity 动画初始的速度（pt/s），数值越大初始速度越快。但要注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
            UIView.animate(withDuration: 0.4, delay: timeInterval * Double(index) , usingSpringWithDamping: 0.5, initialSpringVelocity: 1/0.5, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    
    private func ly_alphaAnimation()
    {
        let timeInterval = 0.05
        for (index, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            cell.alpha = 0.0
            UIView.animate(withDuration: 0.3, delay: Double(index) * timeInterval, options:[], animations: {
                cell.alpha = 1.0
            }, completion: nil)
        }
    }
    
    private func ly_fallAnimation()
    {
        let totalTime = 0.8
        let timeInterval = TimeInterval(totalTime / Double(self.visibleCells.count))
        for (index, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            cell.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
            UIView.animate(withDuration: 0.3, delay: Double(self.visibleCells.count - index) * timeInterval, options:[], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    
    private func ly_shakeAnimation()
    {
        let timeInterval = 0.05
        for (index, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            cell.transform = CGAffineTransform(translationX: (index%2==0) ? (-UIScreen.main.bounds.width): UIScreen.main.bounds.width, y: 0)
            UIView.animate(withDuration: 0.4, delay: timeInterval * Double(index) , usingSpringWithDamping: 0.8, initialSpringVelocity: 1/0.8, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    
    private func ly_overTurnAnimation()
    {
        let totalTime = 0.7
        let timeInterval = TimeInterval(totalTime / Double(self.visibleCells.count))
        for (index, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            cell.layer.opacity = 0.0
            let rotateTransform = CATransform3DMakeRotation(CGFloat(M_PI), 1, 0, 0)
            cell.layer.transform = CATransform3DConcat(self.layer.transform, CATransform3DInvert(rotateTransform))
             UIView.animate(withDuration: 0.3, delay: Double(index) * timeInterval, options:[], animations: {
                cell.layer.opacity = 1.0
                cell.layer.transform = CATransform3DIdentity
             }, completion: nil)
        }
    }
    
    private func ddy_toTopAnimation()
    {
        let totalTime = 0.8
        let timeInterval = TimeInterval(totalTime / Double(self.visibleCells.count))
        for (index, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            cell.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            UIView.animate(withDuration: 0.4, delay: Double(index) * timeInterval, options:UIView.AnimationOptions(rawValue: 2), animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    
    private func ly_springListAnimation()
    {
        let totalTime = 1.0
        let timeInterval = TimeInterval(totalTime / Double(self.visibleCells.count))
        for (index, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            cell.layer.opacity = 0.7
            cell.layer.transform = CATransform3DTranslate(self.layer.transform, 0, -UIScreen.main.bounds.height, 20)
            UIView.animate(withDuration: 0.4, delay: timeInterval * Double(index) , usingSpringWithDamping: 0.7, initialSpringVelocity: 1/0.7, options: [], animations: {
                cell.layer.opacity = 1.0
                cell.layer.transform = CATransform3DTranslate(self.layer.transform, 0, 0, 20)
             }, completion: nil)
            
        }
    }
 
    private func ly_shrinkToTopAnimation()
    {
        for (_, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            let rect = cell.convert(cell.bounds, from: self)
            cell.transform = CGAffineTransform(translationX: 0, y: -rect.origin.y)
            UIView.animate(withDuration: 0.6) {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
    }
    
    private func ly_roteAnimation()
    {
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.fromValue = Double.pi
        animation.toValue = 0
        animation.duration = 0.3
        animation.isRemovedOnCompletion = false
        animation.repeatCount = 3
        animation.fillMode = .forwards
        animation.autoreverses = false
        
        for (index, value) in self.visibleCells.enumerated(){
            let cell:UITableViewCell = value
            cell.alpha = 0.0
            
            UIView.animate(withDuration: 0.1, delay: Double(index) * 0.25, options:[], animations: {
                cell.alpha = 1.0
            }) { (_) in
                cell.layer.add(animation, forKey: "rotationYkey")
            }
        }
    }
}
