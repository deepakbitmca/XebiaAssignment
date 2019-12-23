//
//  DetailViewController.swift
//  AssignmentXebia
//
//  Created by Deepak Chauhan on 12/23/19.
//  Copyright © 2019 Deepak Chauhan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUiColorOrControles()
        }
        
        // MARK: - Set Ui Colors
        func setUiColorOrControles() {
            let _ = self.setCustomNavigationbar(With: "Detail Page"  ,
                                                menuButton:false,
                                                backButtonRequired: true ,
                                                DottedButtonRequired: false ,
                                                LoginButtonRequired: false ,
                                                LanguageButtonRequired: false)
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - CustomNavigationBar Protocol
extension DetailViewController: NavigationBarProtocol
{
    func backButtonAction(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func loginButtonAction(){
        
    }
    
    func changeLanguageButtonAction(){
        
    }
    
    func dottedButtonAction(){
        
    }
    
}
