import Foundation
public class Logger: AnyLogger {

    public var writers: [AnyLogEntryWriter] = []

    public var interceptors: [AnyLogInterceptor] = []

    private func log(_ message: String?,
                     tag: [String],
                     level: LogLevel,
                     functionName: String,
                     fileName: String,
                     lineNumber: Int) {
        guard let message = message else { return }
        
        let entry = LogEntry(message: message,
                             timestamp: Date(),
                             tags: tag,
                             level: level,
                             functionName: functionName,
                             fileName: fileName,
                             lineNumber: lineNumber)

        guard interceptors.allSatisfy({ $0.shouldLog(entry) }) else { return }

        writers.filter { $0.interceptors.allSatisfy({ $0.shouldLog(entry) }) }
               .forEach { $0.write(entry) }
    }

    public init() {}

    public func debug(_ message: String?,
                      tag: [Any?],
                      functionName: String = #function,
                      fileName: String = #file,
                      lineNumber: Int = #line) {
        log(message, tag: tag.compactMap(objectTag), level: .debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func verbose(_ message: String?,
                        tag: [Any?],
                        functionName: String = #function,
                        fileName: String = #file,
                        lineNumber: Int = #line) {
        log(message, tag: tag.compactMap(objectTag), level: .verbose, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func info(_ message: String?,
                     tag: [Any?],
                     functionName: String = #function,
                     fileName: String = #file,
                     lineNumber: Int = #line) {
        log(message, tag: tag.compactMap(objectTag), level: .info, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func warning(_ message: String?,
                        tag: [Any?],
                        functionName: String = #function,
                        fileName: String = #file,
                        lineNumber: Int = #line) {
        log(message, tag: tag.compactMap(objectTag), level: .warning, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func error(_ message: String?,
                      tag: [Any?],
                      functionName: String = #function,
                      fileName: String = #file,
                      lineNumber: Int = #line) {
        log(message, tag: tag.compactMap(objectTag), level: .error, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func severe(_ message: String?,
                       tag: [Any?],
                       functionName: String = #function,
                       fileName: String = #file,
                       lineNumber: Int = #line) {
        log(message, tag: tag.compactMap(objectTag), level: .severe, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
}

func objectTag(_ tag: Any?) -> String? {
    guard let tag = tag else { return nil }

    if let tag = tag as? String {
        return tag
    } else if let typeTag = tag as? Any.Type {
        return String(describing: typeTag)
    } else if let tag = tag as? CustomStringConvertible {
        return tag.description
    } else {
        return String(describing: type(of: tag))
    }
}
