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
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        renderLogo()

        EventsService.instance.getUpcomingEvents { (status, events) in

            guard let index = self.eventIndex, let actualEvents = events else {
                print("Index or events not present, nothing to show")
                return
            }

            let event = actualEvents[index]

            self.eventNameLabel.text = event["subject"] as? String
        }
    }

    func renderLogo() {
        let logo = UIImage(named: "Logo")

        let marginX = (self.navigationController!.navigationBar.frame.size.width / 2) - (logo!.size.width / 4);
        let imgView = UIImageView(frame: CGRectMake(marginX, 10, logo!.size.width / 2, logo!.size.height / 2))

        imgView.image = logo

        self.navigationController!.navigationBar.addSubview(imgView)
    }
}
