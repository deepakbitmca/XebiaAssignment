//
//  CustomNavigationBarOnUIViewControllerExtension.swift
//  Assignment
//
//  Created by Deepak kumar on 22/12/19.
//  Copyright © 2019 Deepak kumar. All rights reserved.
//

import UIKit

extension NavigationBarProtocol where Self: UIViewController
{
    func setCustomNavigationbar(With title: String , menuButton ismenuButton: Bool, backButtonRequired isBackButtonRequired: Bool , DottedButtonRequired isDottedButtonRequired: Bool , LoginButtonRequired isLoginButtonRequired: Bool , LanguageButtonRequired isLanguageButtonRequired: Bool) -> UILabel
    {
        let navigationbarFrame            = CGRect(x: Macros.NavigationbarOriginX , y: Macros.NavigationbarOriginY , width: Double(UIScreen.main.bounds.size.width) , height: Macros.NavigationbarHeight)
        let navigationbarView             = UIView(frame: navigationbarFrame)
        navigationbarView.backgroundColor = Macros.primaryColor
        
        let yCoordinate                   = Double(navigationbarFrame.size.height) - Macros.NavigationbarYBottomInset - Macros.NavigationbarBackButtonHeight
        
        let statusBar                     = UIView(frame: CGRect(x: 0 , y: 0 , width: navigationbarFrame.size.width , height: Macros.NavigationbarAppStatusBarHeight))
        statusBar.backgroundColor         = Macros.primaryColor
        navigationbarView.addSubview(statusBar)
        
        //Adding Back Button
        if ismenuButton
        {
            
            navigationbarView.addSubview(self.setButton(WithFrame: CGRect(x: Macros.NavigationbarXInset , y: yCoordinate , width: Macros.NavigationbarBackButtonWidth , height: Macros.NavigationbarBackButtonHeight) , Selector: #selector(backButtonAction) , AndImageName: Macros.NavigationBarDrawerButtonImageName))
        }
        if isBackButtonRequired
        {
            
            navigationbarView.addSubview(self.setButton(WithFrame: CGRect(x: Macros.NavigationbarXInset , y: yCoordinate , width: Macros.NavigationbarBackButtonWidth , height: Macros.NavigationbarBackButtonHeight) , Selector: #selector(backButtonAction) , AndImageName: Macros.NavigationBarBackButtonImageName))
        }
        var xCoordinateForSubViews = Double(UIScreen.main.bounds.size.width) - Macros.NavigationbarXInset - Macros.NavigationbarOtherButtonsSize
        //Adding Dotted Button
        if isDottedButtonRequired
        {
            navigationbarView.addSubview(self.setButton(WithFrame: CGRect(x: xCoordinateForSubViews , y: yCoordinate , width: Macros.NavigationbarOtherButtonsSize , height: Macros.NavigationbarOtherButtonsSize) , Selector: #selector(dottedButtonAction) , AndImageName: Macros.NavigationBarDottedButtonImageName))
        }
        
        if isLoginButtonRequired
        {
            xCoordinateForSubViews -= (Macros.NavigationbarSpacesBetweenButtons + Macros.NavigationbarOtherButtonsSize)
            //Adding Login Button
            navigationbarView.addSubview(self.setButton(WithFrame: CGRect(x: xCoordinateForSubViews , y: yCoordinate , width: Macros.NavigationbarOtherButtonsSize , height: Macros.NavigationbarOtherButtonsSize) , Selector: #selector(loginButtonAction) , AndImageName: Macros.NavigationBarLoginButtonImageName))
        }
        
        if isLanguageButtonRequired
        {
            xCoordinateForSubViews -= (Macros.NavigationbarSpacesBetweenButtons + Macros.NavigationbarOtherButtonsSize)
            //Adding Change Language Button
            navigationbarView.addSubview(self.setButton(WithFrame: CGRect(x: xCoordinateForSubViews , y: yCoordinate , width: Macros.NavigationbarOtherButtonsSize , height: Macros.NavigationbarOtherButtonsSize) , Selector: #selector(changeLanguageButtonAction) , AndImageName: Macros.NavigationBarChangeLanguageButtonImageName))
        }

        //let titleLabelWidth = Double(UIScreen.main.bounds.size.width) - (Macros.NavigationbarXInset + Macros.NavigationbarBackButtonWidth + Macros.NavigationbarTitleLabelInsetX) - (Double(UIScreen.main.bounds.size.width) - xCoordinateForSubViews) - Macros.NavigationbarTitleLabelInsetX // - (Macros.NavigationbarXInset + Macros.NavigationbarBackButtonWidth) - (2 * Macros.NavigationbarSpacesBetweenButtons) - Macros.NavigationbarXInset - (3 * Macros.NavigationbarOtherButtonsSize)
        
        //Adding Title Label
        let titleLabel = self.setTitleLabel(WithFrame: CGRect(x: Macros.NavigationbarXInset + Macros.NavigationbarBackButtonWidth + Macros.NavigationbarTitleLabelInsetX , y: yCoordinate , width: Double(UIScreen.main.bounds.size.width-100) , height: Macros.NavigationbarOtherButtonsSize) , AndTitleString: title)
        navigationbarView.addSubview(titleLabel)

        self.view.addSubview(navigationbarView)                                                                    //Added Navination Bar to view
        return titleLabel
    }
    
    func updateTitle(OnLabel label: UILabel , WithText text: String)
    {
        label.text = text
    }
    
    private func setButton(WithFrame frame: CGRect , Selector selector: Selector , AndImageName imageName: String) -> UIButton
    {
        let button   = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: imageName) , for: .normal)
        button.frame = frame
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    
    private func setTitleLabel(WithFrame frame: CGRect , AndTitleString titleString: String) -> UILabel
    {
        let titleLabel                       = UILabel()
        titleLabel.frame                     = frame
        titleLabel.text                      = titleString
        titleLabel.textAlignment             = .center
        titleLabel.textColor                 = .white
        titleLabel.font                      = UIFont(name: Macros.NavigationbarTitleFonrName , size: CGFloat(Macros.NavigationbarTitleFontSize))
        titleLabel.adjustsFontSizeToFitWidth = true
        return titleLabel
    }
}
