//
//  ResourceDetailsViewController.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 02/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import UIKit

class ResourceDetailsViewController: UIViewController //, UITabBarControllerDelegate, UITabBarDelegate {
{
    @IBOutlet weak var resourceDescriptionTextView: UITextView!
    @IBOutlet weak var resourceTitleLabel: UILabel!
    @IBOutlet weak var resourceImageView: UIImageView!
    var selectedResource : Resources = Resources()
    
    let contentView = UIView()
    var selectedViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.delegate = self
        
//        view.addSubview(contentView)

        selectedResource = Config.selectedResource
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        populateView()
    }
    
    func populateView()
    {
        resourceTitleLabel.text = selectedResource.resourceTitle
       // resourceDescriptionTextView.text = selectedResource.resourceDesc
       print("dec",selectedResource.resourceDesc)
        resourceDescriptionTextView.attributedText = selectedResource.resourceDesc?.htmlToAttributedString
        resourceImageView.image = UIImage(named: "placeholder")
        resourceImageView.downloadImageFrom(link: selectedResource.photoPath ?? "", contentMode: UIView.ContentMode.scaleAspectFit)

    }
    // UITabBarDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let tabBarIndex = tabBarController.selectedIndex
//        if tabBarIndex == 1 {
//            //do your stuff
//
//
//
//        }
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
