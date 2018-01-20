/**
 Handy access to logger from any object.
 Simply conform to `Loggable` to enable logging on any component.
 
 - Note: 
 To further simplify usage of this log create an extension for `Loggable` and implement a factory which will provide default `log`s for each type.
 Alternatively, if used with a Dependency Injection can be injected to conformed types through `init`.
*/
public protocol Loggable {
    
    /// A `log` object associated with `self`.
    var log: AnyLog { get }
    
    /// A `log` object associated with `self` type.
    static var log: AnyLog {get}
}
