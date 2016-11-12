//
//  AbilityCell.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 06/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//

import UIKit

class AbilityCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var cooldown: UILabel!
    @IBOutlet weak var shortcut: UILabel!

    func configureCell(_ ability: Ability) {
        name.text = ability.name?.capitalized
        descript.text = ability.description?.capitalized
        cooldown.text = ability.cooldown?.capitalized
        shortcut.text = ability.shortcut?.capitalized
    }

}
