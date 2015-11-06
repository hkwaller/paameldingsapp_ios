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
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var captchaView: UIView!
    @IBOutlet weak var checkbox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captchaView.layer.borderWidth = 0.5
        captchaView.layer.borderColor = UIColor(red: 60.0, green: 60.0, blue: 60.0, alpha: 0.2).CGColor
        captchaView.layer.cornerRadius = 3
        
        timeView.layer.cornerRadius = 3
    
        renderLogo()
    }
    
    
    override func viewWillLayoutSubviews() {
        self.view.layoutIfNeeded()
    }
    
    func renderLogo() {
        let logo = UIImage(named: "Logo")
        
        let marginX = (self.navigationController!.navigationBar.frame.size.width / 2) - (logo!.size.width / 4);
        let imgView = UIImageView(frame: CGRectMake(marginX, 10, logo!.size.width / 2, logo!.size.height / 2))
        
        imgView.image = logo
        
        self.navigationController!.navigationBar.addSubview(imgView)
    }
}
