//
//  LocationDetailsView.swift
//  MapApp
//
//  Created by Elouan Savy on 07/05/2024.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    
    @EnvironmentObject var vm: LocationViewModel
    let location: Location
    
    var body: some View {
            ScrollView {
                VStack {
                    ImageSection
                        .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 10)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        TitleSection
                        Divider()
                        DescriptionSection
                        Divider()
                        MapLayer
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .ignoresSafeArea()
            .background(.ultraThinMaterial)
            .overlay(alignment: .topLeading) {
                BackButton
            }
    }
}

#Preview {
    LocationDetailsView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationViewModel())
}

extension LocationDetailsView {
    private var ImageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var TitleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    private var DescriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
                    .padding(.top, 16)
            }
        }
    }
    
    private var MapLayer: some View {
        Map(position: .constant(MapCameraPosition.region(
            MKCoordinateRegion(
                center: location.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        ))) {
            Annotation(location.name, coordinate: location.coordinates) {
                LocationMapAnnotation()
                    .shadow(radius: 10)
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var BackButton: some View {
        Image(systemName: "xmark")
            .font(.headline)
            .padding(16)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 4)
            .padding()
            .onTapGesture {
                vm.sheetLocation = nil
            }
    }
}
