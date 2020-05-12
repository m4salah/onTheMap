//
//  AddLocationMapViewController.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/3/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController {

    var location: CLLocationCoordinate2D!
    var mediaURL: String!
    var mapString: String!
    
    @IBOutlet var addLocationMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLocationMap.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleUserLocation()
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        OTMClient.getUsername { (success, error) in
            if success {
                OTMClient.postStudent(mapString: self.mapString, mediaURL: self.mediaURL, longitude: self.location.longitude, latitude: self.location.latitude) { (student, error) in
                    if let student = student {
                        StudentModel.student.append(student)
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            } else {
                self.showAlertError(title: "Check Internet Connection", message: error?.localizedDescription ?? "check Internet Connection and Try Again")
            }
        }
    }
    
    func handleUserLocation() {
        let annotation = MKPointAnnotation()
        guard let location = location else {
            showAlertError(title: "Try Differnt Location",message: "This Location is not Avialable try differnt one")
            return
        }
        annotation.coordinate = location
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: StudentModel.regionMeter, longitudinalMeters: StudentModel.regionMeter)
        addLocationMap.addAnnotation(annotation)
        addLocationMap.setRegion(region, animated: true)
    }
    
}

extension AddLocationMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
}

