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
        if let path = NSBundle.mainBundle().pathForResource("mounts", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                do {
                    if let objects = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [[String:AnyObject]] {
                        for object in objects {
                            let mount = Mount(JSON: object)
                            self.mounts.append(mount)
                        }
                    } else { print("ParseJSON hata!") }
                } catch { print(error) }
            }
        }
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mounts.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MountCell", forIndexPath: indexPath) as? MountCell {
            cell.configureCell(mounts[indexPath.row])
            return cell
        } else { return UICollectionViewCell() }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(160, 140)
    }

}
