//
//  EventViewController.swift
//  Paameldingsapp
//
//  Created by Hans-Chr Fjeldberg on 06/11/15.
//  Copyright © 2015 Hannes Waller. All rights reserved.
//

import Foundation
import UIKit

class EventViewController : UIViewController {

    var eventIndex: Int?

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var captchaView: UIView!
    @IBOutlet weak var checkbox: UIView!
    
    @IBOutlet weak var maxNumberPlacesLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captchaView.layer.borderWidth = 0.5
        captchaView.layer.borderColor = UIColor(red: 60.0, green: 60.0, blue: 60.0, alpha: 0.2).CGColor
        captchaView.layer.cornerRadius = 3
        
        timeView.layer.cornerRadius = 3

        renderLogo()
        
        populateViewFromEvent()
    }

    override func viewWillLayoutSubviews() {
        self.view.layoutIfNeeded()
    }
    
    private func renderLogo() {
        let logo = UIImage(named: "Logo")

        let marginX = (self.navigationController!.navigationBar.frame.size.width / 2) - (logo!.size.width / 4);
        let imgView = UIImageView(frame: CGRectMake(marginX, 10, logo!.size.width / 2, logo!.size.height / 2))

        imgView.image = logo

        self.navigationController!.navigationBar.addSubview(imgView)
    }
    
    private func populateViewFromEvent() {
        EventsService.instance.getUpcomingEvents { (status, events) in
            
            guard let index = self.eventIndex, let actualEvents = events else {
                print("Index or events not present, nothing to show")
                return
            }
            
            let event = actualEvents[index]
            
            self.eventNameLabel.text = event["subject"]??.description
            self.maxNumberPlacesLabel.text = event["maxNumber"]??.description
            self.locationLabel.text = event["location"]??.description
            
            let startTimeMillis = event["startTime"] as! Double
            

            let startTime = NSDate(timeIntervalSince1970: startTimeMillis/1000.0)

            let formatter = NSDateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "NO_nb")
            formatter.dateStyle = NSDateFormatterStyle.FullStyle
            formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            
            print("start time: \(formatter.stringFromDate(startTime))")

            self.startTimeLabel.text = formatter.stringFromDate(startTime)
        }

    }
}
