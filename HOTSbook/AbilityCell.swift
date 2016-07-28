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

    func configureCell(ability: Ability) {
        name.text = ability.name?.capitalizedString
        descript.text = ability.description?.capitalizedString
        cooldown.text = ability.cooldown?.capitalizedString
        shortcut.text = ability.shortcut?.capitalizedString
    }

}
