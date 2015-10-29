
import Foundation

struct Country {
    var name: String
    var region: String
    var subRegion: String
}

class Countries {
    
    var countryData = [Country]()
    
    // how do I call it?
    static let getInstance = Countries()
    
    private init(completionHandler: (Bool)) {
        // do some async stuff
        completionHandler(true)
    }
    
}

// https://restcountries.eu/rest/v1/all