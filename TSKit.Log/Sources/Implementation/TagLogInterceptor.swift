public class TagLogInterceptor: AnyLogInterceptor {

    var ignoredTags: Set<String>

    public init(ignoredTags: Any?...) {
        self.ignoredTags = Set(ignoredTags.compactMap(objectTag))
    }

    public func shouldLog(_ entry: LogEntry) -> Bool {
        return ignoredTags.intersection(entry.tags).isEmpty
    }
}
