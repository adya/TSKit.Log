/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

/// Logger providing multiple levels of logging.
public protocol AnyLogger {

    var interceptors: [AnyLogInterceptor] { get set }

    /// Logs to debug level.
    /// `Debug` messages are used to log any details required
    /// to determine possible causes of known issues while debugging application.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional string used to categorize current log message to certain group.
    func debug(_ message: String?, tag: String?, functionName: String, fileName: String, lineNumber: Int)

    /// Logs to verbose level.
    /// `Verbose` messages are typically used to describe
    /// operation's non-primary details while it's running.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional string used to categorize current log message to certain group.
    func verbose(_ message: String?, tag: String?, functionName: String, fileName: String, lineNumber: Int)

    /// Logs to info level.
    /// `Info` messages are used to provide some useful information
    /// about any operation results, completion.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional string used to categorize current log message to certain group.
    func info(_ message: String?, tag: String?, functionName: String, fileName: String, lineNumber: Int)

    /// Logs to warning level.
    /// `Warning` message indicates that some non-critical issue occurred
    /// which doesn't stop/block any operations but still needs attention.
    /// - Note: `warning` can be used to mark some unfinished functionality.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional string used to categorize current log message to certain group.
    func warning(_ message: String?, tag: String?, functionName: String, fileName: String, lineNumber: Int)

    /// Logs to error level.
    /// `Error` message indicates that some expected and handled error occurred
    /// which leads in cancellation of the operation where this error occurred.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional string used to categorize current log message to certain group.
    func error(_ message: String?, tag: String?, functionName: String, fileName: String, lineNumber: Int)

    /// Logs to severe level.
    /// `Severe` message indicates that some critical error occurred
    /// which leads to undefined behavior and/or crash.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional string used to categorize current log message to certain group.
    func severe(_ message: String?, tag: String?, functionName: String, fileName: String, lineNumber: Int)
}

/// MARK: Default handy log methods.
public extension AnyLogger {

    func verbose(_ message: String?,
                 functionName: String = #function,
                 fileName: String = #file,
                 lineNumber: Int = #line) {
        self.verbose(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func debug(_ message: String?,
               functionName: String = #function,
               fileName: String = #file,
               lineNumber: Int = #line) {
        self.debug(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func info(_ message: String?, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        self.info(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func warning(_ message: String?,
                 functionName: String = #function,
                 fileName: String = #file,
                 lineNumber: Int = #line) {
        self.warning(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func error(_ message: String?,
               functionName: String = #function,
               fileName: String = #file,
               lineNumber: Int = #line) {
        self.error(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func severe(_ message: String?,
                functionName: String = #function,
                fileName: String = #file,
                lineNumber: Int = #line) {
        self.severe(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

}

// MARK: - Reporter
public extension AnyLogger {

    private func reporterTag(_ reporter: Any) -> String {
        if let type = reporter as? Any.Type {
            return String(describing: type)
        } else {
            return String(describing: type(of: reporter))
        }
    }

    /// Logs to debug level.
    /// `Debug` messages are used to log any details required
    /// to determine possible causes of known issues while debugging application.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter reporter: An object that will be used as a tag.
    func debug(_ message: String?, reporter: Any, functionName: String, fileName: String, lineNumber: Int) {
        debug(message,
              tag: reporterTag(reporter),
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber)
    }

    /// Logs to verbose level.
    /// `Verbose` messages are typically used to describe
    /// operation's non-primary details while it's running.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter reporter: An object that will be used as a tag.
    func verbose(_ message: String?, reporter: Any, functionName: String, fileName: String, lineNumber: Int) {
        verbose(message,
                tag: reporterTag(reporter),
                functionName: functionName,
                fileName: fileName,
                lineNumber: lineNumber)
    }

    /// Logs to info level.
    /// `Info` messages are used to provide some useful information
    /// about any operation results, completion.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter reporter: An object that will be used as a tag.
    func info(_ message: String?, reporter: Any, functionName: String, fileName: String, lineNumber: Int) {
        info(message,
             tag: reporterTag(reporter),
             functionName: functionName,
             fileName: fileName,
             lineNumber: lineNumber)
    }

    /// Logs to warning level.
    /// `Warning` message indicates that some non-critical issue occurred
    /// which doesn't stop/block any operations but still needs attention.
    /// - Note: `warning` can be used to mark some unfinished functionality.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter reporter: An object that will be used as a tag.
    func warning(_ message: String?, reporter: Any, functionName: String, fileName: String, lineNumber: Int) {
        warning(message,
                tag: reporterTag(reporter),
                functionName: functionName,
                fileName: fileName,
                lineNumber: lineNumber)
    }

    /// Logs to error level.
    /// `Error` message indicates that some expected and handled error occurred
    /// which leads in cancellation of the operation where this error occurred.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter reporter: An object that will be used as a tag.
    func error(_ message: String?, reporter: Any, functionName: String, fileName: String, lineNumber: Int) {
        error(message,
              tag: reporterTag(reporter),
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber)
    }

    /// Logs to severe level.
    /// `Severe` message indicates that some critical error occurred
    /// which leads to undefined behavior and/or crash.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter reporter: An object that will be used as a tag.
    func severe(_ message: String?, reporter: Any, functionName: String, fileName: String, lineNumber: Int) {
        severe(message,
               tag: reporterTag(reporter),
               functionName: functionName,
               fileName: fileName,
               lineNumber: lineNumber)
    }
}
