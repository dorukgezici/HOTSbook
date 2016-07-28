//
//  HeroesVC.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 05/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//

import UIKit

class HeroesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    var heroes = [Hero]()
    var filteredHeroes = [Hero]()
    var roleHeroes = [Hero]()
    var franchiseHeroes = [Hero]()
    var isSearching = false
    var selectedHero: Hero?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        parseHeroesJSON()
        filteredHeroes = heroes
        roleHeroes = heroes
        franchiseHeroes = heroes
    }
    
    func parseHeroesJSON() {
        if let path = NSBundle.mainBundle().pathForResource("heroes", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                do {
                    if let objects = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [[String:AnyObject]] {
                        for object in objects {
                            let hero = Hero(JSON: object)
                            self.heroes.append(hero)
                        }
                    } else { print("ParseJSON error!") }
                } catch { print(error) }
            }
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching { return filteredHeroes.count }
        else { return heroes.count }
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HeroCell", forIndexPath: indexPath) as? HeroCell {
            if isSearching {
                cell.configureCell(filteredHeroes[indexPath.row])
            } else {
                cell.configureCell(heroes[indexPath.row])
            }; return cell
        } else { return UICollectionViewCell() }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if isSearching {
            selectedHero = filteredHeroes[indexPath.row]
        } else {
            selectedHero = heroes[indexPath.row]
        }
        performSegueWithIdentifier("details", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "details" {
            if let destVC = segue.destinationViewController as? DetailsVC {
                destVC.hero = selectedHero!
            }
        }
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        var set = Set(roleHeroes)
        set = set.intersect(franchiseHeroes)
        filteredHeroes = Array(set)
        filteredHeroes.sortInPlace { (first, second) -> Bool in
            first.name < second.name
        }
        if searchBar.text == nil || searchBar.text == "" {
            if roleControl.selectedSegmentIndex == 0 && franchiseControl.selectedSegmentIndex == 0 {
                isSearching = false
            }
        } else {
            isSearching = true
            let key = searchBar.text!.capitalizedString
            filteredHeroes = filteredHeroes.filter({$0.name.rangeOfString(key) != nil})
        }; collectionView.reloadData()
    }

    @IBOutlet weak var roleControl: UISegmentedControl!
    @IBAction func roleControlAct(sender: AnyObject) {
        roleHeroes = heroes
        switch roleControl.selectedSegmentIndex {
        case 0:
            roleHeroes = heroes
            collectionView.reloadData()
        case 1:
            isSearching = true
            roleHeroes = heroes.filter({$0.role == "Warrior"})
            collectionView.reloadData()
        case 2:
            isSearching = true
            roleHeroes = heroes.filter({$0.role == "Assassin"})
            collectionView.reloadData()
        case 3:
            isSearching = true
            roleHeroes = heroes.filter({$0.role == "Support"})
            collectionView.reloadData()
        case 4:
            isSearching = true
            roleHeroes = heroes.filter({$0.role == "Specialist"})
            collectionView.reloadData()
        default:
            break
        }
        var set = Set(roleHeroes)
        set = set.intersect(franchiseHeroes)
        filteredHeroes = Array(set)
        filteredHeroes.sortInPlace { (first, second) -> Bool in
            first.name < second.name
        }
    }
    @IBOutlet weak var franchiseControl: UISegmentedControl!
    @IBAction func franchiseControlAct(sender: UISegmentedControl) {
        franchiseHeroes = heroes
        switch franchiseControl.selectedSegmentIndex {
        case 0:
            franchiseHeroes = heroes
            collectionView.reloadData()
        case 1:
            isSearching = true
            franchiseHeroes = heroes.filter({$0.franchise == "Warcraft"})
            collectionView.reloadData()
        case 2:
            isSearching = true
            franchiseHeroes = heroes.filter({$0.franchise == "Starcraft"})
            collectionView.reloadData()
        case 3:
            isSearching = true
            franchiseHeroes = heroes.filter({$0.franchise == "Diablo"})
            collectionView.reloadData()
        case 4:
            isSearching = true
            franchiseHeroes = heroes.filter({$0.franchise == "Retro"})
            collectionView.reloadData()
        case 5:
            isSearching = true
            franchiseHeroes = heroes.filter({$0.franchise == "Overwatch"})
            collectionView.reloadData()
        default:
            break
        }
        var set = Set(franchiseHeroes)
        set = set.intersect(roleHeroes)
        filteredHeroes = Array(set)
        filteredHeroes.sortInPlace { (first, second) -> Bool in
            first.name < second.name
        }
    }
    
}
