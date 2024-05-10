//
//  MapView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 3/13/24.
//

import Foundation
import MapKit
import SwiftUI

struct MapViewDynamic: View {
    
    @State var region: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.0, longitude: 45.0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    
    @Binding var location: Location
//    @Binding var long: Double
    
    var body: some View {
        Map(position: $region, interactionModes: [])
            .edgesIgnoringSafeArea(.all)
            .onChange(of: location, { oldValue, newValue in
                print("map update with", location.latitude, location.longitude)

                region = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
            })
            .onAppear(){
                print("map init with", location.latitude, location.longitude)

                region = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
            }
            
    }
    
}

struct MapViewDynamic_Previews: PreviewProvider {
    static var previews: some View {
        let newLoc = Location(name: "", latitude: 45.0, longitude: 45.0)
        MapViewDynamic(location: .constant(newLoc))
    }
}

