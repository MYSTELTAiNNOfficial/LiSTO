//
//  Resto.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 31/05/22.
//

import Foundation
import CoreLocation

struct AllRestoData : Hashable, Codable, Identifiable {
    var id: Int
    var nama_resto: String
    var img: String
    var favorite: String
}

struct AllResto: Codable {
    var resto: [AllRestoData]
}

struct RestoData: Codable, Identifiable {
    var id: Int
    var nama_resto: String
    var img: String
    var rating: Int
    var detail: String
    var latitude: Double
    var longitude: Double
    var fav: String
    
    var mapResto: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
    
    static let `default` = RestoData(id: 0, nama_resto: "", img: "", rating: 0, detail: "", latitude: 0, longitude: 0, fav: "")
}
