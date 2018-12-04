//
//  ViewController.swift
//  LeaderBoardTest
//
//  Created by Bhavesh Kumbhani on 04/12/18.
//  Copyright © 2018 Bhavesh Kumbhani. All rights reserved.
//

import UIKit
import LoremIpsum
import SDWebImage
import NVActivityIndicatorView


class ViewController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    var dataList = [User]()
    var updateTimer : Timer! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.register(UINib.init(nibName: "TBLUserCell", bundle: nil), forCellReuseIdentifier: "TBLUserCell")
        self.collectionView.register(UINib.init(nibName: "TopScoreCell", bundle: nil), forCellWithReuseIdentifier: "TopScoreCell")
    
        DispatchQueue.main.async {
            self.startAnimating()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Preparing...")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.preparedAndLoadData()
        }
        
    }
}

// MARK: - Data Update
extension ViewController{
    func preparedAndLoadData() -> Void {
        
        dataList.removeAll()
        for _ in 0..<100000 {
            let user = User()
            user.username = LoremIpsum.name()
            user.score = Float.random(in: 0.5...100)
           // user.image = LoremIpsum.urlForPlaceholderImage(with: CGSize.init(width: 50, height: 50))?.absoluteString ?? ""
            dataList.append(user)
        }

        DispatchQueue.main.async {
            self.stopAnimating()
            self.autoUpdate()
        }
          self.updateTimer =  Timer.scheduledTimer(timeInterval: 1.5,
                             target: self,
                             selector: #selector(autoUpdate),
                             userInfo: nil,
                             repeats: true)
        self.updateTimer.fire()
    }
    
    @objc func autoUpdate() -> Void {
        print("call autoUpdate")
        dataList.forEach { ($0.score = Float.random(in: 0.5...100) )}
        dataList = dataList.sorted(by: { (obj1, obj2) -> Bool in
            return obj1.score > obj2.score
        })
        tblView.reloadData()
        collectionView.reloadData()
    }
}

// MARK: - UITableView Deletegate
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfdataList(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TBLUserCell") as? TBLUserCell else {
            assertionFailure("Cell shouldn't be nil")
            return TBLUserCell()
        }
        guard dataList.count > 0 else {
            Swift.debugPrint("dataList nil in cellForRowAt-TBLUserCell")
            return cell
        }
        let user = dataList[indexPath.row]
        cell.lblUserName.text = user.username
        cell.lblScore.text = String.init(format: "%0.2f", user.score)
        
        cell.imgView.sd_setImage(with: URL.init(string: user.image), placeholderImage: UIImage.init(named: "profile"), options: SDWebImageOptions.highPriority) { (image: UIImage?, error: Error?, type:  SDImageCacheType?, url: URL?) in
            if (image != nil){
               
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopScoreCell", for: indexPath) as? TopScoreCell else {
            assertionFailure("Cell shouldn't be nil")
            return TopScoreCell()
        }
        guard dataList.count > 0 else {
            Swift.debugPrint("dataList nil in cellForRowAt-TBLUserCell")
            return cell
        }

        let user = dataList[indexPath.row]
        cell.lblUserName.text = user.username
        cell.lblScore.text = String.init(format: "%0.2f", user.score)
        
        cell.imgView.sd_setImage(with: URL.init(string: user.image), placeholderImage: UIImage.init(named: "profile"), options: SDWebImageOptions.highPriority) { (image: UIImage?, error: Error?, type:  SDImageCacheType?, url: URL?) in
            if (image != nil){
                
            }
        }
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
//        let rect = self.view.frame as CGRect
//        let cellSize = (rect.size.width - 30 ) / 2
//
//        print("cellSize:",cellSize)
//
//        return CGSize.init(width: Int(cellSize), height: Int(cellSize + 82))
//    }
}

