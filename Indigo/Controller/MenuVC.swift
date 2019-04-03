//
//  MenuVC.swift
//  Indigo
//
//  Created by Saša Vujanovic on 09/03/2019.
//  Copyright © 2019 Shauqet Cungu. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var mainVC: MainVC!
    var searchVC: SearchVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 50
        
        mainVC = self.revealViewController()?.frontViewController as? MainVC
        searchVC = UIStoryboard(name: "SearchVC", bundle: nil).instantiateInitialViewController() as? SearchVC
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell{
            let menu = MenuDataService.instance.getMenuItems()[indexPath.row]
            cell.configureCell(menu: menu)
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuDataService.instance.getMenuItems().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.revealViewController()?.pushFrontViewController(mainVC, animated: true)
        case 1:
            self.revealViewController()?.pushFrontViewController(searchVC, animated: true)
        default:
            break
        }
        
    }
    
}
