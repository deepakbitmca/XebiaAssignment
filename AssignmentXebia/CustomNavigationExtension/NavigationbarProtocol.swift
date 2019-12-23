//
//  NavigationbarProtocol.swift
//  Assignment
//
//  Created by Deepak kumar on 22/12/19.
//  Copyright © 2019 Deepak kumar. All rights reserved.
//

import UIKit

@objc public protocol NavigationBarProtocol: class
{
    func backButtonAction()
    func loginButtonAction()
    func changeLanguageButtonAction()
    func dottedButtonAction()
}
