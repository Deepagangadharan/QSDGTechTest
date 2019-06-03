//
//  AddressViewController.swift
//  QSTechSample
//
//  Created by Gangadharan, Deepa  on 03/06/2019.
//  Copyright © 2019 Gangadharan, Deepa. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var selectedResource : Resources = Resources()
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var noAddressLabel: UILabel!
    private let addressCell = "addressCell"
    var addressArray = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectedResource = Config.selectedResource
        
        populateView()
    }
    func populateView()
    {
       // addressArray = selectedResource.addresses ?? NSSet()
        
        for case let address as Address in selectedResource.addresses ?? NSMutableSet()  {
            
            addressArray.append(address)
            
        }
        
        if addressArray.count == 0 {
            noAddressLabel.isHidden = false
            addressTableView.isHidden = true
        }
        else
        {
            noAddressLabel.isHidden = true
            addressTableView.isHidden = false
            
        }
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addressArray.count 
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: addressCell, for: indexPath) as! ContactTableViewCell
      
        let address : Address = addressArray[indexPath.row]
        
        
        cell.cellBgView.backgroundColor = UIColor.clear
        cell.headerLabel.text =  address.addressLine1
    
        var addressString = address.city
        addressString?.append(contentsOf: " , ")
        addressString?.append(contentsOf: address.country ?? " ")
        addressString?.append(contentsOf: " , ")
        addressString?.append(contentsOf: address.zipcode ?? " ")
        
        cell.valueLabel.text = addressString
        cell.valueLabel.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        cell.valueLabel.numberOfLines = 0

        return cell
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
