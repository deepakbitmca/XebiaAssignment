//
//  Macros.swift
//  Print4Me
//
//  Created by Sumit Makkar on 22/12/19.
//  Copyright © 2019 Deepak kumar. All rights reserved.
//

import UIKit
import Foundation
//import CoreBluetooth

typealias closer = () -> ()

//For Check Network Status from UserDefaults
var isNetworkAvailable:Bool = false

@objcMembers class Macros: NSObject
{
    //MARK: - API URL
    @objc static let MainURL = "https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?"
    
    //For Messaging Constent
    static let netWorkNotAvilable : NSString = "Please check your internet connectivity."
    
    //MARK: - Storyboard
    static let LoginRegistrationStoryboardName              = "LoginRegistration"
    
    //MARK: - Navigation bar button dimesions
    static let NavigationbarXInset                                       = 8.0
    static let NavigationbarYBottomInset                                 = 10.0
    static let NavigationbarOriginX                                      = 0.0
    static let NavigationbarOriginY                                      = 0.0
    static let NavigationbarHeight                                       = UIDevice.modelNumber == 1 ? 70.0 : 90.0
    static let NavigationbarAppStatusBarHeight: CGFloat                  = UIDevice.modelNumber == 1 ? 20.0 : 35.0
    static let NavigationbarBackButtonWidth                              = 35.0
    static let NavigationbarBackButtonHeight                             = 30.0
    static let NavigationbarOtherButtonsSize                             = 30.0
    static let NavigationbarSpacesBetweenButtons                         = 15.0
    static let NavigationbarTitleLabelInsetX                             = 5.0
    static let NavigationDrawerTableViewHeaderHeight:CGFloat             = 50.0
    static let NavigationDrawerFooterHeight: CGFloat                     = 1.0
    static let NavigationDrawerFooterViewBackgroundColor                 = UIColor.gray
    static let NavigationDrawerHeaderTitleColor                          = UIColor.gray
    static let NavigationDrawerHeaderLabelXInset: CGFloat                = 20.0
    static let FirstOutletTopConstraintToNavigationBarInIphoneX: CGFloat = 20.0 //Difference of NavigationbarHeight(above Macro) in iphoneX and others
    
    //MARK: - Font names and sizes
    static let NavigationbarTitleFonrName          = "HelveticaNeue-Bold"
    static let NavigationbarTitleFontSize: CGFloat = 20.0
    
    //MARK: - Image References
    static let NavigationBarDrawerButtonImageName         = "NavigationDrawerButtonIcon"
    static let NavigationBarBackButtonImageName           = "backIcon"
    static let NavigationBarDottedButtonImageName         = "DotsIcon"
    static let NavigationBarLoginButtonImageName          = "LockIcon"
    static let NavigationBarChangeLanguageButtonImageName = "LanguageChangeIcon"
    
    //MARK: - Color Macros
    static let placeHolderColorColor   = UIColor.init(named: "PlaceHolderColor")
    static let primaryColor       = UIColor.init(named: "PrimaryColor")
    static let graiesColor       = UIColor.init(named: "GrayiesColor")
    static let selectColor       = UIColor.init(named: "SelectColor")
    static let colorLightSkye       = UIColor.init(named: "LightSkyColor")
    
    //MARK: - NSUserdefault references
    static let UserDefaultsLoginUserName   = "loginUserName"
    static let UserDefaultsIsLogin   = "is_Login"
    static let UserDefaultsUserId   = "user_id"
    static let UserDefaultsSelectedModule   = "selectedModule"
    static let UserDefaultsUserGroup  = "userGroup"
    static let UserDefaultsAccessToken  = "access_token"
    static let UserDefaultsBusinessId  = "business_id"
    static let UserDefaultsDeviceToken  = "DeviceTokenKey"
    static let UserDefaultsPhoneNumber  = "phoneNumber"
    
    // MARK: - Alert Function
    static func showAlertOnWindow(_titleMessage:String, _messageBody:String, leftButton:String, rightButton:String, okButton:String, closerName:closer? = nil) {
        let alert = UIAlertController(title: _titleMessage, message: _messageBody, preferredStyle: UIAlertController.Style.alert)
        if (okButton == "") {
        alert.addAction(UIAlertAction(title: leftButton, style: .default, handler: { action in
        
        }))
        alert.addAction(UIAlertAction(title: rightButton, style: .default, handler: { action in
        
        }))
    }
    else {
        alert.addAction(UIAlertAction(title: okButton, style: .default, handler: { action in
            closerName?()
        }))
    }
        AppDelegate.currentDelegate().window?.rootViewController?.present(alert, animated: false, completion: nil)
    }
    
    // MARK: - Email Validation Function
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
