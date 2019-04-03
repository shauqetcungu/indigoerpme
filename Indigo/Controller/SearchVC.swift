//
//  SearchVC.swift
//  Indigo
//
//  Created by Amplitudo on 02/04/2019.
//  Copyright © 2019 Shauqet Cungu. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var menyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainVC.handleTap))
        view.addGestureRecognizer(tap)
        
        menyBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController().tapGestureRecognizer())!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
