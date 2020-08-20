//
//  UIViewControllerExtention.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    enum ChildViewAnimationOption {
        case zoomIn(scaleFactor: CGFloat)
        case zoomOut(scaleFactor: CGFloat)
        
        func animate(_ view: UIView, completion:@escaping () -> Void) {
            switch self {
            case .zoomIn(let scaleFactor):
                view.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: {
                    view.transform = .identity
                    view.layoutIfNeeded()
                }, completion: { _ in
                    completion()
                })
            case .zoomOut(let scaleFactor):
                view.transform = .identity
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: {
                    view.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
                    view.layoutIfNeeded()
                }, completion: { _ in
                    completion()
                })
            }
        }
    }
    
    func add(_ child: UIViewController, frame: CGRect? = nil, animationBlock: (animate: ChildViewAnimationOption
        , completion: (() -> Void))? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        animationBlock?.animate.animate(child.view, completion: {
            animationBlock?.completion()
        })
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(animationBlock: (animate: ChildViewAnimationOption, completion: (() -> Void))? = nil) {
        if let animationBlock = animationBlock {
            animationBlock.animate.animate(self.view, completion: { [weak self] in
                self?.willMove(toParent: nil)
                self?.view.removeFromSuperview()
                self?.removeFromParent()
                animationBlock.completion()
            })
        }
        else {
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    private func setNavItemColorForIOS13(_ titleColor: UIColor, largeTitleColor: UIColor, barTintColor: UIColor, tintColor: UIColor?, transparentBackground: Bool? = false, titleFont: UIFont?, largeTitleFont: UIFont?) {
        if #available(iOS 13.0, *) {
            if let navBarAppearance = navigationController?.navigationBar.standardAppearance {
                if let transparentBackground = transparentBackground, transparentBackground {
                    navBarAppearance.configureWithTransparentBackground()
                } else {
                    navBarAppearance.configureWithDefaultBackground()
                }
                var currentTitleFont: UIFont = UIFont.systemFont(ofSize: 20.0)
                var currentLargeTitleFont: UIFont = UIFont.systemFont(ofSize: 32.0)
                if titleFont != nil {
                    currentTitleFont = titleFont!
                }
                if largeTitleFont != nil {
                    currentLargeTitleFont = largeTitleFont!
                }
                
                navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor, .font: currentTitleFont]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor, .font: currentLargeTitleFont]
                navBarAppearance.backgroundColor = barTintColor
                navigationController?.navigationBar.tintColor = tintColor
                navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                navigationController?.navigationBar.compactAppearance = navBarAppearance
                navigationController?.navigationBar.standardAppearance = navBarAppearance
            }
        }
    }
    
    private func setNavItemColorForIOS12AndEarlier(_ titleColor: UIColor, largeTitleColor: UIColor, barTintColor: UIColor, tintColor: UIColor?, titleFont: UIFont?, largeTitleFont: UIFont?) {
        var currentTitleFont: UIFont = UIFont.systemFont(ofSize: 20.0)
        var currentLargeTitleFont: UIFont = UIFont.systemFont(ofSize: 32.0)
        if titleFont != nil {
            currentTitleFont = titleFont!
        }
        if largeTitleFont != nil {
            currentLargeTitleFont = largeTitleFont!
        }
        self.navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor: titleColor, .font: currentTitleFont]
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: largeTitleColor, .font: currentLargeTitleFont]
        self.navigationController?.navigationBar.barTintColor = barTintColor
    }
    
}

extension UIViewController {
    public func setNavigationItemColor(_ titleColor: UIColor, largeTitleColor: UIColor, barTintColor: UIColor, tintColor: UIColor? = nil, transparentBackground: Bool? = false, titleFont: UIFont? = nil, largeTitleFont: UIFont? = nil) {
        if #available(iOS 13.0, *) {
            setNavItemColorForIOS13(titleColor, largeTitleColor: largeTitleColor, barTintColor: barTintColor, tintColor: tintColor, transparentBackground: transparentBackground, titleFont: titleFont, largeTitleFont: largeTitleFont)
        } else {
            setNavItemColorForIOS12AndEarlier(titleColor, largeTitleColor: largeTitleColor, barTintColor: barTintColor, tintColor: tintColor, titleFont: titleFont, largeTitleFont: largeTitleFont)
        }
    }
    
    public func hideLineInNavigationBar(with lineColor: UIColor) {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.standardAppearance.shadowImage = UIImage()
            self.navigationController?.navigationBar.standardAppearance.shadowColor = lineColor
            
            self.navigationController?.navigationBar.compactAppearance?.shadowImage = UIImage()
            self.navigationController?.navigationBar.compactAppearance?.shadowColor = lineColor
            
            self.navigationController?.navigationBar.scrollEdgeAppearance?.shadowImage = UIImage()
            self.navigationController?.navigationBar.scrollEdgeAppearance?.shadowColor = lineColor
        } else {
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    func transparentNavigationBar(_ titleColor: UIColor, largeTitleColor: UIColor, tintColor: UIColor?, titleFont: UIFont? = nil, largeTitleFont: UIFont? = nil) {
        let img = UIImage()
        navigationController?.navigationBar.shadowImage = img
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        setNavigationItemColor(titleColor, largeTitleColor: largeTitleColor, barTintColor: .clear, tintColor: tintColor, transparentBackground: true, titleFont: titleFont, largeTitleFont: largeTitleFont)
    }
    
    func presentMessege(title: String?, message: String?, additionalActions: UIAlertAction..., preferredStyle: UIAlertController.Style) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        
        additionalActions.forEach(alertController.addAction)
        alertController.setStyle(style: self.preferredStatusBarStyle)
        alertController.modalPresentationStyle = .currentContext
        present(alertController, animated: true, completion: nil)
    }
    
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}

extension UIViewController: NibLoadable {}
