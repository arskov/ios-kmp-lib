//
//  ios_kmpPerfTests.swift
//  ios-kmpPerfTests
//
//  Created by Arseni Kavalchuk on 17.11.24.
//

import KmpLib
import XCTest

@testable import ios_kmp

final class ios_kmpPerfTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceToKotlinByteArrayDataPtrCopy() {
        let testString = String(repeating: "Hello, Kotlin!", count: 1000)
        self.measure {
            _ = testString.toKotlinByteArrayDataPtrCopy()
        }
    }

    func testPerformanceToKotlinByteArrayLoopCopy() {
        let testString = String(repeating: "Hello, Kotlin!", count: 1000)
        self.measure {
            _ = testString.toKotlinByteArrayLoopCopy()
        }
    }

    func testPerformanceToKotlinByteArrayUtf8CStringCopy() {
        let testString = String(repeating: "Hello, Kotlin!", count: 1000)
        self.measure {
            _ = testString.toKotlinByteArrayUtf8CStringCopy()
        }
    }

    func testPerformanceToKotlinByteArrayUtf8CStringMemcpy() {
        let testString = String(repeating: "Hello, Kotlin!", count: 1000)
        self.measure {
            _ = testString.toKotlinByteArrayUtf8CStringMemcpy()
        }
    }
}
