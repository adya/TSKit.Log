public class FileLogEntryWriter: AnyLogEntryWriter {

    public var interceptors: [AnyLogInterceptor]

    public var decorator: AnyLogEntryDecorator

    public let logFile: URL

    private let fileHandle: FileHandle

    public init?(logFile: URL,
                 decorator: AnyLogEntryDecorator = DefaultLogEntryDecorator(),
                 interceptors: AnyLogInterceptor...) {
        self.logFile = logFile
        self.decorator = decorator
        self.interceptors = interceptors
        do {
            try? FileManager.default.createDirectory(at: logFile.deletingLastPathComponent(),
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
            FileManager.default.createFile(atPath: logFile.standardizedFileURL.absoluteString, contents: nil, attributes: nil)
            fileHandle = try FileHandle(forWritingTo: logFile)
        } catch {
            print("Failed to open file handler with error: \(error)")
            return nil
        }
    }

    deinit {
        fileHandle.closeFile()
    }

    public func write(_ entry: LogEntry) {
        if let message = (decorator.decorate(entry) ==> {"\n\($0)"}).data(using: .utf8) {
            fileHandle.write(message)
        } else {
            print("Failed to write entry \(entry).")
        }
    }
}
