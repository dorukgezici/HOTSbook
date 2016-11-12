//
//  Cell.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 04/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//
//[id, description, stats, franchise, releaseDate, talents, attributeid, type, title, ratings, icon, role, difficulty, abilities, name, gender]

import UIKit

class HeroCell: UICollectionViewCell {

    @IBOutlet weak var Lbl: UILabel!
    @IBOutlet weak var Img: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10.0
    }
    override func awakeFromNib() {
        Img.layer.cornerRadius = 10.0
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func configureCell(_ hero: Hero) {
        Lbl.text = hero.name
        Img.image = hero.img
    }

}
