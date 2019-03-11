# swerl

As of Swift 5, the language has four error handling approaches:

1. Swift Error Handling (throws)
2. Optionals
3. fatalError() (and assert(), etc)
4. Result (new in Swift 5)

Out of the box it provides several ways to convert between many of these:

* try? : throws -> Optional
* try! : throws -> fatalError()
* ! : Optional -> fatalError()
* .get() : Result -> throws
* init(catching:) : throws -> Result

This library adds the rest (note that converting from a fatalError() to anything else is not really possible - but see [this post by Matt Gallagher](http://www.cocoawithlove.com/blog/2016/02/02/partial-functions-part-two-catching-precondition-failures.html) for a workaround).

* unwrap() : Optional -> throws
* unwrap() : Result -> throws (with more information)
* toResult() : Optional -> Result
* toOptional() : Result -> Optional
* assume() : Result -> fatalError()
