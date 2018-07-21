import Foundation

/// Simple `AnyLog` implementation using plain `print()` function.
public class PrintLog: AnyLog {
    
    /// A level of logging.
    enum LogLevel: Int {
        case debug = 0
        case verbose = 1
        case info = 2
        case warning = 3
        case error = 4
        case severe = 5
    }
    
    /// `Logs` owner type. Used to determine callee's type.
    fileprivate var owner: Any.Type
    
    /// A list of types excluded from logging.
    fileprivate var excluded: [Any.Type] = []
    
    private static let logQueue = DispatchQueue(label: "TSKit.AnyLog")
    
    /// Logs level filter. Represents the lowest level of logging to be printed.
    var level: LogLevel = .debug
    
    /// Creates an instance of `PrintLog` with associated owner.
    /// - Parameter owner: Either owner instance or type of the owner to be associated with logger.
    /// - Note: `PrintLog` uses `owner`'s type to log exact type where message is being logged.
    /// - Note: Cache instances of `PrintLog` per owners to avoid extra loggers for same type of owners.
    init(owner: Any, level: LogLevel = .debug, excluded: [Any] = []) {
        if let type = owner as? Any.Type {
            self.owner = type
        } else {
            self.owner = type(of: (owner) as AnyObject)
        }
        self.level = level
        exclude(excluded)
    }
    
    /// Adds specified `sources` to the list of types which logs should be ignored.
    /// - Parameter sources: Types and objects to be excluded from logging.
    func exclude(_ sources: [Any]) {
        excluded += sources.map {
            if let type = $0 as? Any.Type {
                return type
            } else {
                return type(of: $0 as AnyObject)
            }
        }
        excluded = excluded.distinct(by: { "\($0)" })
    }
    
    /// - Returns: Formatted logged message.
    @discardableResult
    func log(_ message: String?, level: LogLevel, functionName: String, fileName: String, lineNumber: Int) -> String? {
        if let message = message, !message.isEmpty,
            level.rawValue >= self.level.rawValue,
            !excluded.contains(where: { [owner] in "\(owner)" == "\($0)" }) {
            let date = String(from: Date(), formattedWith: "HH:mm:ss.SSSSSS")!
            let formatted = "[\(date)] [\(level)] [\(owner).\(lineNumber).\(functionName)] : \(message)"
            print(formatted)
            return formatted
        }
        return nil
    }
    
    func debug(_ message: String?, functionName: String, fileName: String, lineNumber: Int) {
        PrintLog.logQueue.async {
            self.log(message, level: .debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }
    }
    
    func verbose(_ message: String?, functionName: String, fileName: String, lineNumber: Int) {
        PrintLog.logQueue.async {
            self.log(message, level: .verbose, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }
    }
    
    func info(_ message: String?, functionName: String, fileName: String, lineNumber: Int) {
        PrintLog.logQueue.async {
            self.log(message, level: .info, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }
    }
    
    func warning(_ message: String?, functionName: String, fileName: String, lineNumber: Int) {
        PrintLog.logQueue.async {
            self.log(message, level: .warning, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }
    }
    
    func error(_ message: String?, functionName: String, fileName: String, lineNumber: Int) {
        PrintLog.logQueue.async {
            self.log(message, level: .error, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }
    }
    
    func severe(_ message: String?, functionName: String, fileName: String, lineNumber: Int) {
        PrintLog.logQueue.async {
            self.log(message, level: .severe, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }
    }
}

// MARK: - LogLevel string representation.
extension PrintLog.LogLevel: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .debug: return " ⚙️ DEBUG"
        case .verbose: return " 📝 VERBOSE"
        case .info: return " ℹ️ INFO"
        case .warning: return " ⚠️ WARNING"
        case .error: return " ‼️️ ERROR"
        case .severe: return " 🆘️ SEVERE"
        }
    }
}
