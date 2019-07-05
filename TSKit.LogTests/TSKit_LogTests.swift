//
//  TSKit_LogTests.swift
//  TSKit.LogTests
//
//  Created by Arkadiy Glushchevsky on 12/16/17.
//  Copyright © 2017 Arkadiy Glushchevsky. All rights reserved.
//

import XCTest
@testable import TSKit_Log

class TSKit_LogTests: XCTestCase {
    
    let writer = StringLogEntryWriter()
    
    let logger = Logger()
    
    override func setUp() {
        super.setUp()
        logger.writers.append(writer)
    }
    
    override func tearDown() {
        logger.writers.removeAll()
        writer.output = ""
        super.tearDown()
    }
    
    func testTagless() {
        logger.debug("test", tag: nil)
        XCTAssert(writer.output == "test\n")
    }
    
    func testSingleStringTag() {
        logger.debug("test", tag: "TG")
        XCTAssert(writer.output == "[TG] test\n")
    }
    
    func testSingleObjectTag() {
        logger.debug("test", tag: writer)
        XCTAssert(writer.output == "[StringLogEntryWriter] test\n")
    }
    
    func testMultipleStringTags() {
//        logger.debug("test", tag: "TG1", "TG2", "TG3")
//        XCTAssert(writer.output == "[TG1][TG2][TG3] test\n")
    }

    class RawDecorator: DefaultLogEntryDecorator {
        
        override func decorate(_ entry: LogEntry) -> String {
            let tag = entry.tag.flatMap { "[\($0)] " } ?? ""
            return "\(tag)\(entry.message)"
        }
    }
    
    class StringLogEntryWriter: AnyLogEntryWriter {
        
        var interceptors: [AnyLogInterceptor] = []
        
        var decorator: AnyLogEntryDecorator = RawDecorator()
        
        var output = ""
        
        func write(_ logEntry: LogEntry) {
            
            output += "\(decorator.decorate(logEntry))\n"
        }
    }
}
