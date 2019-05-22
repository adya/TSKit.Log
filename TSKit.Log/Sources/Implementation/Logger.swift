class Logger: AnyLogger {

    private var writers: [AnyLogEntryWriter] = []

    var interceptors: [AnyLogInterceptor] = []

    private func log(_ message: String,
                     tag: String?,
                     level: LogLevel,
                     functionName: String,
                     fileName: String,
                     lineNumber: Int) {

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

    func debug(_ message: String, tag: String?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: tag, level: .debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func verbose(_ message: String, tag: String?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: tag, level: .verbose, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func info(_ message: String, tag: String?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: tag, level: .info, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func warning(_ message: String, tag: String?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: tag, level: .warning, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func error(_ message: String, tag: String?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: tag, level: .error, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    func severe(_ message: String, tag: String?, functionName: String, fileName: String, lineNumber: Int) {
        log(message, tag: tag, level: .severe, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
}
