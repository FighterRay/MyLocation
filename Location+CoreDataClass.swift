//
//  Location+CoreDataClass.swift
//  MyLocations
//
//  Created by 张润峰 on 2016/12/6.
//  Copyright © 2016年 FighterRay. All rights reserved.
//

import Foundation
import CoreData
import MapKit

public class Location: NSManagedObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    public var title: String? {
        if locationDescription.isEmpty {
            return "(No Description)"
        } else {
            return locationDescription
        }
    }
    
    public var subtitle: String? {
        return category
    }
}
