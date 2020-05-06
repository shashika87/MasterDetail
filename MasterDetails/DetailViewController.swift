//
//  ViewController.swift
//  MasterDetails
//
//  Created by Shashi Kant on 5/3/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit
var masterTableViewcontroller : MasterTableViewController = MasterTableViewController()
private let client = HTTPClient()
var isPotrait = true
var masterBottomMargin = CGFloat(60.0)
class DetailViewController: UIViewController, MasterViewDelegate {
    lazy var detailView: DetailView = {
        return DetailView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor=UIColor.white;
        self.title = "Detail"
        
        let hamburgerBarButtonItem = UIBarButtonItem(title: "☰", style: .plain, target: self, action: #selector(toggleMenu))
        self.navigationItem.leftBarButtonItem  = hamburgerBarButtonItem
        
        masterTableViewcontroller.tableView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 250, height: UIScreen.main.bounds.height-masterBottomMargin))
        
        if self.view.frame.size.width > self.view.frame.size.height {
            masterTableViewcontroller.tableView.frame.size.height = UIScreen.main.bounds.height-10
        }
        
        self.edgesForExtendedLayout = UIRectEdge.bottom
        
        navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(87/255.0), green: CGFloat(182/255.0), blue: CGFloat(183/255.0), alpha: CGFloat(1.0))
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func loadView() {
        
        view = detailView
        detailView.client = client
        
        masterTableViewcontroller.client = client
        masterTableViewcontroller.delegate = self
        
        self.addChild(masterTableViewcontroller)
        self.view.addSubview(masterTableViewcontroller.view)
        self.view.frame = masterTableViewcontroller.view.bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.didMove(toParent: masterTableViewcontroller)
        
        
        let hamburgerBarButtonItem = UIBarButtonItem(title: "☰", style: .plain, target: self, action: #selector(toggleMenu))
        self.navigationItem.leftBarButtonItem  = hamburgerBarButtonItem
        
        client.getResult(from: .uidType) { [weak self] result in
            switch result {
            case .success(let uidList):
                guard let uidListResults = uidList?.data.list else { return }
                masterTableViewcontroller.uidListResult = uidListResults;
                masterTableViewcontroller.tableView.reloadData();
                guard let uidItem = uidList?.data.list[0] else { return }
                self!.detailView.updateDetailView(uidItem)
                self?.title = uidItem.uid
                //self?.toggle()
                //Update image
                self?.uidItemSelected(uidItem)
                
            //print(uidListResults)
            case .failure(let error):
                print("the error \(error)")
            }
        }

    }
    
    
    @objc func toggleMenu(sender:UIBarButtonItem){
        toggle()
    }
    
    func toggle(){
        UIView.animate(withDuration: 0.5, delay: 0.25, options: UIView.AnimationOptions(), animations: { () -> Void in
            if(masterTableViewcontroller.tableView.frame.origin.x == 0){
                masterTableViewcontroller.tableView.frame = CGRect(origin: CGPoint(x: -masterTableViewcontroller.tableView.frame.width, y: 0), size: CGSize(width: 250, height: masterTableViewcontroller.view.frame.height))
            } else {
                masterTableViewcontroller.tableView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 250, height: masterTableViewcontroller.view.frame.height))
            }
        }, completion: { (finished: Bool) -> Void in
            
        })
        
        
        
        
    }
    
    func uidItemSelected(_ uidItem: UIDItem) {
        self.detailView.imageView.image=nil;
        self.detailView.activityViewIndicator.startAnimating()
        self.detailView.updateDetailView(uidItem)
        //update image
        let url = URL(string:uidItem.path)!
        client.loadImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.detailView.updateImage(image)
            case .failure(let error):
                print("the error \(error)")
            }
        }
        if self.view.frame.size.width < self.view.frame.size.height {
            toggle()
        }
        
        self.title = uidItem.uid
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(masterTableViewcontroller.tableView.frame.origin.x == 0){
            toggle()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    func orientationChanged() {
        // this was split out because of other app-specific logic
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if (size.width > self.view.frame.size.width) {
            DispatchQueue.main.async {
                masterTableViewcontroller.tableView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 250, height: masterTableViewcontroller.view.frame.height))
                masterTableViewcontroller.tableView.frame.size.height = UIScreen.main.bounds.height-masterBottomMargin
            }
            isPotrait=false
            print("Landscape")
            
            
        } else {
            isPotrait=true
            print("Portrait")
            masterTableViewcontroller.tableView.frame.size.height = UIScreen.main.bounds.height-masterBottomMargin
        }
        
        if (size.width != self.view.frame.size.width) {
            DispatchQueue.main.async {
                masterTableViewcontroller.tableView.reloadData()
            }
        }
        
        
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
