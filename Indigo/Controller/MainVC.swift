//
//  MainVC.swift
//  Indigo
//
//  Created by Saša Vujanovic on 09/03/2019.
//  Copyright © 2019 Shauqet Cungu. All rights reserved.
//

import UIKit
import Charts

class MainVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var slides:[Silde] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainVC.handleTap))
        view.addGestureRecognizer(tap)
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController().tapGestureRecognizer())!)
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func setupSlideScrollView(slides : [Silde]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-100)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(slides.count), height: scrollView.frame.height-100)
        scrollView.isPagingEnabled = true
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    
}
