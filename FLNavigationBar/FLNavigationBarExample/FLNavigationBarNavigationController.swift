//
//  FLNavigationBarNavigationController.swift
//  FLBaseKit
//
//  Created by 李永强 on 2019/8/16.
//  Copyright © 2019 李永强. All rights reserved.
//

import UIKit

class FLNavigationBarNavigationController: FLBaseNavigationController {
    override func loadView() {
        super.loadView()
        self.navigationBar.backIndicatorImage = UIImage.init(named: "yq_back_black")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage.init(named: "yq_back_black")
        self.barStyle = .transparent
        self.barBackgroundColor = UIColor.white
        self.barLineColor = UIColor.white
        self.barStyleUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
