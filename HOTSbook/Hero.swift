//
//  Hero.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 03/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//

import UIKit

class Hero: Hashable {

    var hashValue: Int {
        return self.id.hashValue
    }
    var JSON: [String:AnyObject]!
    var id: String!
    var img: UIImage!
    var abilities = [Ability]()

    var name: String!
    var title: String!
    var description: String!
    var role: String!
    var type: String!
    var franchise: String!
    var difficulty: String!

    init(JSON: [String:AnyObject]) {
        self.JSON = JSON
        id = JSON["id"] as! String
        name = JSON["name"] as! String
        title = JSON["title"] as! String
        description = JSON["description"] as! String
        role = JSON["role"] as! String
        type = JSON["type"] as! String
        franchise = JSON["franchise"] as! String
        difficulty = JSON["difficulty"] as! String

        if let img = UIImage(named: "hots-\(name.lowercaseString)") { self.img = img }
        else { self.img = UIImage(named: "hots-heroes-poster") }
        if let abils = JSON["abilities"]![id] as? [[String:AnyObject]] {
            for abil in abils {
                let ability = Ability(JSON: abil)
                self.abilities.append(ability)
            }
        }
    }
    
}

func ==(lhs: Hero, rhs: Hero) -> Bool {
    return lhs.id.hashValue == rhs.id.hashValue
}

enum role: String {
    case Warrior
    case Assassin
    case Support
    case Specialist
}
enum franchise: String {
    case Warcraft
    case Starcraft
    case Diablo
    case Retro
    case OWatch
}
