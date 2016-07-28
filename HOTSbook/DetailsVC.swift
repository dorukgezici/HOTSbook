//
//  DetailsVC.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 05/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    var hero: Hero!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var roleLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var franchiseLbl: UILabel!
    @IBOutlet weak var difficultyLbl: UILabel!
    @IBOutlet weak var Img: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        closeBtn.layer.cornerRadius = closeBtn.frame.size.height/2
        nameLbl.text = hero.name
        titleLbl.text = hero.title
        descriptionLbl.text = hero.description
        roleLbl.text = hero.role
        typeLbl.text = hero.type
        franchiseLbl.text = hero.franchise
        difficultyLbl.text = hero.difficulty
        Img.image = hero.img
    }

    @IBOutlet weak var closeBtn: UIButton!
    @IBAction func closeBtnAct() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func doneBtnAct(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "abilities" {
            if let destVC = segue.destinationViewController as? AbilitiesVC {
                destVC.abilities = hero.abilities
                destVC.heroName = hero.name
            }
        }
    }

}
