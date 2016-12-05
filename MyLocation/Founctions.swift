//
//  Founctions.swift
//  MyLocations
//
//  Created by 张润峰 on 2016/12/5.
//  Copyright © 2016年 FighterRay. All rights reserved.
//

import Foundation
import Dispatch

func delayAfter(_ seconds: Double, closure: @escaping (Void) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
}
