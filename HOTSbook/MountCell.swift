//
//  MountCell.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 19/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//

import UIKit

class MountCell: UICollectionViewCell {

    @IBOutlet weak var mountImg: UIImageView!
    @IBOutlet weak var mountName: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10.0
    }
    override func awakeFromNib() {
        mountImg.layer.cornerRadius = 10.0
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func configureCell(_ mount: Mount) {
        mountName.text = mount.name
        mountImg.image = mount.img
    }

}
