public class Logger: AnyLogger {

    private var writers: [AnyLogEntryWriter] = []

    public var interceptors: [AnyLogInterceptor] = []

    public func addWriter(_ writer: AnyLogEntryWriter) {
        writers.append(writer)
    }

    private func log(_ message: String?,
                     tag: String?,
                     level: LogLevel,
                     functionName: String,
                     fileName: String,
                     lineNumber: Int) {
        guard let message = message else { return }
        
        let entry = LogEntry(message: message,
                             timestamp: Date(),
                             tag: tag,
                             level: level,
                             functionName: functionName,
                             fileName: fileName,
                             lineNumber: lineNumber)

        guard interceptors.allSatisfy({ $0.shouldLog(entry) }) else { return }

        writers.filter { $0.interceptors.allSatisfy({ $0.shouldLog(entry) }) }
               .forEach { $0.write(entry) }
    }

    public init() {}

    public func debug(_ message: String?, tag: Any?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: objectTag(tag), level: .debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func verbose(_ message: String?, tag: Any?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: objectTag(tag), level: .verbose, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func info(_ message: String?, tag: Any?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: objectTag(tag), level: .info, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func warning(_ message: String?, tag: Any?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: objectTag(tag), level: .warning, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func error(_ message: String?, tag: Any?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: objectTag(tag), level: .error, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func severe(_ message: String?, tag: Any?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: objectTag(tag), level: .severe, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    private func objectTag(_ tag: Any?) -> String? {
        guard let tag = tag else { return nil }

        if let tag = tag as? String {
            return tag
        } else if let typeTag = tag as? Any.Type {
            return String(describing: typeTag)
        } else {
            return String(describing: type(of: tag))
        }
    }

}
