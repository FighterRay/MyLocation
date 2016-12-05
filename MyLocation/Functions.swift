//
//  Functions.swift
//  MyLocations
//
//  Created by 张润峰 on 2016/12/5.
//  Copyright © 2016年 FighterRay. All rights reserved.
//

import Foundation
import Dispatch

func afterDelay(_ seconds: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now(), execute: closure)
}
