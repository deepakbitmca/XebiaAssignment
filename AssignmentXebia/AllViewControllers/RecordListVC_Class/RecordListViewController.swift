//
//  RecordListViewController.swift
//  AssignmentXebia
//
//  Created by Deepak Chauhan on 12/22/19.
//  Copyright © 2019 Deepak Chauhan. All rights reserved.
//

import UIKit
import MMDrawerController

class RecordListViewController: UIViewController {
    
    @IBOutlet weak var tableViewRecordList: UITableView!
    
    var arrayRecordList = [[String : Any]]()
    var records = [RecordListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUiColorOrControles()
    }
    
    // MARK: - Set Ui Colors
    func setUiColorOrControles() {
        let _ = self.setCustomNavigationbar(With: "NY Times Most Populers"  ,
                                            menuButton:true,
                                            backButtonRequired: false ,
                                            DottedButtonRequired: false ,
                                            LoginButtonRequired: false ,
                                            LanguageButtonRequired: false)
        getRecordList()
    }

  
}




// MARK:- Load Data
extension RecordListViewController {
    
    // MARK: - Get RecordList
    func getRecordList() {
        DispatchQueue.main.async {
            AppDelegate.currentDelegate().addLoading()
        }
        self.perform(#selector(getRecordListDelay), with: nil, afterDelay: 0.1)
    }
    
    @objc func getRecordListDelay() {
        if (isNetworkAvailable) {
            ConnectionManager.sharedInstance.getDataRequest(inputParameter: "", serviceName: "api-key=6eKJOzCYZkuFsMi6rvjXjRY7WcbrGaMf", httpMethod: "GET", dataPost: nil, completionHandler: { (result , status:Bool) -> Void in
                if (result != nil && status) {
                    let json = JSON.init(result!)
                    print(json)
                    self.records = json["results"].array?.decode() ?? []
                    DispatchQueue.main.async {
                        AppDelegate.currentDelegate().removeLoading()
                        self.tableViewRecordList.reloadData()
                    }
                }
            }, faliour: { (errorMessage , status:Bool) -> Void in
                DispatchQueue.main.async {
                    AppDelegate.currentDelegate().removeLoading()
                }
                Macros.showAlertOnWindow(_titleMessage: "", _messageBody: errorMessage! as String, leftButton: "", rightButton: "", okButton: "Ok")
            })
        }
        else {
            DispatchQueue.main.async {
                AppDelegate.currentDelegate().removeLoading()
            }
            Macros.showAlertOnWindow(_titleMessage: "", _messageBody: Macros.netWorkNotAvilable as String, leftButton: "", rightButton: "", okButton: "Ok")
        }
    }
}





// MARK: - CustomNavigationBar Protocol
extension RecordListViewController: NavigationBarProtocol
{
    func backButtonAction(){
        AppDelegate.currentDelegate().drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        
    }
    
    func loginButtonAction(){
        
    }
    
    func changeLanguageButtonAction(){
        
    }
    
    func dottedButtonAction(){
        
    }
    
}





// MARK: - Table View Delegate
extension RecordListViewController : UITableViewDelegate, UITableViewDataSource {
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = self.tableViewRecordList.dequeueReusableCell(withIdentifier: "Cell") as! RecordListTableCell
        
        let viewBG = UIView()
        viewBG.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
        //viewBG.backgroundColor = Macros.primaryColor
        cell.selectedBackgroundView = viewBG
        
        cell.viewCellBG.layer.shadowColor = UIColor.black.cgColor
        cell.viewCellBG.layer.shadowOpacity = 0.25
        cell.viewCellBG.layer.shadowRadius = 3
        cell.viewCellBG.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        let record = records[indexPath.row]
        
        //For Title
        cell.lblTitle.text = record.title
        
        cell.imgModuleIcon.layer.cornerRadius = cell.imgModuleIcon.frame.size.width/2
        if let iamgeUrl = record.media?.first?.media_metadata?.first?.url {
            DispatchQueue.global(qos: .userInitiated).async {
                let imageData = ImageUtility.shared()?.getImageFromUrl(iamgeUrl)
                let image = UIImage(data: imageData! as Data)
                DispatchQueue.main.async {
                    cell.imgModuleIcon.image = image
                }
            }
        }

        //For Sub Title
        cell.lblSubTitle.text = record.abstract
        
        //For Sub Title
        cell.lblName.text = record.type
        
        //For Date
        cell.lblDate.text = record.published_date
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailVC", sender: nil)
    }
    
}
