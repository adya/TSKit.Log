public class DefaultLogEntryDecorator: AnyLogEntryDecorator {

    public init() {}

    public func decorate(_ entry: LogEntry) -> String {
        let date = String(from: entry.timestamp, formattedWith: "HH:mm:ss.SSS")!
        let tag = entry.tag.flatMap { "[\($0)]" }
        let prefix = ["[\(date)]",
                      "\(entry.level.icon)",
                      tag,
                      "[\(entry.lineNumber).\(entry.functionName)]"].compactMap { $0 }
                                                                  .joined(separator: " ")
        return "\(prefix) : \(entry.message)"
    }
}

public extension LogLevel  {

    var verbose: String {
        return "\(icon)️ \(String(describing: self).uppercased())"
    }

    var icon: String {
        switch self {
        case .debug: return "⚙️"
        case .verbose: return "📝"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .error: return "‼️️"
        case .severe: return "🆘"
        }
    }
}
