//
//  SummaryViewController.swift
//  Refresh
//
//  Created by Avi Khemani on 3/10/21.
//

import UIKit

class SummaryViewController: UIViewController, UIScrollViewDelegate {

    var movies: [String] = ["twitterSummary", "instagramSummary", "twitterSummary"]
    var frame = CGRect.zero
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = movies.count
        pageControl.addTarget(self, action: #selector(pageChanged(sender:)), for: .valueChanged)

        scrollView.delegate = self
        view.sendSubviewToBack(scrollView)
    }
    
    @IBAction func closeButtonPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupScreens()
    }
    
    func setupScreens() {
        for index in 0..<movies.count {

            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: movies[index])
            imgView.contentMode = .scaleAspectFit
            self.scrollView.addSubview(imgView)
        }
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(movies.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        let pageInteger = Int(pageNumber)
        pageControl.currentPage = pageInteger
    }
    
    @objc func pageChanged(sender: UIPageControl) {
        let xVal = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: xVal, y: 0), animated: true)
    }
    

}
