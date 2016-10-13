//
//  AbilitiesVC.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 06/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//

import UIKit

class AbilitiesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var AbilitiesLbl: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    var heroName: String!
    var abilities = [Ability]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if heroName.characters.last == "s" {
            AbilitiesLbl.title = "\(heroName!)' Abilities"
        } else {
            AbilitiesLbl.title = "\(heroName!)'s Abilities"
        }
    }

    @IBAction func backBtnAct() {
        dismiss(animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abilities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityCell") as? AbilityCell {
            cell.configureCell(abilities[(indexPath as NSIndexPath).row])
            return cell
        } else { return UITableViewCell() }
    }

}
