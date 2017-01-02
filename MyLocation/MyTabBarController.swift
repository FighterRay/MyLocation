//
//  MyTabBarController.swift
//  MyLocations
//
//  Created by 张润峰 on 2017/1/2.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return nil
    }
}
