/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

public extension AnyLogger {

    /// Logs to debug level.
    /// `Debug` messages are used to log any details required
    /// to determine possible causes of known issues while debugging application.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter tag: Optional object used to categorize current log message to certain group.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    /// - Returns partially applied function expecting `message` to be logged.
    func debug(tag: Any?,
               functionName: String = #function,
               fileName: String = #file,
               lineNumber: Int = #line) -> (String?) -> Void {
        return { self.debug($0, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber) }
    }

    /// Logs to verbose level.
    /// `Verbose` messages are typically used to describe
    /// operation's non-primary details while it's running.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter tag: Optional object used to categorize current log message to certain group.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    /// - Returns partially applied function expecting `message` to be logged.
    func verbose(tag: Any?,
                 functionName: String = #function,
                 fileName: String = #file,
                 lineNumber: Int = #line) -> (String?) -> Void {
        return { self.verbose($0, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber) }
    }

    /// Logs to info level.
    /// `Info` messages are used to provide some useful information
    /// about any operation results, completion.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter tag: Optional object used to categorize current log message to certain group.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    /// - Returns partially applied function expecting `message` to be logged.
    func info(tag: Any?,
              functionName: String = #function,
              fileName: String = #file,
              lineNumber: Int = #line) -> (String?) -> Void {
        return { self.info($0, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber) }
    }

    /// Logs to warning level.
    /// `Warning` message indicates that some non-critical issue occurred
    /// which doesn't stop/block any operations but still needs attention.
    /// - Note: `warning` can be used to mark some unfinished functionality.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter tag: Optional object used to categorize current log message to certain group.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    /// - Returns partially applied function expecting `message` to be logged.
    func warning(tag: Any?,
                 functionName: String = #function,
                 fileName: String = #file,
                 lineNumber: Int = #line) -> (String?) -> Void {
        return { self.warning($0, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber) }
    }

    /// Logs to error level.
    /// `Error` message indicates that some expected and handled error occurred
    /// which leads in cancellation of the operation where this error occurred.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter tag: Optional object used to categorize current log message to certain group.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    /// - Returns partially applied function expecting `message` to be logged.
    func error(tag: Any?,
               functionName: String = #function,
               fileName: String = #file,
               lineNumber: Int = #line) -> (String?) -> Void {
        return { self.error($0, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber) }
    }

    /// Logs to severe level.
    /// `Severe` message indicates that some critical error occurred
    /// which leads to undefined behavior and/or crash.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter tag: Optional object used to categorize current log message to certain group.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    /// - Returns partially applied function expecting `message` to be logged.
    func severe(tag: Any?,
                functionName: String = #function,
                fileName: String = #file,
                lineNumber: Int = #line) -> (String?) -> Void {
        return { self.severe($0, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber) }
    }
}
