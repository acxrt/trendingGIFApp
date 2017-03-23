//
//  ViewControllerExtension.swift
//  trendingGIFApp
//
//  Created by Aina Cuxart on 23/3/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var spinnerViewTag: Int { return 999999 }
    
    func addSpinnerView() {
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        let spinnerView = UIView(frame: view.frame)
        
        spinner.color = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        spinner.isHidden = false
        spinner.hidesWhenStopped = true
        spinnerView.addSubview(spinner)
        
        spinnerView.backgroundColor = UIColor.white
        spinnerView.frame = view.frame
        spinner.center = spinnerView.center
        spinnerView.isHidden = false
        spinnerView.tag = spinnerViewTag
        
        view.addSubview(spinnerView)
        view.bringSubview(toFront: spinnerView)
        
        spinner.startAnimating()
    }
    
    func removeLoadingView() {
        for view in self.view.subviews {
            if view.tag == spinnerViewTag{
                view.removeFromSuperview()
            }
        }
    }
    
}
