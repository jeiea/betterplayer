//
//  ErrorTransformer.swift
//  better_player
//
//  Created by jeiea on 2021/08/17.
//

import Foundation

@objc
public class ErrorTransformer : NSObject {
    public static func getMapFromNSError(_ error: Error?) -> [AnyHashable : Any]? {
        guard let nsError = error as NSError? else {
            return nil;
        }
        
        var userInfo: [AnyHashable : Any] = [:]
        for (key, value) in nsError.userInfo {
            if let error = value as? NSError {
                userInfo[key] = ErrorTransformer.getMapFromNSError(error);
            }
            else if let url = value as? NSURL {
                userInfo[key] = url.absoluteString;
            }
            else {
                userInfo[key] = value;
            }
        }
        
        return [
            "code" : nsError.code,
            "domain" : nsError.domain,
            "userInfo" : userInfo
        ];
    }
}
