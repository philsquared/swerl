//
//  main.swift
//  Swerl
//
//  Created by Phil Nash on 11/03/2019.
//  Copyright © 2019 Two Blue Cubes. All rights reserved.
//

import Foundation

print("Hello, World!")

enum TestError: Error {
    case interestingTimes
}


func thisFunctionThrows() throws {
    throw TestError.interestingTimes
}
func thisFunctionDoesntThrow() throws -> String {
    return "A valid value"
}

// Convert a throwing expression into a Result by using the built in initialiser that captures a throwing closure
let r1 = Result{ try thisFunctionThrows() }

print( "r1: \(r1)" )

// Convert a Result to a throwing expressioning, using get()
do {
    try r1.get()
}
catch( let e1 ) {
    print( "e1: \(e1)" )
}

// Convert a Result to a throwing expressioning, using unwrap()
do {
    try r1.unwrap()
}
catch( let e1 ) {
    print( "e1: \(e1)" )
}

// Convert a Result to an Optional, using toOptional()
let o1 = r1.toOptional()
print( "o1: \(o1)" )

// Convert an Optional to a Result, using toResult()
let r2 = o1.toResult()
print( "r2: \(r2)" )

let o1b : String? = "A valid string"
let r2b = o1b.toResult()
print( "r2b: \(r2b)" )

// Convert an Optional to a Result, using toResult(or:)
let r3 = o1.toResult(or: "message added later")
print( "r3: \(r3)" )

// Convert an Optional to a throwing expressioning, using unwrap()
do {
    try o1.unwrap()
}
catch( let e2 ) {
    print( "e2: \(e2)" )
}

// Convert an Optional to a throwing expressioning, using unwrap(or:)
do {
    try o1.unwrap(or: "message added later")
}
catch( let e2 ) {
    print( "e2: \(e2)" )
}

// Convert a throwing expression to an Optional, using try?
let o2 = try? thisFunctionThrows()
print( "o2: \(o2)" )

let o3 = try? thisFunctionDoesntThrow()
print( "o3: \(o3)" )


