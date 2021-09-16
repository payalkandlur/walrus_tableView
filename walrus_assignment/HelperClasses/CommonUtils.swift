//
//  CommonUtils.swift
//  walrus_assignment
//
//  Created by Payal Kandlur on 15/09/21.
//

import UIKit

class CommonUtils {
    
    static let sharedInstance = CommonUtils()
    
    var activityView: UIActivityIndicatorView?
    
    func showActivityIndicatory(_ view: UIView) {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = view.center
        view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
}
