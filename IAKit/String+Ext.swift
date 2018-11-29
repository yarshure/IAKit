//
//  String+Ext.swift
//  IAKit
//
//  Created by yarshure on 2018/11/29.
//  Copyright © 2018 yarshure. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    var removeWhite:String {
        return self.trimmingCharacters(in:NSCharacterSet.whitespaces)
    }
    var removingWhitespaces: String {
        return components(separatedBy: .whitespaces).joined()
    }
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    //    var toRSString:NSAttributedString {
    //        let n = bi + " " + self
    //        let s = NSMutableAttributedString(string: n)
    //
    //        s.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.gray,NSAttributedString.Key.font:UIFont.init(name: "Telenor-Bold", size: 18)! as UIFont], range: NSRange.init(location: 0, length: 2))
    //        return s
    //    }
}
