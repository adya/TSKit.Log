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
