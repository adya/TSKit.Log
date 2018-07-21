import UIKit
import TSKit_Core

class FileLog : PrintLog {

    @discardableResult override func log(_ message: String?, level: LogLevel, functionName: String, fileName: String, lineNumber: Int) -> String? {
        let msg = super.log(message, level: level, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        if let msg = msg, !msg.isEmpty, level.rawValue >= fileLevel.rawValue {
            writeToFile(message: "\n\(msg)")
        }
        return msg
    }
    
    init(owner: Any, level: LogLevel = .debug, fileLevel: LogLevel = .verbose, excluded: [Any] = []) {
        self.fileLevel = fileLevel
        super.init(owner: owner, level: level, excluded: excluded)
    }
    
    /// Minimum log level to be written to log file.
    var fileLevel: LogLevel

    /// URL of the file, logs will be written to.
    let fileURL : URL? = FileLog.sessionFileURL

    /// Attempts to write to the log file, if failed will log a warning to the console.
    /// - Parameter message: A message to be written.
    private func writeToFile(message: String) {
        guard let filePath = self.fileURL,
              let writer = try? FileHandle(forWritingTo: filePath),
                let data = message.data(using: .utf8) else {
            super.log("FileLog failed to write message.", level: .warning, functionName: #function, fileName: #file, lineNumber: #line)
                return
        }

        writer.seekToEndOfFile()
        writer.write(data)
        writer.closeFile()
    }

    static var logFileURLs : [URL]? {
        guard let root = sessionFileURL?.deletingLastPathComponent() else {
            return nil
        }
        return logFileURLs(at: root)
    }

    /// Gets a list of `URL`s for all existing log files.
    /// - Parameter url: `URL` of directory containing log files.
    /// - Returns: A list of file urls sorted by creation date in descending order.
    fileprivate static func logFileURLs(at url: URL) -> [URL]? {
        guard let urls = try? FileManager.default.contentsOfDirectory(at: url,
                includingPropertiesForKeys: [.creationDateKey],
                options: .skipsHiddenFiles) else {
            return nil
        }

        return urls.filter { url in
            let name = url.lastPathComponent
            guard let prefix = name.range(of: FileLog.fileNamePrefix)?.lowerBound else {
                return false
            }
            return prefix == name.startIndex
        }.sorted { (lhs, rhs) in
            let lDate = self.getFileCreationDate(at: lhs)
            let rDate = self.getFileCreationDate(at: rhs)
            return lDate > rDate
        }
    }

    // MARK: - Static properties.

    /// Default log file prefix. 
    /// - Note: It's important to use any prefix to identify log files.
    fileprivate static let fileNamePrefix = "log--"

    /// Default log file extension.
    fileprivate static let fileExtension = ".txt"

    /// A file name generated for current session.
    fileprivate static let fileName : String = {
        let date = logDate.toString(withFormat: "yyyy-MM-dd HH:mm:ss")
        return "\(fileNamePrefix)\(date)\(fileExtension)"
    }()
    
    /// Log file `URL`, generated for current session.
    fileprivate static let sessionFileURL : URL? = createLogFile()

    /// A default directory for the log files.
    /// - Note: This path is relative to the default `documentsDirectory`.
    fileprivate static let logsDirectoryPath = "Logs"

    /// A number of log files to be stored at the same time.
    /// When creating a new log file which will exceed this number the oldest log files will be deleted.
    fileprivate static let maximumLogFiles = 3

    /// A creation date of the log. Used to identify current log in a list of logs.
    fileprivate static let logDate : Date = Date()
}

// MARK: - One-time file initialization
private extension FileLog {

    /// Performs one time setup needed to create a new file on demand and clean up existing logs.
    /// - Returns: `URL` locating new log file to be used.
    static func createLogFile() -> URL? {
        let fileManager = FileManager.default

        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        let logDirURL = documentsURL.appendingPathComponent(FileLog.logsDirectoryPath)
        let fileURL = logDirURL.appendingPathComponent(FileLog.fileName)

        if !fileManager.fileExists(atPath: fileURL.path) {
            try? fileManager.createDirectory(at: logDirURL, withIntermediateDirectories: true)
            guard fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil) else {
                print("Failed to create log file at \(fileURL.path)")
                return nil
            }
        }

        removeOldLogs(from: logDirURL)

        return fileURL
    }

    /// Removes the oldest log files from specified directory to keep `maximumLogFiles`.
    /// - Parameter url: Root directory containing logs.
    static func removeOldLogs(from url: URL) {
        guard let logs = logFileURLs(at: url),
              logs.count > maximumLogFiles else {
            return
        }

        logs.dropFirst(maximumLogFiles) // Skip most recent files.
                .forEach { // Remove any older files.
                    try? FileManager.default.removeItem(at: $0)
                }
    }

    /// Gets creation date of resource at specified `url`.
    /// - Parameter url: `URL` of the file to be read.
    /// - Returns: Creation date of the file if available, otherwise `Date.distantPast` will be returned instead.
    static func getFileCreationDate(at url: URL) -> Date {
        return (try? url.resourceValues(forKeys: [.creationDateKey]))?.creationDate ?? Date.distantPast
    }
}
