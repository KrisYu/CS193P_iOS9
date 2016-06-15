//
//  URL.swift
//  Cassini_l7
//
//  Created by 雪 禹 on 6/8/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import Foundation


struct DemoURL {
    static let Stanford = "http://comm.stanford.edu/wp-content/uploads/2013/01/stanford-campus.png"
    
    static let NASA = [
        "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
        "Earth" : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
        "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
    ]
    
    static func NASAImageNamed(imageName: String?) -> NSURL? {
        if let urlstring = NASA[imageName ?? ""]{
            return NSURL(string: urlstring)
        } else {
            return nil
        }
    }

}