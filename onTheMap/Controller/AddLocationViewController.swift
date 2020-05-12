//
//  AddLocationViewController.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/3/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddLocationViewController: UIViewController {

    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var sharedLinkTextField: UITextField!
    @IBOutlet var findLocationButton: LoginButton!
    @IBOutlet var activityIndecator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGecoding(false)
    }

    @IBAction func findLocationPressed(_ sender: Any) {
        setGecoding(true)
        performSegue(withIdentifier: "FindLocation", sender: self)
    }
    
    func getAddress(completion: @escaping (CLLocationCoordinate2D?)->() ) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(locationTextField.text ?? "") { (placemark, error) in
            guard let placemark = placemark, let location = placemark.first?.location else {
                completion(nil)
                return
            }
            completion(location.coordinate)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FindLocation", let controller = segue.destination as? AddLocationMapViewController {
            self.getAddress { (location) in
                if let location = location {
                    controller.location = location
                }
            }
            controller.mediaURL = sharedLinkTextField.text ?? ""
            controller.mapString = locationTextField.text ?? ""
        }
    }
}

extension AddLocationViewController {
    
    func setGecoding(_ geoCoding: Bool) {
        geoCoding ? activityIndecator.startAnimating() : activityIndecator.stopAnimating()
        
        locationTextField.isEnabled = !geoCoding
        sharedLinkTextField.isEnabled = !geoCoding
        findLocationButton.isEnabled = !geoCoding
    }
}
