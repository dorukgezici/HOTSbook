//
//  Ability.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 05/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//

class Ability {

    var name: String!
    var description: String!
    var cooldown: String?
    var shortcut: String?

    init(JSON: [String:AnyObject]) {
        name = JSON["name"] as! String
        description = JSON["description"] as! String
        if let cd = JSON["cooldown"] as? Int {
            cooldown = String(cd)
        } else { cooldown = "-" }
        if let short = JSON["shortcut"] as? String {
            shortcut = short
        } else { shortcut = "-" }
    }

}
