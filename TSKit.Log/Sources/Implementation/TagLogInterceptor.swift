public class TagLogInterceptor: AnyLogInterceptor {

    var ignoredTags: Set<String>

    public init(ignoredTags: String...) {
        self.ignoredTags = Set(ignoredTags)
    }

    public func shouldLog(_ entry: LogEntry) -> Bool {
        return entry.tag.flatMap({ !ignoredTags.contains($0) }) ?? true
    }
}
