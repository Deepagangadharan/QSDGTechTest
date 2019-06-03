//
//  ContactViewController.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 03/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    var selectedResource : Resources = Resources()
    @IBOutlet weak var contactsTableView: UITableView!
    private let contactCell = "contactCell"
    private var contactDictionary = [Int: [String: String]] ()//[String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedResource = Config.selectedResource
        
        populateView()
    }
    
    func populateView()
    {
        var i = 0
        if ((selectedResource.contacts?.phoneNumber) != nil && (selectedResource.contacts?.phoneNumber)?.count != 0) {
            contactDictionary[i] =   ["PHONE NUMBER": selectedResource.contacts?.phoneNumber] as? [String : String]
            i = i + 1
        }
        if ((selectedResource.contacts?.tollFree) != nil && (selectedResource.contacts?.tollFree)?.count != 0 ) {
            contactDictionary[i] =   ["TOLL FREE NUMBER": selectedResource.contacts?.tollFree] as? [String : String]
            i = i + 1
        }
        if ((selectedResource.contacts?.faxNumber) != nil && (selectedResource.contacts?.faxNumber)?.count != 0) {
            contactDictionary[i] =   ["FAX NUMBER": selectedResource.contacts?.faxNumber] as? [String : String]
            i = i + 1
        }
        if ((selectedResource.contacts?.email) != nil && (selectedResource.contacts?.email)?.count != 0) {
            contactDictionary[i] =   ["E MAIL ADDRESS": selectedResource.contacts?.email] as? [String : String]
            i = i + 1
        }
        if ((selectedResource.contacts?.website) != nil && (selectedResource.contacts?.website)?.count != 0) {
            contactDictionary[i] =   ["WEBSITE": selectedResource.contacts?.website] as? [String : String]
            i = i + 1
        }
        print("\\8 ",contactDictionary,selectedResource.contacts)
        contactsTableView.reloadData()
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    }

    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactDictionary.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCell, for: indexPath) as! ContactTableViewCell
        let transactionDictionary = contactDictionary[indexPath.row]
        
        
        cell.cellBgView.backgroundColor = UIColor.clear
        cell.headerLabel.text =  transactionDictionary?.keys.first
        cell.valueLabel.text =  transactionDictionary?.values.first
        
        switch transactionDictionary?.keys.first {
        case "WEBSITE":
            cell.contactButton1.setImage(UIImage(named: ""), for: UIControl.State.normal)
            cell.contactButton2.setImage(UIImage(named: "websiteIcon"), for: UIControl.State.normal)
        case "E MAIL ADDRESS":
            cell.contactButton1.setImage(UIImage(named: ""), for: UIControl.State.normal)
            cell.contactButton2.setImage(UIImage(named: "emailIcon"), for: UIControl.State.normal)
        case "PHONE NUMBER":
            
            cell.contactButton1.setImage(UIImage(named: "messageIcon"), for: UIControl.State.normal);      cell.contactButton2.setImage(UIImage(named: "phoneIcon"), for: UIControl.State.normal)
        case "FAX NUMBER":
            cell.contactButton1.setImage(UIImage(named: ""), for: UIControl.State.normal)
            cell.contactButton2.setImage(UIImage(named: ""), for: UIControl.State.normal)
        case "TOLL FREE NUMBER":
            cell.contactButton1.setImage(UIImage(named: "messageIcon"), for: UIControl.State.normal);      cell.contactButton2.setImage(UIImage(named: "phoneIcon"), for: UIControl.State.normal)
        default:
            print("do nothing")
        }
        
        //return value from callback
        cell.button1Callback = {
            self.button1Action(index: indexPath.row)
        }
        
        cell.button2Callback = {
            self.button2Action(index: indexPath.row)
        }
        
        return cell
    }
    
    func button1Action(index : Int)  {
        
        let transactionDictionary = contactDictionary[index]
        
        switch transactionDictionary?.keys.first {
        case "PHONE NUMBER":
            displayMessageInterface(strPhoneNumber: ((transactionDictionary?.values.first)!))
        case "TOLL FREE NUMBER":
            displayMessageInterface(strPhoneNumber: ((transactionDictionary?.values.first)!))
        default:
            print("do nothing")
        }
    }
    
    func button2Action(index : Int)  {
        
        let transactionDictionary = contactDictionary[index]
        switch transactionDictionary?.keys.first {
        case "WEBSITE":
            let webViewVC = WebViewController()
            webViewVC.urlString = ((transactionDictionary?.values.first)!)
            print("url ", webViewVC.urlString)
            let navCon = UINavigationController(rootViewController: webViewVC)
          //  self.navigationController?.present(navCon, animated: true, completion: nil)
            self.navigationController?.pushViewController(webViewVC, animated: true)
            
        case "E MAIL ADDRESS":
            launchEmail(sender: (transactionDictionary?.values.first)!)
        case "PHONE NUMBER":
            makePhoneCall(strPhoneNumber: ((transactionDictionary?.values.first)!))
        case "TOLL FREE NUMBER":
            makePhoneCall(strPhoneNumber: ((transactionDictionary?.values.first)!))
        default:
            print("do nothing")
        }
    }
    
    func displayMessageInterface(strPhoneNumber : String) {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = [strPhoneNumber]
        composeVC.body = "Request for QS"
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }
    
    func makePhoneCall(strPhoneNumber : String) {
        if let phoneCallURL:URL = URL(string: "tel:\(strPhoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                let alertController = UIAlertController(title: "QS Sample", message: "Are you sure you want to call \n\(strPhoneNumber)?", preferredStyle: .alert)
                let yesPressed = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    //         application.openURL(phoneCallURL)
                    application.open(phoneCallURL, options: [:], completionHandler:nil)
                    
                })
                let noPressed = UIAlertAction(title: "No", style: .default, handler: { (action) in
                    
                })
                alertController.addAction(yesPressed)
                alertController.addAction(noPressed)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func launchEmail(sender: String) {
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "Request"
            let messageBody = "Resource details"
            let toRecipents = [sender]
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(emailTitle)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipents)
            
            self.present(mc, animated: true, completion: nil)
        } else {
            print("Cannot send mail")
            // give feedback to the user
        }
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Error: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
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
