//
//  ViewController.swift
//  Swift101ConvertCoordinates
//
//  Created by David Seek on 9/5/18.
//  Copyright © 2018 David Seek. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    
    // - Outlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    // - Constants
    private let locationManager = LocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCurrentLocation()
        self.setParisMapLocation()
    }
    
    private func setCurrentLocation() {
        
        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }
        
        self.locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            
            var output = "Our location is:"
            if let country = placemark.country {
                output = output + "\n\(country)"
            }
            if let state = placemark.administrativeArea {
                output = output + "\n\(state)"
            }
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            self.locationLabel.text = output
        }
    }
    
    private func setParisMapLocation() {
        
        let eiffelTower = "Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France"
        
        self.locationManager.getLocation(forPlaceCalled: eiffelTower) { location in
            guard let location = location else { return }
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
}

