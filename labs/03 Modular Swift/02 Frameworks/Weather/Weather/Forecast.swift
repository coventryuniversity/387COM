
import Foundation

class Forecast {
    class var getInstance:Forecast {
        return _getInstance
    }
}
private let _getInstance = Forecast()
