//
//  NNPinAnnotation.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/7.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import MapKit


class NNPinAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
        
}
