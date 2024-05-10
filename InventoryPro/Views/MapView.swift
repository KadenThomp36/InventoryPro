//
//  MapView.swift
//  InventoryPro
//
//  Created by Kaden Thompson on 3/13/24.
//

import Foundation
import MapKit
import SwiftUI

struct MapView: View {
    
    @State var region: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.0, longitude: 45.0), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    
    var lat: Double
    var long: Double
    
    var body: some View {
        Map(position: $region, interactionModes: [])
            .edgesIgnoringSafeArea(.all)
            .onChange(of: lat, { oldValue, newValue in
                print("map update with", lat, long)

                region = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
            })
            .onAppear(){
                print("map init with", lat, long)

                region = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
            }
            
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(lat: 45.0, long: 45.0)
    }
}

