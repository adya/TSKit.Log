public struct LogEntry {

    public let message: String

    public let timestamp: Date

    public let tag: String?

    public let level: LogLevel

    public let functionName: String

    public let fileName: String

    public let lineNumber: Int
}
