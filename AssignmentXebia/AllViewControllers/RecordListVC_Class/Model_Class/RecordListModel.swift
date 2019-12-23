//
//  RecordListModel.swift
//  AssignmentXebia
//
//  Created by Nivedita Chauhan on 23/12/19.
//  Copyright © 2019 Deepak Chauhan. All rights reserved.
//

import Foundation



class RecordListModel:JSONDecodable {
    
    var column:String?
    var views:String?
    var source:String?
    
    var byline:String?
    var published_date:String?
    var geo_facet:String?
    
    var title:String?
    var url:String?
    var abstract:String?
    
    var uri:String?
    var type:String?
    var adx_keywords:String?
    
    var section:String?
    var id:String?
    var media:[Media]?
    
    required init(json: JSON) {
        title = json["title"].stringValue
        abstract = json["abstract"].stringValue
        type = json["title"].stringValue
        published_date = json["published_date"].stringValue
        media = json["media"].array?.decode()
    }
}




class Media:JSONDecodable {
    var caption:String?
    var approved_for_syndication:String?
    var subtype:String?
    var type:String?
    var media_metadata:[MediaMetaData]?
    
    
    required init(json: JSON) {
        media_metadata = json["media-metadata"].array?.decode()
    }
    
}


class MediaMetaData:JSONDecodable {
    
    var format:String?
    var height:Float?
    var url:String?
    var width:Float?
    
    
    required init(json: JSON) {
        format = json["format"].stringValue
        height = json["height"].floatValue
        url = json["url"].stringValue
        width = json["width"].floatValue
    }
    
}


