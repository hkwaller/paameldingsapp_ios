//
//  ViewController.swift
//  Paameldingsapp
//
//  Created by Hannes Waller on 2015-11-06.
//  Copyright © 2015 Hannes Waller. All rights reserved.
//

import UIKit
import Alamofire

class PageViewController: UIPageViewController {
    
    var numberofpages = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        EventsService.instance
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        

        let eventViewController1 = storyboard.instantiateViewControllerWithIdentifier("EventViewController")
        
        
        setViewControllers(
            [eventViewController1], direction: .Forward, animated: true) { (Bool) in
                print("something")
        }
        
        dataSource  = self
        delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewControllerWithIdentifier("EventViewController")
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
        return storyboard.instantiateViewControllerWithIdentifier("EventViewController")
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        print("getting number of pages")
        
        return numberofpages
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    
}

