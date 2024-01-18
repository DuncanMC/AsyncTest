//
//  AsyncTest.swift
//
//
//  Created by Duncan Champney on 1/17/24.
//

import ArgumentParser
import Foundation


@main

struct AsyncTest: AsyncParsableCommand {
    @Option(name: .shortAndLong, help: "The number of times to snork.")
    var count: Int? = nil
    
    func doAsyncInLoop(count: Int) async {
        if #available(macOS 10.15, *) {
            print("In macOS ≥10.15")
            Task {
                for index in 1...count {
                    let result = try await doAsyncTask(index: index)
                    print(result)
                }
            }
        } else {
            print("In macOS <10.15. Task() not available.")
        }
    }


    @discardableResult func doAsyncTask(index: Int) async throws -> String {
        print("In \(#function).")
        //Wait 10-500 milliseconds (.01 to .5 seconds)
        let millisecond = NSEC_PER_SEC / 1000
        let duration = millisecond * UInt64.random(in: 10...500)
        if #available(macOS 10.15, *) {
            try await Task.sleep(nanoseconds: duration)
        } else {
            // Fallback on earlier versions
        }
        return "Async job \(index) complete"
    }

    mutating func run() async throws {
        print("In \(#function). count == \(count ?? 0)")
        if let count, count > 0 {
            await doAsyncInLoop(count: count)
        }
    }
}
