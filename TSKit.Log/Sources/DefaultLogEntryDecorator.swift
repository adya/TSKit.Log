public class DefaultLogEntryDecorator: AnyLogEntryDecorator {

    private let style: LogLevelStyle
    
    public init(logLevelStyle: LogLevelStyle = .iconic) {
        self.style = logLevelStyle
    }

    public func decorate(_ entry: LogEntry) -> String {
        let date = String(from: entry.timestamp, formattedWith: "HH:mm:ss.SSS")!
        let tag = entry.tags.map { "[\($0)]" }.joined(separator: "")
        let logLevel = self.logLevel(entry.level, with: style)
        let prefix = ["[\(date)]",
                      "\(logLevel)",
                      tag,
                      "[\(entry.lineNumber).\(entry.functionName)]"].compactMap { $0 }
                                                                  .joined(separator: " ")
        return "\(prefix) : \(entry.message)"
    }
    
    private func logLevel(_ level: LogLevel, with style: LogLevelStyle) -> String {
        switch style {
        case .iconic: return level.icon
        case .textual: return level.text
        case .mixed: return "\(level.icon) \(level.text)"
        }
    }
    
}

public enum LogLevelStyle {
    case iconic
    case textual
    case mixed
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
    
    var text: String {
        switch self {
        case .debug: return "DEBUG"
        case .verbose: return "VERBOSE"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        case .severe: return "SEVERE"
        }
    }
}
