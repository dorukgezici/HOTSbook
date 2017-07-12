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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HeroesVC.dismissSearch))
        tapGesture.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    func dismissSearch() {
        searchBar.resignFirstResponder()
    }
    
    func parseHeroesJSON() {
        if let path = Bundle.main.path(forResource: "heroes", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                do {
                    if let objects = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:AnyObject]] {
                        for object in objects {
                            let hero = Hero(JSON: object)
                            self.heroes.append(hero)
                        }
                    } else { print("ParseJSON error!") }
                } catch { print(error) }
            }
        }
    }
    
    // MARK: - Collection View Delegate Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching { return filteredHeroes.count }
        else { return heroes.count }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as? HeroCell {
            if isSearching {
                cell.configureCell(filteredHeroes[(indexPath as NSIndexPath).row])
            } else {
                cell.configureCell(heroes[(indexPath as NSIndexPath).row])
            }; return cell
        } else { return UICollectionViewCell() }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSearching {
            selectedHero = filteredHeroes[(indexPath as NSIndexPath).row]
        } else {
            selectedHero = heroes[(indexPath as NSIndexPath).row]
        }
        performSegue(withIdentifier: "details", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            if let destVC = segue.destination as? DetailsVC {
                destVC.hero = selectedHero!
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var set = Set(roleHeroes)
        set = set.intersection(franchiseHeroes)
        filteredHeroes = Array(set)
        filteredHeroes.sort { (first, second) -> Bool in
            first.name < second.name
        }
        if searchBar.text == nil || searchBar.text == "" {
            if roleControl.selectedSegmentIndex == 0 && franchiseControl.selectedSegmentIndex == 0 {
                isSearching = false
            }
        } else {
            isSearching = true
            let key = searchBar.text!.capitalized
            filteredHeroes = filteredHeroes.filter({$0.name.range(of: key) != nil})
        }; collectionView.reloadData()
    }

    @IBOutlet weak var roleControl: UISegmentedControl!
    @IBAction func roleControlAct(_ sender: AnyObject) {
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
        set = set.intersection(franchiseHeroes)
        filteredHeroes = Array(set)
        filteredHeroes.sort { (first, second) -> Bool in
            first.name < second.name
        }
    }
    @IBOutlet weak var franchiseControl: UISegmentedControl!
    @IBAction func franchiseControlAct(_ sender: UISegmentedControl) {
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
        set = set.intersection(roleHeroes)
        filteredHeroes = Array(set)
        filteredHeroes.sort { (first, second) -> Bool in
            first.name < second.name
        }
    }
    
}
