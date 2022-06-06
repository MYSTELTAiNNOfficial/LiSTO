//
//  MapsResto.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 02/06/22.
//

import SwiftUI
import MapKit

struct MapsResto: View {
    var coordinate: CLLocationCoordinate2D

    var body: some View {
        Map(coordinateRegion: .constant(region))
    }

    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

struct MapsResto_Previews: PreviewProvider {
    static var previews: some View {
        MapsResto(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
    }
}
