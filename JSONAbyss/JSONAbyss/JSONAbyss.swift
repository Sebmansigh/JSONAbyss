//
//  JSONAbyss.swift
//  JSONAbyss
//
//  Created by Sebastian Snyder on 4/24/18.
//  Copyright © 2018 Sebastian Snyder. All rights reserved.
//

import Foundation

class JSONAbyss
{
    static var JSONData: [String: Any]? = nil
    static func getData(url: URL, onComplete: @escaping () -> Void )
    {
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in do{
                let html = String(data: data!, encoding: String.Encoding.utf8)!
                
                if let data = html.data(using: String.Encoding.utf8)
                {
                    JSONData = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any];
                }
            }
        }
        task.resume();
    }
    
    static func get(_ keys: Any... ) -> Any
    {
        var curKeys: [Any] = keys.reversed();
        var curData: Any? = JSONData!;
        while (!curKeys.isEmpty)
        {
            let key = curKeys.popLast();
            if let kStr = key as? String
            {
                curData = (curData as! [String:Any])[kStr]
            }
            else if let kInt = key as? Int
            {
                curData = (curData as! [Any])[kInt]
            }
            else
            {
                fatalError("Only string or integer keys are allowed.");
            }
        }
        return curData as Any;
    }
}
