import Vapor
import HTTP


/// Here we have a controller that helps facilitate
/// creating typical REST patterns
final class HomeController: ResourceRepresentable {
    enum Weekday: Int {
        case monday = 2
        case tuesday = 3
        case wednesday = 4
        case thursday = 5
        case friday = 6
        case saturday = 7
        case sunday = 1
        case unknown = 0

        var message: String {
            switch self {
            case .monday:
                return "it's monday: aspire(and caffeinate)"
            case .tuesday:
                return "tuesday– wednesday's monday"
            case .wednesday:
                return "it's wednesday, you're halfway there!"
            case .thursday:
                return "thursday? you mean friday-eve"
            case .friday:
                return "happy friday!"
            case .saturday:
                return "it's saturday, nice!"
            case .sunday:
                return "#endSundayScaries"
            case .unknown:
                return "welcome!"
            }
        }
    }

    var dayOfWeek: Weekday {
        let date = Date()
        let int = date.weekday
        return Weekday(rawValue: int) ?? .unknown
    }

    let view: ViewRenderer
    let date = Date()
    init(_ view: ViewRenderer) {
        self.view = view
    }

    /// GET /home
    func index(_ req: Request) throws -> ResponseRepresentable {
        return try view.make("home", [
            "dailyMessage": dayOfWeek.message
        ], for: req)
    }

//    /// GET /home/:string
//    func show(_ req: Request, _ string: String) throws -> ResponseRepresentable {
//        return try view.make("home", [
//            "dailyMessage": string
//        ], for: req)
//    }

    /// When making a controller, it is pretty flexible in that it
    /// only expects closures, this is useful for advanced scenarios, but
    /// most of the time, it should look almost identical to this
    /// implementation
    func makeResource() -> Resource<String> {
        return Resource(
            index: index
        )
    }
}
