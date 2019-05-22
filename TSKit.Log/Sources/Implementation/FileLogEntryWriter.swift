public class FileLogEntryWriter: AnyLogEntryWriter {

    public var interceptors: [AnyLogInterceptor] = []

    public var decorator: AnyLogEntryDecorator

    public init() {}

    public func write(_ logEntry: LogEntry) {}
}
