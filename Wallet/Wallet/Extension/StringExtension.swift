//
//  StringExtension.swift
//  RayboWallet
//
//  Created by RayboWallet on 2018/1/8.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit
extension NSString{
    @objc public func fontSizeAndColorSubString(_ subString: String, color: UIColor, fontsize: CGFloat) -> NSMutableAttributedString {
        var start = 0
        var ranges: [NSRange] = []
        while true {
            let range = (self as NSString).range(of: subString, options: NSString.CompareOptions.literal, range: NSRange(location: start, length: (self as NSString).length - start))
            if range.location == NSNotFound {
                break
            } else {
                ranges.append(range)
                start = range.location + range.length
            }
        }
        let attrText = NSMutableAttributedString(string: self as String)
        for range in ranges {
            
            attrText.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: fontsize), range: range)
            attrText.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        }
        return attrText
    }
}
extension String {
    mutating func appendRichString(_ subString: String, color: UIColor, fontsize: CGFloat) -> NSMutableAttributedString{
        self += subString
        return self.fontSizeAndColorSubString(subString, color: color, fontsize: fontsize)
    }
    
    mutating func appendRichString(_ subString: String, color: UIColor, font: UIFont) -> NSMutableAttributedString{
        self += subString
        var attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey: Any]()
        attributes[NSAttributedStringKey.font] = font
        attributes[NSAttributedStringKey.foregroundColor] = color
        return fontSizeAndColorSubString(subString, attributes: attributes)
    }
    
    public func fontSizeAndColorSubString(_ subString: String, color: UIColor, font: UIFont) -> NSMutableAttributedString {
        var attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey: Any]()
        attributes[NSAttributedStringKey.font] = font
        attributes[NSAttributedStringKey.foregroundColor] = color
        return fontSizeAndColorSubString(subString, attributes: attributes)
    }
    
    public func addUnderline(color: UIColor, font: UIFont) -> NSMutableAttributedString{
        var subAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey: Any]()
        subAttributes[NSAttributedStringKey.font] = font
        subAttributes[NSAttributedStringKey.foregroundColor] = color
        subAttributes[NSAttributedStringKey.underlineStyle] = NSUnderlineStyle.styleSingle.rawValue
        
        return fontSizeAndColorSubString(self, attributes: subAttributes)
    }
    
    public func strikethroughStyleSubString(_ subString: String,firstString: String, color: UIColor, font: UIFont) -> NSMutableAttributedString{
        var subAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey: Any]()
        subAttributes[NSAttributedStringKey.font] = font
        subAttributes[NSAttributedStringKey.foregroundColor] = color
        subAttributes[NSAttributedStringKey.strikethroughStyle] = NSUnderlineStyle.styleSingle.rawValue
        
        var firstAttributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey: Any]()
        firstAttributes[NSAttributedStringKey.strikethroughStyle] = NSUnderlineStyle.styleNone.rawValue
        
        
        let attributedString = fontSizeAndColorSubString(subString, attributes: subAttributes)
        
        let firstStringRanges:[NSRange] = stringRange(firstString)
        for range in firstStringRanges {
            attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSUnderlineStyle.styleNone.rawValue, range: range)
        }
        
        return attributedString
    }
    
    public func fontSizeAndColorSubString(_ subString: String, attributes: [NSAttributedStringKey : Any]) -> NSMutableAttributedString {
        
        let ranges: [NSRange] = stringRange(subString)
        let attrText = NSMutableAttributedString(string: self)
        for range in ranges {
            attrText.addAttributes(attributes as [NSAttributedStringKey : Any], range: range)
        }
        return attrText
    }
    
    func stringRange(_ subString: String) -> [NSRange]{
        var start = 0
        var ranges: [NSRange] = []
        while true {
            let range = (self as NSString).range(of: subString, options: NSString.CompareOptions.literal, range: NSRange(location: start, length: (self as NSString).length - start))
            if range.location == NSNotFound {
                break
            } else {
                ranges.append(range)
                start = range.location + range.length
            }
        }
        return ranges
    }
}

extension String {
    
    func stringWidthWithSpace(font: UIFont, height: CGFloat = 15) -> CGFloat{
        return stringWidth(font: font, height: height) + 20
    }
    func stringSize(font: UIFont, maxWidht: CGFloat) -> CGSize {
        let rect: CGRect = NSString(string: self).boundingRect(with: CGSize(width: maxWidht, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return rect.size
    }
    func stringWidth(font: UIFont, height: CGFloat = 15) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func stringHight(font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func ch_heightForComment(font: UIFont, width: CGFloat, maxHeight: CGFloat) -> CGFloat {

        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    
    func ch_timeStampToString(timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="MM月dd日HH:mm"
        let date = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date as Date)
    }
    
    func emptyToNil() -> String?{
        if self == ""{
            return nil
        }
        return self
    }
}
//range转换为NSRange
extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}

extension String{
    func unicodeToString() -> String?{
        //Unicode to String
        let datadec  = self.data(using: String.Encoding.utf8)
        let decodevalue = String(data: datadec!, encoding: String.Encoding.nonLossyASCII)
        return decodevalue
    }
    
    func stringToUnicode() -> String?{
        //String to Unicode
        let datadec = self.data(using: .nonLossyASCII)
        let datadeValue = String(data: datadec!, encoding: .utf8)
        return datadeValue
    }
    
    func trimSpace() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func toDictionary() -> [String: Any]?{
        if self.utf8CString.count <= 1{
            return nil
        }
        guard let data: Data = self.data(using: .utf8) else {
            return nil
        }
        do {
            let dicAny = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            guard let dic : Dictionary = dicAny as? [String: Any] else{
                return nil
            }
            return dic
            
        } catch  {
            return nil
        }
    }
    
    func toUnichar() -> unichar{
        return (self as NSString).character(at: 0)
    }
}

extension String{
    func jsonDictionary() -> [String : Any]?{
        var dic: [String : Any]? = nil
        do {
            dic = try JSONSerialization.jsonObject(with: self.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any]
        } catch  {
            return nil
        }
        return dic
    }
    
    func jsonArray() -> [Any]?{
        var arr: [Any]? = nil
        do {
            arr = try JSONSerialization.jsonObject(with: self.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
        } catch  {
            return nil
        }
        return arr
    }
}

extension String{
    
    func appVersion() -> Double{
        var version: Double = 0.0
        let results: [Substring] = self.split(separator: ".")
        
        func poewr(p: Int) -> Double{
            return pow(100, Double(p))
        }
        
        var index: Int = 0
        for item in results.reversed() {
            if let sub: Double = Double(item) {
                let pow: Double = poewr(p: index)
                version += pow * sub
            }
            index += 1
        }
        return version
    }
}

