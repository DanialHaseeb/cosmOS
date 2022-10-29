//
//  AddressTests.swift
//  cosmOSTests
//
//  Created by Danial Haseeb on 29/10/2022.
//

import XCTest

final class AddressTests: XCTestCase
{
  func testEmptyInitialiser()
  {
    let address = Address()
    
    XCTAssert(address.page == 0)
    XCTAssert(address.offset == 0)
  }
  
  func testInitialiser()
  {
    let address = Address(500)
    
    XCTAssert(address.page == 3)
    XCTAssert(address.offset == 116)
  }
}
