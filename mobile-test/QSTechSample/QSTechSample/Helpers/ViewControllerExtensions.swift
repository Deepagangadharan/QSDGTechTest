//
//  ViewControllerExtensions.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 31/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController{
    func showHUD(progressLabel:String){
        DispatchQueue.main.async {
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = progressLabel
        }
    }
    
    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
    
    func addStandardCancel(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onStandardCancel))
    }
    
    @objc func onStandardCancel(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Alerts
    
    func showWarningAlert(message:String, actions:[UIAlertAction]?){
        showAlert(title: NSLocalizedString("Warning", comment: ""), message: message, actions: actions)
    }
    
    func showErrorAlert(message:String, actions:[UIAlertAction]?){
        showAlert(title: NSLocalizedString("Error", comment: ""), message: message, actions: actions)
    }
    
    func showAlert(title:String, message:String, actions:[UIAlertAction]?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if actions != nil {
            for action in actions!{
                alert.addAction(action)
            }
        }
        
        self.present(alert, animated: true)
    }
    
    func background(work: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            work()
        }
    }
    
    func main(work: @escaping () -> ()) {
        DispatchQueue.main.async {
            work()
        }
    }
}
