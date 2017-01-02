//
//  String + AddText.swift
//  MyLocations
//
//  Created by 张润峰 on 2017/1/2.
//  Copyright © 2017年 FighterRay. All rights reserved.
//

import Foundation

extension String {
    mutating func add(text: String?, separatedBy separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}
