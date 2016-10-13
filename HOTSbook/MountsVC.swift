//
//  MountsVC.swift
//  HOTSbook
//
//  Created by Doruk Gezici on 19/06/16.
//  Copyright © 2016 Doruk Gezici. All rights reserved.
//

import UIKit

class MountsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var mounts = [Mount]()

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        parseMountsJSON()
    }

    func parseMountsJSON() {
        if let path = Bundle.main.path(forResource: "mounts", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                do {
                    if let objects = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:AnyObject]] {
                        for object in objects {
                            let mount = Mount(JSON: object)
                            self.mounts.append(mount)
                        }
                    } else { print("ParseJSON hata!") }
                } catch { print(error) }
            }
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mounts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MountCell", for: indexPath) as? MountCell {
            cell.configureCell(mounts[(indexPath as NSIndexPath).row])
            return cell
        } else { return UICollectionViewCell() }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 140)
    }

}
