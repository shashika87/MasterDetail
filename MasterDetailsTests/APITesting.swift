//
//  APITesting.swift
//  MasterDetailsTests
//
//  Created by Shashi Kant on 5/5/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import XCTest


//: Playground - noun: a place where people can play

// Protocol for MOCK/Real
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

//MARK: HttpClient Implementation
class HttpClient {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
        
    }
    
    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }

}

//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

//MARK: MOCK
class MockURLSession: URLSessionProtocol {

    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}

//MARK: Test
class APITesting: XCTestCase {
    
    var httpClient: HttpClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_get_request_with_URL() {

        guard let url = URL(string: "https://api.fyu.se/1.4/group/web/jlp75qdubezgc?abspath=1") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
        
    }
    
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: "https://api.fyu.se/1.4/group/web/jlp75qdubezgc?abspath=1") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        let result = "{\"success\":1,\"data\":{\"uid\":\"jlp75qdubezgc\",\"date\":1584041293,\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/\",\"ratio\":\"4x3\",\"list\":[{\"uid\":\"inside_trunk\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_oDLiEj3QxhWdRwJS.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_oDLiEj3QxhWdRwJS_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"charging_cables\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_T5K3CmWR41NGpwde.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_T5K3CmWR41NGpwde_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"under_hood\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_L6HwGei5SRdFJfb4.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_L6HwGei5SRdFJfb4_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"emissions_sticker\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_kjHW1AhypbeYuwlJ.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_kjHW1AhypbeYuwlJ_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"external_left_front_3_4\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_cGqnEudhUW5VCxkv.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_cGqnEudhUW5VCxkv_thumb.jpg\",\"category\":[\"exterior\"],\"description\":null},{\"uid\":\"external_front_head_on\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_vjPRiCV2NpZeugLF.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_vjPRiCV2NpZeugLF_thumb.jpg\",\"category\":[\"exterior\"],\"description\":null},{\"uid\":\"external_right_side_head_on\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_ySBrcHYbg8pu9Uhk.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_ySBrcHYbg8pu9Uhk_thumb.jpg\",\"category\":[\"exterior\"],\"description\":null},{\"uid\":\"external_right_back_3_4\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_MIxB1Xs67Dr0p54v.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_MIxB1Xs67Dr0p54v_thumb.jpg\",\"category\":[\"exterior\"],\"description\":null},{\"uid\":\"external_back_head_on\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_Q4qjxAbvrTlX05wa.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_Q4qjxAbvrTlX05wa_thumb.jpg\",\"category\":[\"exterior\"],\"description\":null},{\"uid\":\"interior_left_front_seat_3_4\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_0EUDnLaocHmsvAGx.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_0EUDnLaocHmsvAGx_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"interior_left_dash_3_4\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_BTLfUZ61DrilaAI5.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_BTLfUZ61DrilaAI5_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"steering_wheel\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_wIXMeFjCfnmubDVx.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_wIXMeFjCfnmubDVx_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"odometer\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_nht3q9RcvzjQWopa.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_nht3q9RcvzjQWopa_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"backup_camera\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_ITejw3alcoWp59U6.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_ITejw3alcoWp59U6_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"glove_compartment_head_on\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_m5whLucVBsyEZ2aP.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_m5whLucVBsyEZ2aP_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"sunroof\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_qcz6mb5PhO1eu4iD.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_qcz6mb5PhO1eu4iD_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"dashboard_wide_head_on\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_pdwV1tjRsyb5q6YT.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_pdwV1tjRsyb5q6YT_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"center_dash_console_head_on\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_Ky2fZ8O5bMhjtrwQ.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_Ky2fZ8O5bMhjtrwQ_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"interior_left_back_seat\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_u5co2IbXjMHhxTkZ.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_u5co2IbXjMHhxTkZ_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"3rd_row\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_DlC49V7TrWf1BAwp.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_DlC49V7TrWf1BAwp_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"interior_right_front_seat_3_4\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_S185rDuqZNAzcR0L.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_S185rDuqZNAzcR0L_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"interior_right_back_of_front_seats\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_VO2GNw8dWmbpECyQ.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_VO2GNw8dWmbpECyQ_thumb.jpg\",\"category\":[\"interior\"],\"description\":null},{\"uid\":\"tag\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_85FimcAdlB09gGar.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_85FimcAdlB09gGar_thumb.jpg\",\"category\":[\"features\"],\"description\":\"Aftermarket\"},{\"uid\":\"tag\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_Aw5bSdpuy03vZDm2.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_Aw5bSdpuy03vZDm2_thumb.jpg\",\"category\":[\"damages\"],\"description\":\"Spider Cracking\"},{\"uid\":\"tag\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_bJDpCZWlzm7XyH8M.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_bJDpCZWlzm7XyH8M_thumb.jpg\",\"category\":[\"features\"],\"description\":\"Performance\"},{\"uid\":\"tag\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_atr3ncMGE7BZDCw5.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_atr3ncMGE7BZDCw5_thumb.jpg\",\"category\":[\"damages\"],\"description\":\"Oxidation\"},{\"uid\":\"external_left_back_3_4\",\"type\":\"img\",\"path\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_uUq82csvw5rBItfD.jpg\",\"thumb\":\"https://i.fyuse.com/group/qkfxcn9nlvee7ip3/jlp75qdubezgc/snaps/img_uUq82csvw5rBItfD_thumb.jpg\",\"category\":[\"exterior\"],\"description\":null}]}}"
        let expectedData = result.data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Data?
        httpClient.get(url: URL(string: "https://api.fyu.se/1.4/group/web/jlp75qdubezgc?abspath=1")!) { (data, error) in
            actualData = data
            XCTAssertEqual(actualData, expectedData)
        }
        
        //XCTAssertNotNil(actualData)
    }
    
}

//APITesting.defaultTestSuite.run()



