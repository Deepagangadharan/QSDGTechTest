//
//  ResourcesListViewController.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 02/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation
import UIKit

class ResourcesListViewController : UITableViewController {
    
    private let resourceCell = "categoryCell"
    var isLoading:Bool = false
    var isAscending:Bool = true
    @IBOutlet weak var resourceListTableView: UITableView!
    var categorySlug:String = ""
    var categoryEid:String = ""
    
    private let presenter = ResourcesPresenter(service: ResourcesService())
    var resources = [Resources]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortResources))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resources = Categories.getResources(categoryEid: categoryEid, isAscending: isAscending)
        
        if (resources.count == 0) {
            presenter.sync()
        }
        
        populateView()
    }
    
    func populateView()
    {
        resourceListTableView.reloadData()
    }
    
    @objc func sortResources() {
        isAscending = !isAscending
        
        resources = Categories.getResources(categoryEid: categoryEid, isAscending: isAscending)
        
        populateView()
    }
}

extension ResourcesListViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: resourceCell, for: indexPath) as! CategoryTableViewCell
        
        let category = resources[indexPath.row]
        
        cell.cellBgView.backgroundColor = UIColor(red: 33/256, green: 102/256, blue: 102/256, alpha: 1)
        cell.categoryLabel.text =  category.resourceTitle
        
        cell.categoryImageView.image = UIImage(named: "placeholder")
        cell.categoryImageView.downloadImageFrom(link: category.photoPath ?? "", contentMode: UIView.ContentMode.scaleAspectFit)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedResource = resources[indexPath.row]
        Config.selectedResource = selectedResource
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "resourceTabView") as! ResourceTabbarViewController
        nextViewController.selectedResource = selectedResource
        self.navigationController?.pushViewController(nextViewController, animated:true)
        
       
        
    }
    
}


extension ResourcesListViewController:ResourcesView{
    
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
        DispatchQueue.main.async {
            
            self.resources = Categories.getResources(categoryEid: self.categoryEid, isAscending: self.isAscending)
            
            self.populateView()
        }
    }
}
