public class LogLevelLogInterceptor: AnyLogInterceptor {

    public var ignoredLevels: Set<LogLevel>

    public init(ignoredLevels: LogLevel...) {
        self.ignoredLevels = Set(ignoredLevels)
    }

    public func shouldLog(_ entry: LogEntry) -> Bool {
        return !ignoredLevels.contains(entry.level)
    }
}
