//
//  ArrayExtension.swift
//  AsteroidVPN-iOS
//
//  Created by yidahis on 2018/1/31.
//  Copyright © 2018年 Maynard. All rights reserved.
//

import Foundation

extension Array {
    func jsonData() -> Data?{
        var data: Data? = nil
        do {
             data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch  {
            return nil
        }
        return data
    }
    
    func jsonString() -> String?{
        if let data = self.jsonData(){
            return String.init(bytes: data, encoding: String.Encoding.utf8)
        }else{
            return nil
        }
    }
}
