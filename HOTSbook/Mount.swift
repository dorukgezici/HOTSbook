//
//  Mount.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 19/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//

import UIKit

class Mount: Hashable {

    var hashValue: Int {
        return self.id.hashValue
    }
    var id: String!
    var img: UIImage!
    var JSON: [String:AnyObject]!
    var name: String!
    var description: String!
    init(JSON: [String:AnyObject]) {
        self.JSON = JSON
        self.id = JSON["id"] as! String
        self.name = JSON["name"] as! String
        self.description = JSON["description"] as! String

        if let img = UIImage(named: "hots-\(name.lowercaseString)") { self.img = img }
        else { self.img = UIImage(named: "hots-heroes-poster") }
    }
    
}

func ==(lhs: Mount, rhs: Mount) -> Bool {
    return lhs.id.hashValue == rhs.id.hashValue
}