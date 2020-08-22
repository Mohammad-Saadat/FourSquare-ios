//
//  UIImageViewExtension.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Kingfisher

extension UIImageView {
    
    func changeColorTo(_ color: UIColor){
        guard let image =  self.image else {return}
        self.image = image.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
    
    func rotate(_ duration: Double, _ toValue: Double) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: toValue)
        rotation.duration = duration
        rotation.isCumulative = true
        //        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    @discardableResult
    func setImage(with resource: Resource?,
                  placeholder: Placeholder? = nil,
                  options: KingfisherOptionsInfo? = nil,
                  progressBlock: DownloadProgressBlock? = nil,
                  completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask? {
        return kf.setImage(with: resource,
                           placeholder: placeholder,
                           options: options,
                           progressBlock: progressBlock,
                           completionHandler: completionHandler)
    }
}
