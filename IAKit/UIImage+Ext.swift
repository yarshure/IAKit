//
//  UIImage+Ext.swift
//  IAKit
//
//  Created by yarshure on 2018/11/29.
//  Copyright © 2018 yarshure. All rights reserved.
//

import UIKit

extension UIColor {
    public func image() -> UIImage {
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(1.0))
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(self.cgColor)
            context.fill(rect)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    public static func imageGradient(colors:[CGFloat],size:CGSize) ->UIImage?{
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        //创建clip矩形
        let rect1 = CGRect(x: 0, y: 0,
                           width: size.width, height: size.height)
        //        let rect2 = CGRect(x: self.bounds.maxX/4, y: self.bounds.maxY/2,
        //                           width: self.bounds.width/4, height: self.bounds.height/2)
        //        let rect3 = CGRect(x: self.bounds.maxX/2, y: 0,
        //                           width: self.bounds.width/4, height: self.bounds.height/2)
        //        let rect4 = CGRect(x: self.bounds.maxX/4*3, y: self.bounds.maxY/2,
        //                           width: self.bounds.width/4, height: self.bounds.height/2)
        context.clip(to: [rect1])
        
        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //颜色数组（这里使用三组颜色作为渐变）fc6820
        //        let compoents:[CGFloat] = [0xfc/255, 0x68/255, 0x20/255, 1,
        //                                   0xfe/255, 0xd3/255, 0x2f/255, 1,
        //                                   0xb1/255, 0xfc/255, 0x33/255, 1]
  
        if colors.isEmpty {
//            colors = [
//                0xFA / 255.0, 0x7f / 255.0, 0x67 / 255.0, 1.00,
//                //0xb5 / 255.0,  0x3a / 255.0, 0x40 / 255.0, 1.00,
//                // 29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
//                0xb5 / 255.0,  0x3a / 255.0, 0x40 / 255.0, 1.00
//            ]
        }
        //没组颜色所在位置（范围0~1)
        let locations:[CGFloat] = [0,1]
        //生成渐变色（count参数表示渐变个数）
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors,
                                  locations: locations, count: locations.count)!
        
        //渐变开始位置
        let start = CGPoint(x: 0, y: 0)
        //渐变结束位置
        let end = CGPoint(x: size.width, y: size.height)
        //绘制渐变
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: .drawsBeforeStartLocation)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
