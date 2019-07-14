//
//  ViewController.swift
//  Maps App
//
//  Created by maurice on 7/10/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
	
	@IBOutlet weak var mapView: MKMapView!
	
	let locationManager = CLLocationManager()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		
		// calling the update saved pin function
		updateSavedPin()
	}
	func updateSavedPin() {
		if let oldCoords = DataStore().getLastLocation() {
			
			let annoRem = mapView.annotations.filter{$0 !== mapView.userLocation}
			mapView.removeAnnotations(annoRem)
			
			let mjAnnotation = MKPointAnnotation()
			mjAnnotation.coordinate.latitude = Double(oldCoords.latitude)!
			mjAnnotation.coordinate.longitude = Double(oldCoords.longitude)!
			
			mjAnnotation.title = "Maurice was here!"
			mjAnnotation.subtitle = "Remember?"
			mapView.addAnnotation(mjAnnotation)
		}
	}
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		guard status == .authorizedWhenInUse else {
			print("Bruh, you did not authorize location! Godaamn!")
			return
		}
		
		print("Location when in use allowed by the user")
		mapView.showsUserLocation = true
	}
	@IBAction func saveButtonClicked(_ sender: Any) {
		let coord = locationManager.location?.coordinate
		
		if let lat = coord?.latitude {
			if let long = coord?.longitude {
				// saving location in the userdefaults
				
				DataStore().storeDataPoint(latitude: String(lat), longitude: String(long))
				updateSavedPin()			}
		}
		
		
		
		
		
	}
	
	
}

