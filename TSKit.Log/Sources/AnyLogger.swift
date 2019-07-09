/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2018. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

/// Logger providing multiple levels of logging.
public protocol AnyLogger {

    /// Logs to debug level.
    /// `Debug` messages are used to log any details required
    /// to determine possible causes of known issues while debugging application.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tags: Optional objects used to categorize current log message to certain groups.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    func debug(_ message: String?, tag: [Any?], functionName: String, fileName: String, lineNumber: Int)

    /// Logs to verbose level.
    /// `Verbose` messages are typically used to describe
    /// operation's non-primary details while it's running.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tags: Optional objects used to categorize current log message to certain groups.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    func verbose(_ message: String?, tag: [Any?], functionName: String, fileName: String, lineNumber: Int)

    /// Logs to info level.
    /// `Info` messages are used to provide some useful information
    /// about any operation results, completion.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tags: Optional objects used to categorize current log message to certain groups.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    func info(_ message: String?, tag: [Any?], functionName: String, fileName: String, lineNumber: Int)

    /// Logs to warning level.
    /// `Warning` message indicates that some non-critical issue occurred
    /// which doesn't stop/block any operations but still needs attention.
    /// - Note: `warning` can be used to mark some unfinished functionality.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tags: Optional objects used to categorize current log message to certain groups.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    func warning(_ message: String?, tag: [Any?], functionName: String, fileName: String, lineNumber: Int)

    /// Logs to error level.
    /// `Error` message indicates that some expected and handled error occurred
    /// which leads in cancellation of the operation where this error occurred.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tags: Optional objects used to categorize current log message to certain groups.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    func error(_ message: String?, tag: [Any?], functionName: String, fileName: String, lineNumber: Int)

    /// Logs to severe level.
    /// `Severe` message indicates that some critical error occurred
    /// which leads to undefined behavior and/or crash.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tags: Optional objects used to categorize current log message to certain groups.
    ///                  When passing `String` it will be used directly, otherwise `tag` will be represented as type
    ///                  of passed object.
    func severe(_ message: String?, tag: [Any?], functionName: String, fileName: String, lineNumber: Int)
}
