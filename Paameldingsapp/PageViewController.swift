//
//  ViewController.swift
//  Paameldingsapp
//
//  Created by Hannes Waller on 2015-11-06.
//  Copyright © 2015 Hannes Waller. All rights reserved.
//

import UIKit
import Alamofire

class PageViewController: UIPageViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EventsService.instance.getUpcomingEvents { (status, events) in
            print("Got upcoming events, updating stuff")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            
            let eventViewController = storyboard.instantiateViewControllerWithIdentifier("EventViewController") as! EventViewController
            
            eventViewController.eventIndex = 0
            
            self.setViewControllers(
                [eventViewController], direction: .Forward, animated: true) { (result) in
                    print("something")
            }
        }
        
        dataSource  = self
        delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let index = (viewController as! EventViewController).eventIndex!
        
        if (index <= 0) {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let eventViewController = storyboard.instantiateViewControllerWithIdentifier("EventViewController") as! EventViewController
        
        eventViewController.eventIndex = index - 1
        
        return eventViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        let index = (viewController as! EventViewController).eventIndex!

        if index >= presentationCountForPageViewController(self) - 1 {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
        let eventViewController = storyboard.instantiateViewControllerWithIdentifier("EventViewController") as! EventViewController
        
        eventViewController.eventIndex = index + 1
        
        return eventViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return EventsService.instance.getNumberOfUpcomingEvents()
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    
}

