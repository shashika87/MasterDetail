//
//  DetailViewControllerTest.swift
//  MasterDetailsTests
//
//  Created by Shashi Kant on 5/5/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import XCTest

@testable import MasterDetails
class DetailViewControllerTest: XCTestCase {
var detailViewControllerTest: DetailViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.detailViewControllerTest = DetailViewController();
        //self.detailViewControllerTest
        
        let uidItem1 = UIDItem(uid: "inside_trunk", type: TypeEnum(rawValue: "img")!, path: "https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_oDLiEj3QxhWdRwJS.jpg", thumb: "https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_oDLiEj3QxhWdRwJS_thumb.jpg", category: ["interior"], description: "")
         
       
        self.detailViewControllerTest.loadView()
        self.detailViewControllerTest.viewDidLoad()
        self.detailViewControllerTest.title = uidItem1.uid
        self.detailViewControllerTest!.detailView.updateDetailView(uidItem1)
    }
    
    func testHasADettailView() {
        XCTAssertNotNil(detailViewControllerTest.detailView)
    }
    
    func testHasADettailViewAndHasClient() {
        XCTAssertNotNil(detailViewControllerTest.detailView.client)
    }
    
    func testDetailViewHasCorrectLabelText() {
        let uidText = self.detailViewControllerTest.title
       let labelCategory = self.detailViewControllerTest.detailView.labelCategory
        XCTAssertEqual(uidText, "inside_trunk")
        XCTAssertEqual(labelCategory.text, "interior")
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
