//
//  EventsService.swift
//  Paameldingsapp
//
//  Created by Hans-Chr Fjeldberg on 06/11/15.
//  Copyright © 2015 Hannes Waller. All rights reserved.
//

import Foundation
import Alamofire

class EventsService {
    
    var cachedEvents: [AnyObject]?
    
    static let instance: EventsService = {
        return EventsService()
    }()
    
    private init() {
        print("initilizing events service only once")
    }
    
    func getUpcomingEvents(completionHandler: (status: Int, events: [AnyObject]?) -> Void) {
        
        print("Getting upcoming events")
        
        if let fetchedCachedEvents = cachedEvents {
            
            print("Cached, using it")
            
            completionHandler(status: 200, events: fetchedCachedEvents)
            return
        }
        
        fetchUpcomingEvents(completionHandler)
    }
    
    func getNumberOfUpcomingEvents() -> Int {
        guard let fetchedCachedEvents = cachedEvents else {
            return 0
        }
        
        return fetchedCachedEvents.count
    }
    
    private func fetchUpcomingEvents(completionHandler: (status: Int, events: [AnyObject]?) -> Void) {
    
        print("Fetching upcoming events")
        
        Alamofire.request(.GET, "http://paamelding.herokuapp.com/api/events/upcoming").responseJSON { response in
            
            if let json = response.result.value {
                print("json: \(json)")
            }
            
            if let data = response.data {
                let obj = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                
                if let events = obj as? [AnyObject] {
                    
                    self.cachedEvents = events
                    
                    completionHandler(status: 200, events: events)
                }
            }
        }
    }
}
