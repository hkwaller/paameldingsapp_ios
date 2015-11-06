//
//  EventsService.swift
//  Paameldingsapp
//
//  Created by Hans-Chr Fjeldberg on 06/11/15.
//  Copyright © 2015 Hannes Waller. All rights reserved.
//

import Foundation
import Alamofire

struct EventsService {
    
    
    static let instance: EventsService = {
        let eventsService = EventsService()
        
        eventsService.fetchUpcomingEvents()
        
        return eventsService
    }()
    
    private init() {
        print("initilizing events service only once")
    }
    
    private func fetchUpcomingEvents() {
    
        print("Getting upcoming events")
        
        Alamofire.request(.GET, "http://paamelding.herokuapp.com/api/events/upcoming").responseJSON { response in
            
            if let data = response.data {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                if let events = obj as? [AnyObject] {
                    for event in events {
                        print(event["subject"])
                        print(event["description"])
                    }
                }
                
                
            }
            
            if let json = response.result.value {
                //print("JSON: \(JSON)")
                
                print("title: \(json)")
                
            }
        }
    }
}
