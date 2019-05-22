public protocol AnyLogInterceptor: class {

    func shouldLog(_ entry: LogEntry) -> Bool
}
