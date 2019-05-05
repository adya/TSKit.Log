/**
 Handy access to logger from any object.
 Simply conform to `Loggable` to enable logging on any component.
 
 - Note: 
 To further simplify usage of this log create an extension for `Loggable` and implement a factory which will provide default `log`s for each type.
 Alternatively, if used with a Dependency Injection can be injected to conformed types through `init`.
*/
public protocol Loggable {
    
    /// A `log` object associated with `self`.
    var log: AnyLog { get }
    
    /// A `log` object associated with `self` type.
    static var log: AnyLog {get}
}

/// Pool of loggers
private var loggers: [String : AnyLog] = [:]

/// A list of types to be ignored from logging.
private let excluded: [Any.Type] = []

// Default implementation of loggers factory.
extension Loggable {

    public static var log: AnyLog {
        let key = "\(type(of: self))"
        if let logger = loggers[key] {
            return logger
        } else {
            let logger: AnyLog = PrintLog(owner: self, excluded: excluded)
            loggers[key] = logger
            return logger
        }
    }

    public var log: AnyLog {
        return type(of: self).log
    }
}
