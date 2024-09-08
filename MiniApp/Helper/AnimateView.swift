//
//  AnimateView.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 07.09.2024.
//

import UIKit

class AnimateView {
    func animatioinsImageProfuct(imageView: UIView, widthAnchor: CGFloat, heightAnchor: CGFloat) {
        UIView.animate(withDuration: 0.4, animations: {
            NSLayoutConstraint.deactivate(imageView.constraints.filter { $0.firstAttribute == .width || $0.firstAttribute == .height })
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: widthAnchor),
                imageView.heightAnchor.constraint(equalToConstant: heightAnchor)
            ])
            imageView.superview?.layoutIfNeeded()
        })
        imageView.superview?.layoutIfNeeded()
    }
    
    func animateViewAppearance(_ views: UIView...) {
        views.forEach { $0.alpha = 0 }
        UIView.animate(withDuration: 0.8) {
            views.forEach { $0.alpha = 1 }
        }
    }
    
    func animateViewDisappearance(_ views: UIView..., completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.8, animations: {
            views.forEach { $0.alpha = 0 }
        }) { _ in
            completion()
        }
    }
}

