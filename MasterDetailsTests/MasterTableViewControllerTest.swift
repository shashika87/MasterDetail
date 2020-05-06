//
//  MasterTableViewControllerTest.swift
//  MasterDetailsTests
//
//  Created by Shashi Kant on 5/5/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import XCTest
@testable import MasterDetails


class MasterTableViewControllerTest: XCTestCase {
    
    var masterTableViewControllerTest: MasterTableViewController!
     let client = HTTPClient()
    override func setUp() {
        super.setUp()
        
       
        
        let uidItem1 = UIDItem(uid: "inside_trunk", type: TypeEnum(rawValue: "img")!, path: "https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_oDLiEj3QxhWdRwJS.jpg", thumb: "https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_oDLiEj3QxhWdRwJS_thumb.jpg", category: ["interior"], description: "")
        
        let uidItem2 = UIDItem(uid: "charging_cables", type: TypeEnum(rawValue: "img")!, path: "https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_T5K3CmWR41NGpwde.jpg", thumb: "https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_T5K3CmWR41NGpwde_thumb.jpg", category: ["interior"], description: "")
        
         let uidItem3 = UIDItem(uid: "under_hood", type: TypeEnum(rawValue: "img")!, path: "https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_T5K3CmWR41NGpwde.jpg", thumb: "https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_T5K3CmWR41NGpwde_thumb.jpg", category: ["interior"], description: "")
        
        self.masterTableViewControllerTest = MasterTableViewController()
        self.masterTableViewControllerTest.uidListResult = [uidItem1,uidItem2,uidItem3]
        self.masterTableViewControllerTest.client = client
        
        self.masterTableViewControllerTest.loadView()
        self.masterTableViewControllerTest.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(masterTableViewControllerTest.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(masterTableViewControllerTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(masterTableViewControllerTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(masterTableViewControllerTest.responds(to: #selector(masterTableViewControllerTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(masterTableViewControllerTest.tableView.dataSource)
    }
    func testTableViewHasDataSourceClient() {
        XCTAssertNotNil(masterTableViewControllerTest.client)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(masterTableViewControllerTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(masterTableViewControllerTest.responds(to: #selector(masterTableViewControllerTest.numberOfSections(in:))))
        XCTAssertTrue(masterTableViewControllerTest.responds(to: #selector(masterTableViewControllerTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(masterTableViewControllerTest.responds(to: #selector(masterTableViewControllerTest.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = masterTableViewControllerTest.tableView(masterTableViewControllerTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MasterTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "cell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testTableCellHasCorrectLabelText() {
        let cell0 = masterTableViewControllerTest.tableView(masterTableViewControllerTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MasterTableViewCell
        XCTAssertEqual(cell0?.labelUID.text, "inside_trunk")
        
        let cell1 = masterTableViewControllerTest.tableView(masterTableViewControllerTest.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? MasterTableViewCell
        XCTAssertEqual(cell1?.labelUID.text, "charging_cables")
        
        let cell2 = masterTableViewControllerTest.tableView(masterTableViewControllerTest.tableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? MasterTableViewCell
        XCTAssertEqual(cell2?.labelUID.text, "under_hood")
    }
}
