//
//  swerl.swift
//  Swerl
//
//  Created by Phil Nash on 11/03/2019.
//  Copyright © 2019 Two Blue Cubes. All rights reserved.
//

import Foundation

struct ResultNotSet : Error {
    let message: String
    let file : StaticString
    let line : UInt
}

struct OptionalNotSet : Error {
    let message: String
    let file : StaticString
    let line : UInt
}

extension Result {
    // You can already convert from throws-to-Result by using the `catching` initialiser,
    // and Result-to-throws by using the `get()` method.
    
    // We add unwrap, that works like `get()`, but makes a new Error, capturing file/ line of the unwrap line
    public func unwrap(_ file: StaticString = #file, _ line : UInt = #line) throws -> Success {
        switch self {
        case .success(let value): return value
        case .failure( let error): throw
            ResultNotSet( message: "Result assumed to contain value, but actually held error: \(error)", file : file, line: line )
        }
    }
    
    // We can convert to an optional, obviously losing any error information
    func toOptional() -> Success? {
        switch self {
        case .success(let value): return value
        case .failure: return nil // loses information
        }
    }
    
    // We can assume we have a value - the equivalent of suffix `operator !` on Optional
    // - gives a hard error otherwise
    func assume() -> Success {
        switch self {
        case .success(let value): return value
        case .failure( let error): fatalError( "Result assumed to contain value, but actually held error: \(error)" )
        }
    }
}

extension Optional {
    // Converts to a Result. If nil, creates a generic Error, including file/ line
    func toResult( _ file: StaticString = #file, _ line : UInt = #line ) -> Result<Wrapped, Error> {
        switch self {
        case .some(let wrapped): return .success(wrapped)
        case .none: return .failure( OptionalNotSet( message: "Optional not set", file: file, line: line ) )
        }
    }
    
    // Converts to result. If nil creates a generic Error, including the lazy message and file/ line
    func toResult( or msgFun: @autoclosure () -> String, _ file: StaticString = #file, _ line : UInt = #line ) -> Result<Wrapped, Error> {
        switch self {
        case .some(let wrapped): return .success(wrapped)
        case .none: return .failure( OptionalNotSet( message: msgFun(), file: file, line: line ) )
        }
    }
    
    // unwraps or throws a generic error, capturing file/ line
    public func unwrap(_ file: StaticString = #file, _ line : UInt = #line) throws -> Wrapped {
        switch self {
        case .some(let wrapped): return wrapped
        case .none: throw
            OptionalNotSet( message: "Optional not set", file : file, line: line )
        }
    }

    // unwraps or throws a generic error, with the supplied (lazy) message, and capturing file/ line
    public func unwrap( or msgFun: @autoclosure () -> String, _ file: StaticString = #file, _ line : UInt = #line) throws -> Wrapped {
        switch self {
        case .some(let wrapped): return wrapped
        case .none: throw
            OptionalNotSet( message: msgFun(), file : file, line: line )
        }
    }
}

