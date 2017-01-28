//
//  Properties.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// Properties class, the only Class Model due to OOP requirements
import Foundation
enum RouteType: String {
    case none = "--"
    case public_transport = "Public Transport"
    case car_sharing = "Car Sharing"
    case private_bike = "Private Bike"
    case bike_sharing = "Bike Sharing"
    case taxi = "Taxi"
}
public class Properties {
    
    static func createObject(fromData data: NSDictionary, ofType type: RouteType)-> Properties? {
        
        switch type {
        case .car_sharing:
            return CarSharingProperties.createObject(fromData: data)
        case .bike_sharing:
            return BikeSharingProperties.createObject(fromData: data)
        case .taxi:
            return TaxiProperties.createObject(fromData: data)
        default:
            return nil
        }
        
    }
}

public class CarSharingProperties: Properties {
    
    var address: String? = nil
    var model: String? = nil
    var licencePlate: String? = nil
    var fuelLevel: Int? = nil
    var engineType: String? = nil
    var internalCleanliness: String? = nil
    var description: String? = nil
    var seats: String? = nil
    var doors: String? = nil
    
    static func createObject(fromData data: NSDictionary)-> CarSharingProperties {
        
        let properties = CarSharingProperties()
        properties.address = data.value(forKey: "address") as? String
        properties.model = data.value(forKey: "model") as? String
        properties.licencePlate = data.value(forKey: "licencePlate") as? String
        properties.fuelLevel = data.value(forKey: "fuelLevel") as? Int
        properties.engineType = data.value(forKey: "engineType") as? String
        properties.internalCleanliness = data.value(forKey: "internal_cleanliness") as? String
        properties.description = data.value(forKey: "description") as? String
        properties.seats = data.value(forKey: "seats") as? String
        properties.doors = data.value(forKey: "doors") as? String
        
        return properties
        
    }
    
}

public class BikeSharingProperties: Properties {
    
    var id: String? = nil
    var availableBikes: Int? = nil
    
    static func createObject(fromData data: NSDictionary)-> BikeSharingProperties {
        
        let properties = BikeSharingProperties()
        properties.id = data.value(forKey: "id") as? String
        properties.availableBikes = data.value(forKey: "available_bikes") as? Int
        return properties
        
    }
    
}

public class TaxiProperties: Properties {
    
    public struct Company {
        var name: String? = nil
        var phone: String? = nil
        
        static func createObject(fromData data: NSDictionary)-> Company {
            var company = Company()
            company.name = data.value(forKey: "name") as? String
            company.phone = data.value(forKey: "phone") as? String
            return company
        }
    }
    
    var companies: [Company] = []
    
    static func createObject(fromData data: NSDictionary)-> TaxiProperties {
        
        let properties = TaxiProperties()
        
        let values = data.value(forKey: "companies") as! [NSDictionary]
        for company in values {
            properties.companies.append(Company.createObject(fromData: (company)))
        }
        
        return properties
        
    }
    
}
