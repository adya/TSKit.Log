import TSKit_Core

public class PrintLogEntryWriter: AnyLogEntryWriter {

    public var interceptors: [AnyLogInterceptor]

    public var decorator: AnyLogEntryDecorator

    public init(decorator: AnyLogEntryDecorator = DefaultLogEntryDecorator(),
                interceptors: AnyLogInterceptor...) {
        self.decorator = decorator
        self.interceptors = interceptors
    }

    public func write(_ entry: LogEntry) {
        decorator.decorate(entry) ==> { print($0) }
    }
}
