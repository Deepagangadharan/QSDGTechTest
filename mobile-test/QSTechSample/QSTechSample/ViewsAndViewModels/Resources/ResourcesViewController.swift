//
//  ResourcesViewController.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 01/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation
import UIKit

class ResourcesViewController : UITableViewController {
    
    private let categoryCell = "categoryCell"
    var isLoading:Bool = false
    @IBOutlet weak var resourceDetailsTableView: UITableView!
    
    private let presenter = ResourcesPresenter(service: ResourcesService())
    var selectedResource : Resources = Resources()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        populateView()
    }
    
    func populateView()
    {
        resourceDetailsTableView.reloadData()
    }
}

extension ResourcesViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCell, for: indexPath) as! CategoryTableViewCell
        
//        let category = categories[indexPath.row]
//
//        cell.backgroundColor = UIColor.red
//        cell.categoryLabel.text =  category.categoryTitle
//        print("titl",category.categoryTitle)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
}


extension ResourcesViewController:ResourcesView{
    
    func showError(error: QSError) {
        if isLoading{
            stopLoading()
        }
        
        let alert = UIAlertController(title: "Error", message: error.toString(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func stopLoading() {
        isLoading = false
        dismissHUD(isAnimated: true)
    }
    
    func startLoading() {
        isLoading = true
        showHUD(progressLabel: "Refreshing...")
    }
    
    func submissionSuccessMessage()
    {
       
    }
}
