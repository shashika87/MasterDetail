//
//  Master.swift
//  MasterDetails
//
//  Created by Shashi Kant on 5/3/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit

protocol MasterViewDelegate {
    func uidItemSelected(_ uidItem:UIDItem)
}

class MasterTableViewController: UITableViewController {
    var delegate: MasterViewDelegate?
    var uidListResult : [UIDItem]?
    weak var client : HTTPClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 230;
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.register(MasterTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor=UIColor(red: CGFloat(87/255.0), green: CGFloat(182/255.0), blue: CGFloat(183/255.0), alpha: CGFloat(1.0))
    }
    
    override func loadView() {
        super.loadView()
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return uidListResult?.count ?? 0
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let masterTableViewCell : MasterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MasterTableViewCell
        // Configure the cell...
        let uidItem = uidListResult?[indexPath.row]
        masterTableViewCell.labelUID.text = uidItem?.uid
        //
        client.loadImage(from: URL(string:uidItem?.thumb ?? "")!) {  result in
            switch result {
            case .success(let imageData):
                masterTableViewCell.imageViewUID.image = imageData
                masterTableViewCell.activityViewIndicator.stopAnimating()
            case .failure(let error):
                print("the error \(error)")
            }
        }
        
        return masterTableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedItem = uidListResult?[indexPath.row] else { return }
        
        if(delegate != nil){
            self.delegate?.uidItemSelected(selectedItem)
        }
        
    }
    
    override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
        
    }
    
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}



