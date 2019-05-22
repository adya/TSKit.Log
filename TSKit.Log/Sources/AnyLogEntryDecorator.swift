/// Decorates log entry before its being sent to output.
public protocol AnyLogEntryDecorator: class {

    func decorate(_ entry: LogEntry) -> String
}
