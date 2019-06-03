//
//  CategoriesViewController.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 30/05/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewController : UITableViewController {
    
    private let categoryCell = "categoryCell"
    var isLoading:Bool = false
    @IBOutlet weak var categoryListTableView: UITableView!
    
    private let presenter = CategoriesPresenter(service: CategoriesService())
    var categories = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        categories = Categories.getCategories()
        
        if (categories.count == 0) {
            presenter.sync()
        }
        
        populateView()
    }
    
    func populateView()
    {
        categoryListTableView.reloadData()
    }
}

extension CategoriesViewController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCell, for: indexPath) as! CategoryTableViewCell
        
        let category = categories[indexPath.row]
        
        cell.cellBgView.backgroundColor = UIColor(red: 84/256, green: 38/256, blue: 6/256, alpha: 1)
        cell.categoryLabel.text =  category.categoryTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = categories[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "resourceListSegue") as! ResourcesListViewController
        nextViewController.categoryEid = category.eid!
        self.navigationController?.pushViewController(nextViewController, animated:true)
        
        
    }
    
}


extension CategoriesViewController:CategoriesView{
    
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
            
            self.categories = Categories.getCategories()
            
            self.populateView()
        }
    }
}
