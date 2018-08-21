//
//  ViewController.swift
//  MapViewTest
//
//  Created by Den Jo on 25/04/2018.
//  Copyright © 2018 Den Jo. All rights reserved.
//

import UIKit
import MapKit


final class ViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var mapTypeSegmentedControl: UISegmentedControl!
    
    
    // MARK: - Value
    // MARK: Private
    private var dataManager = DataManager()
    
    private var zoomLevel: Int {
        return Int(log2(mapView.visibleMapRect.size.width))
    }
    
    // Cache
    private var overlays = [MKOverlay]()
    
    
    // MARK: - View Delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard dataManager.requestProducts() == true else { return }
        setMapView()
    }
    
    
    // MARK: - Function
    // MARK: Private
    private func setMapView() {
        if #available(iOS 11, *) {
            mapView.register(AnnotationView1.self,       forAnnotationViewWithReuseIdentifier: AnnotationView1Info.identifier)
            mapView.register(AnnotationView2.self,       forAnnotationViewWithReuseIdentifier: AnnotationView2Info.identifier)
            mapView.register(AnnotationView3.self,       forAnnotationViewWithReuseIdentifier: AnnotationView3Info.identifier)
            mapView.register(AnnotationView4.self,       forAnnotationViewWithReuseIdentifier: AnnotationView4Info.identifier)
            mapView.register(AnnotationView5.self,       forAnnotationViewWithReuseIdentifier: AnnotationView5Info.identifier)
            mapView.register(AnnotationView6.self,       forAnnotationViewWithReuseIdentifier: AnnotationView6Info.identifier)
            mapView.register(AnnotationView7.self,       forAnnotationViewWithReuseIdentifier: AnnotationView7Info.identifier)
            mapView.register(AnnotationView8.self,       forAnnotationViewWithReuseIdentifier: AnnotationView8Info.identifier)
            mapView.register(AnnotationView9.self,       forAnnotationViewWithReuseIdentifier: AnnotationView9Info.identifier)
            mapView.register(AnnotationView10.self,      forAnnotationViewWithReuseIdentifier: AnnotationView10Info.identifier)
            mapView.register(AnnotationView11.self,      forAnnotationViewWithReuseIdentifier: AnnotationView11Info.identifier)
            mapView.register(AnnotationView12.self,      forAnnotationViewWithReuseIdentifier: AnnotationView12Info.identifier)
            mapView.register(AnnotationView13.self,      forAnnotationViewWithReuseIdentifier: AnnotationView13Info.identifier)
            mapView.register(AnnotationView14.self,      forAnnotationViewWithReuseIdentifier: AnnotationView14Info.identifier)
            mapView.register(AnnotationView15.self,      forAnnotationViewWithReuseIdentifier: AnnotationView15Info.identifier)
            mapView.register(AnnotationView16.self,      forAnnotationViewWithReuseIdentifier: AnnotationView16Info.identifier)
            mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: ClusterAnnotationViewInfo.identifier)
            
            /*
            let scaleView = MKScaleView(mapView: mapView)
            scaleView.legendAlignment = .leading
            scaleView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scaleView)
            
            scaleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5.0).isActive         = true
            scaleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
             */
        }
       
        mapView.showAnnotations(dataManager.annotations, animated: true)
    }
    
    
    // MARK: - Event
    @IBAction func mapTypeSegmentedControllAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:     mapView.mapType = .standard
        case 1:     mapView.mapType = .satellite
        case 2:     mapView.mapType = .hybridFlyover
        default:    break
        }
        
        guard mapView.mapType == .hybridFlyover else { return }
        mapView.setCamera(MKMapCamera(lookingAtCenter: mapView.centerCoordinate, fromDistance: 1500.0, pitch: 60.0, heading: 180.0), animated: true)
    }
    
}


// MARK: - MKMapView Delegate
extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if #available(iOS 11.0, *) {
            switch annotation {
            case is PointAnnotation1:        return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView1Info.identifier,       for: annotation)
            case is PointAnnotation2:        return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView2Info.identifier,       for: annotation)
            case is PointAnnotation3:        return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView3Info.identifier,       for: annotation)
            case is PointAnnotation4:        return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView4Info.identifier,       for: annotation)
            case is PointAnnotation5:        return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView5Info.identifier,       for: annotation)
            case is PointAnnotation6:        return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView6Info.identifier,       for: annotation)
            case is PointAnnotation7:        return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView7Info.identifier,       for: annotation)
            case is PointAnnotation8:        return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView8Info.identifier,       for: annotation)
            case is PointAnnotation9:        return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView9Info.identifier,       for: annotation)
            case is PointAnnotation10:       return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView10Info.identifier,      for: annotation)
            case is PointAnnotation11:       return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView11Info.identifier,      for: annotation)
            case is PointAnnotation12:       return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView12Info.identifier,      for: annotation)
            case is PointAnnotation13:       return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView13Info.identifier,      for: annotation)
            case is PointAnnotation14:       return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView14Info.identifier,      for: annotation)
            case is PointAnnotation15:       return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView15Info.identifier,      for: annotation)
            case is PointAnnotation16:       return mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView16Info.identifier,      for: annotation)
            case is MKClusterAnnotation:     return mapView.dequeueReusableAnnotationView(withIdentifier: ClusterAnnotationViewInfo.identifier, for: annotation)
            case is MKUserLocation:          return nil
            default:                         return nil
            }
        
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
       
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard 0 < overlays.count else { return }
        mapView.removeOverlays(overlays)
        overlays.removeAll()
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }
        switch view {
        case is AnnotationView4 where control == view.rightCalloutAccessoryView:
            mapTypeSegmentedControl.selectedSegmentIndex = 2
            mapTypeSegmentedControllAction(mapTypeSegmentedControl)
            
            mapView.deselectAnnotation(view.annotation, animated: true)
            
            UIView.animate(withDuration: 5.0, animations: {
                mapView.setCamera(MKMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 1000.0, pitch: 60.0, heading: 0), animated: true)
            
            }) { (finished) in
                UIView.animate(withDuration: 25.0) {
                    mapView.setCamera(MKMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 1000.0, pitch: 60.0, heading: 180.0), animated: true)
                }
            }
            
        case is AnnotationView5 where control == view.rightCalloutAccessoryView:
            mapTypeSegmentedControl.selectedSegmentIndex = 2
            mapTypeSegmentedControllAction(mapTypeSegmentedControl)
            
            mapView.deselectAnnotation(view.annotation, animated: true)
            
            UIView.animate(withDuration: 5.0, animations: {
                mapView.setCamera(MKMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 1000.0, pitch: 60.0, heading: 0), animated: true)
                
            }) { (finished) in
                UIView.animate(withDuration: 25.0) {
                    mapView.setCamera(MKMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 1000.0, pitch: 60.0, heading: 180.0), animated: true)
                }
            }
            
        case is AnnotationView6 where control == view.rightCalloutAccessoryView:
            guard let center = view.annotation?.coordinate else { return }
            let circle = MKCircle(center: center, radius: 1500.0)
            mapView.addOverlay(circle)
            overlays.append(circle)
            
        case is AnnotationView7 where control == view.rightCalloutAccessoryView:
            guard let annotation = view.annotation else { return }
            mapView.setCenter(annotation.coordinate, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                var rect = mapView.visibleMapRect
                rect.origin.x += rect.size.width/2.0
                rect.origin.y += rect.size.height/2.0
                
                rect.size.width /= 5.0
                rect.size.height = rect.size.width
                
                rect.origin.x -= rect.size.width
                rect.origin.y -= rect.size.height
                
                let overlay = DailyOverlay(coordinate: annotation.coordinate, boundingMapRect: rect)
                mapView.addOverlay(overlay, level: .aboveLabels)
                self.overlays.append(overlay)
            }
            
        case let annotationView as AnnotationView8 where control == view.rightCalloutAccessoryView:
            guard let annotation = view.annotation else { return }
            let request = MKDirections.Request()
            
            let source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.centerCoordinate, addressDictionary: nil))
            source.name    = "Me"
            request.source = source
            
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil))
            destination.name    = (annotationView.annotation as? PointAnnotation8)?.product.name ?? "Hotel"
            request.destination = destination
            
            request.transportType = .transit
            
            let directions = MKDirections(request: request)
            directions.calculateETA { (response, error) in
                guard let response = response, error == nil else { return }
                let alertController = UIAlertController(title: "Info", message: "총 소요시간: \(response.expectedTravelTime)초", preferredStyle: .alert)
                let action = UIAlertAction(title: "길안내", style: .default, handler: { (action) in
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate:annotation.coordinate, addressDictionary: nil))
                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeTransit])
                })
                alertController.addAction(action)
                DispatchQueue.main.async { self.present(alertController, animated: true, completion: nil) }
            }
            
            
            
        default:
            break
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        switch overlay {
        case is DailyOverlay:
            return DailyOverlayRenderer(overlay: overlay)
            
        case let circle as MKCircle:
            let renderer = MKCircleRenderer(circle: circle)
            renderer.fillColor   = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.1747359155)
            renderer.strokeColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.4637709067)
            renderer.lineWidth = 1.0
            return renderer
            
        default:
            return MKOverlayRenderer()
        }
    }
    
}





















