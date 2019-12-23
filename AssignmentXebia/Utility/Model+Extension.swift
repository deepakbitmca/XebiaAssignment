//
//  Model+Extension.swift
//  AssignmentXebia
//
//  Created by Irshad Ahmed on 23/12/19.
//  Copyright © 2019 Deepak Chauhan. All rights reserved.
//


import Foundation


extension JSON{
    func isKeyPresent()->Bool {
        if self == nil || self.null != nil{
            return false
        }
        return true
    }
}

public protocol JSONDecodable{
    init(json:JSON)
}





extension Collection where Iterator.Element == JSON {
    func decode<T:JSONDecodable>() -> [T] {
        return map({T(json:$0)})
    }
    
    func arrayDict() ->[[String:Any]]{
        var items:[[String:Any]] = []
        self.forEach({
            if let obj = $0.dictionaryObject {
               items.append(obj)
            }
        })
        return items
    }
    
    func arrayString() ->[String]{
        
        var items:[String] = []
        
        self.forEach({ items.append($0.stringValue) })
        
        return items
    }

}
