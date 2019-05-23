public struct LogEntry {

    let message: String

    let timestamp: Date

    let tag: String?

    let level: LogLevel

    let functionName: String

    let fileName: String

    let lineNumber: Int
}
