//
//  ViewController.swift
//  HWS Project 16
//
//  Created by Christopher Koski on 10/9/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
  @IBOutlet var mapView: MKMapView!
  @IBOutlet var viewButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago")
    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the city of light")
    let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it")
    let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.89511, longitude: -77.036667), info: "Named after George himself")
    
    mapView.addAnnotations([london, oslo, paris, rome, washington])
    
    
    viewButton.title = "View"
    
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView? {
    guard annotation is Capital else { return nil }
    
    let identifier = "Capital"
    
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
    
    
    if annotationView == nil {
      
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = true
      
      let btn = UIButton(type: .detailDisclosure)
      annotationView?.rightCalloutAccessoryView = btn
    } else {
      annotationView?.annotation = annotation
    }
    annotationView?.pinTintColor = .green
    
    return annotationView
    
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let capital = view.annotation as? Capital else { return }
    
    let placeName = capital.title
    let placeInfo = capital.info
    
    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  @IBAction func viewButtonTapped(_ sender: Any) {
    let ac = UIAlertController(title: "Choose view style", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: selectSatellite))
    ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: selectHybrid))
    ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: selectStandard))
    ac.addAction(UIAlertAction(title: "Cancel", style: .default))
    present(ac, animated: true)
    
  }
  
  func selectSatellite(alert: UIAlertAction) {
    mapView.mapType = .satellite
  }
  func selectHybrid(alert: UIAlertAction) {
    mapView.mapType = .hybrid
  }
  func selectStandard(alert: UIAlertAction) {
    mapView.mapType = .standard
  }
}
