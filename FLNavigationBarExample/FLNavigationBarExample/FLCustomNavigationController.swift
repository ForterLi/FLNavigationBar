//
//  FLNavigationBarNavigationController.swift
//  FLBaseKit
//
//  Created by 李永强 on 2019/8/16.
//  Copyright © 2019 李永强. All rights reserved.
//

import UIKit

class FLCustomNavigationController : UINavigationController,UINavigationControllerDelegate,UIGestureRecognizerDelegate {
    override func loadView() {
        super.loadView()
        self.delegate = self
        self.interactivePopGestureRecognizer!.delegate = (self as UIGestureRecognizerDelegate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.startBar()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.endBar(viewController)
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.children.count < 2 {
            return false
        }
        return true
    }
}
