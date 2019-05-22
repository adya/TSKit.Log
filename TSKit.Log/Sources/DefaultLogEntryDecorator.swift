public class DefaultLogEntryDecorator: AnyLogEntryDecorator {

    public init()

    func decorate(_ entry: LogEntry) -> String {
        let date = String(from: entry.timestamp, formattedWith: "HH:mm:ss.SSSSSS")!
        let tag = entry.tag.flatMap { " [\($0)]" }
        let prefix = ["\(date)",
                      "\(entry.level)",
                      tag,
                      "\(entry.lineNumber).\(entry.functionName)"].compactMap { $0 }
                                                                  .joined(separator: " ")
        return "\(prefix) : \(entry.message)"
    }
}
