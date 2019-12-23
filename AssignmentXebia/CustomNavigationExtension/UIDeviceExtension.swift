//
//  UIDeviceExtension.swift
//  Assignment
//
//  Created by Deepak kumar on 22/12/19.
//  Copyright © 2019 Deepak kumar. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    static let modelNumber: Int =
    {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("")
        { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> Int
        { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier
            {
                case "iPod5,1":                                 return 1
                case "iPod7,1":                                 return 1
                case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return 1
                case "iPhone4,1":                               return 1
                case "iPhone5,1", "iPhone5,2":                  return 1
                case "iPhone5,3", "iPhone5,4":                  return 1
                case "iPhone6,1", "iPhone6,2":                  return 1
                case "iPhone7,2":                               return 1
                case "iPhone7,1":                               return 1
                case "iPhone8,1":                               return 1
                case "iPhone8,2":                               return 1
                case "iPhone9,1", "iPhone9,3":                  return 1
                case "iPhone9,2", "iPhone9,4":                  return 1
                case "iPhone8,4":                               return 1
                case "iPhone10,1", "iPhone10,4":                return 1
                case "iPhone10,2", "iPhone10,5":                return 1
                case "iPhone10,3", "iPhone10,6":                return 2
                case "iPhone11,2":                              return 2
                case "iPhone11,4", "iPhone11,6":                return 2
                case "iPhone11,8":                              return 2
                case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return 1
                case "iPad3,1", "iPad3,2", "iPad3,3":           return 1
                case "iPad3,4", "iPad3,5", "iPad3,6":           return 1
                case "iPad4,1", "iPad4,2", "iPad4,3":           return 1
                case "iPad5,3", "iPad5,4":                      return 1
                case "iPad6,11", "iPad6,12":                    return 1
                case "iPad7,5", "iPad7,6":                      return 1
                case "iPad2,5", "iPad2,6", "iPad2,7":           return 1
                case "iPad4,4", "iPad4,5", "iPad4,6":           return 1
                case "iPad4,7", "iPad4,8", "iPad4,9":           return 1
                case "iPad5,1", "iPad5,2":                      return 1
                case "iPad6,3", "iPad6,4":                      return 1
                case "iPad6,7", "iPad6,8":                      return 1
                case "iPad7,1", "iPad7,2":                      return 1
                case "iPad7,3", "iPad7,4":                      return 1
                case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return 1
                case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return 1
                case "AppleTV5,3":                              return 1
                case "AppleTV6,2":                              return 1
                case "AudioAccessory1,1":                       return 1
                case "i386", "x86_64":                          return mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!)
                default:                                        return 1
            }
            #elseif os(tvOS)
            switch identifier
            {
                case "AppleTV5,3": return 1
                case "AppleTV6,2": return 1
                case "i386", "x86_64": return mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!)
                default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}
