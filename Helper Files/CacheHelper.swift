//
//  CacheHelper.swift
//  Surya-test
//
//  Created by Arinjay on 09/12/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import Foundation

class ResponseCache{

    var cache : NSCache<NSString, AnyObject>

    public static var instance:ResponseCache = {
        let responseCache = ResponseCache()
        return responseCache
    }()

    public static func get() -> ResponseCache{
        return instance
    }

    private init(){
        cache = NSCache<NSString, AnyObject>()
    }

    func writeCache(searchKey:String,result:Data){
        if cache.object(forKey: searchKey as NSString) == nil{
            cache.setObject(result as AnyObject, forKey: searchKey as NSString)
        }
    }

    func readCache(searchKey:NSString) -> Data?{
        var data:Data?
        if cache.object(forKey: searchKey as NSString) != nil{
            data = cache.object(forKey: searchKey as NSString) as? Data
        }
        return data
    }

}

