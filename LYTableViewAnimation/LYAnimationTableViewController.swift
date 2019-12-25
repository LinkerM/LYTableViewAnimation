//
//  LYAnimationTableViewController.swift
//  LYTableViewAnimation
//
//  Created by Joint on 2019/12/19.
//  Copyright © 2019 Joint. All rights reserved.
//

import UIKit

class LYAnimationTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var dataArray = [String]()
    var animationType: LYTableViewAnimationType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.loadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellIdentifier")
        let testView = UIView()
        testView.frame = CGRect(x: 15, y:5 , width: UIScreen.main.bounds.size.width - 30, height: 70)
        testView.backgroundColor = randomRGB()
        testView.layer.masksToBounds = true
        testView.layer.cornerRadius = 6.0
        cell.contentView.addSubview(testView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 0...100{
                self.dataArray.append(NSString(format: "%d",i) as String)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.ly_cellAnimationWithType(animate: self.animationType!)
            }
        }
    }
    func randomRGB() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
    }
}
