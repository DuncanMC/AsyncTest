//
//  AsyncTest.swift
//
//
//  Created by Duncan Champney on 1/17/24.
//

import ArgumentParser
import Foundation


@main
struct AsyncTest: ParsableCommand {
    @Option(name: .shortAndLong, help: "The number of times to snork.")
    var count: Int? = nil
    
    mutating func run() throws {
        print("Entering function \(#function)")
        if let count, count > 0 {
            for index in 1...count {
                print("  Snork \(index)")
            }
        }
    }
//    static func main() {
//        print("Hello Swift")
//    }
}
