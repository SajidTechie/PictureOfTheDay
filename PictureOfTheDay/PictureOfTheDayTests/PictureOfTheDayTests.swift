//
//  PictureOfTheDayTests.swift
//  PictureOfTheDayTests
//
//  Created by Sajid kantharia on 31/10/22.
//

import XCTest
@testable import PictureOfTheDay

class PictureOfTheDayTests: XCTestCase {
    
    func test_DailyPictureApiResource_With_ValidRequest_Returns_PictureData(){
        
        let mockResource = DailyPictureResource()
        
        let expectation = self.expectation(description: "ValidRequest_Returns_PictureData")
        mockResource.dailyPicture{ (pictureResponse) in
            
            XCTAssertNotNil(pictureResponse)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
}
