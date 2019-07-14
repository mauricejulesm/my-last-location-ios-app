//
//  DataStore.swift
//  Maps App
//
//  Created by maurice on 7/11/19.
//  Copyright © 2019 maurice. All rights reserved.
//

import Foundation

struct StorageKeys {
	static let storedLat = "storedLat"
	static let storedLong = "storedLong"
}
class DataStore {
	func getDefaults() -> UserDefaults {
		return UserDefaults.standard
	}
	
	func storeDataPoint(latitude: String, longitude:String) {
		let defaults = getDefaults()
		defaults.setValue(latitude, forKey: StorageKeys.storedLat)
		defaults.setValue(longitude, forKey: StorageKeys.storedLong)
		
		defaults.synchronize()
		
		
		print(latitude + " : " + longitude)
	}
	
	func getLastLocation() -> VisitedPoint? {
		let defaults = getDefaults()
		
		if let lat = defaults.string(forKey: StorageKeys.storedLat) {
			if let long = defaults.string(forKey: StorageKeys.storedLong){
				return VisitedPoint(lat: lat, long: long)
			}
		}
		return nil
	}
}

