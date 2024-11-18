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

    let testString = String(repeating: "Hello, Kotlin! ", count: 1000)

    func measureExecutionTime(_ block: () -> Void) -> TimeInterval {
        let startTime = CFAbsoluteTimeGetCurrent()
        block()
        return CFAbsoluteTimeGetCurrent() - startTime
    }

    func testBenchmarkAllMethods() {
        let iterations = 1000
        var results: [String: TimeInterval] = [:]

        let methods = [
            "LoopCopy": { _ = self.testString.toKotlinByteArrayLoopCopy() },
            "DataPtrReadBytes": {
                _ = self.testString.toKotlinByteArrayDataPtrReadBytes()
            },
            "DataPtrMemcpy": {
                _ = self.testString.toKotlinByteArrayDataPtrMemcpy()
            },
            "Utf8CStringReadBytes": {
                _ = self.testString.toKotlinByteArrayUtf8CStringReadBytes()
            },
            "Utf8CStringMemcpy": {
                _ = self.testString.toKotlinByteArrayUtf8CStringMemcpy()
            },
        ]

        for (methodName, method) in methods {
            var totalTime: TimeInterval = 0
            for _ in 0..<iterations {
                totalTime += measureExecutionTime { method() }
            }
            results[methodName] = totalTime / Double(iterations)
        }

        // Print Results
        print("Benchmark Results (average over \(iterations) iterations):")
        for (methodName, averageTime) in results {
            let formattedTime = String(format: "%.9f", averageTime * 1000)  // Convert seconds to milliseconds
            print("\(methodName): \(formattedTime) ms")
        }
    }
}
