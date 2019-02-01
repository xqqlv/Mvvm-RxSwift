//
//  MenuBean.swift
//  takeaway
//
//  Created by 徐强强 on 2018/3/20.
//  Copyright © 2018年 zaihui. All rights reserved.
//

import Foundation
import ObjectMapper

public struct GroupModel: Mappable {
    var name: String!
    
    public init?(map: Map) {
        
    }
    
    mutating public func mapping(map: Map) {
        name <- map["name"]
    }
    
}
