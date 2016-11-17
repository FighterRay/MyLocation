//
//  FirstViewController.swift
//  MyLocation
//
//  Created by 张润峰 on 2016/11/9.
//  Copyright © 2016年 FighterRay. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    let locationManager = CLLocationManager();
    
    var location: CLLocation?
    var updatingLocaion = false
    var lastLocationError: Error?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        configureGetButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getLocation(_ sender: UIButton) {
        
        // authorization
        let authStates = CLLocationManager.authorizationStatus()
        
        if authStates == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        // alert
        if authStates == .denied || authStates == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        if updatingLocaion {
            stopLocationManager()
        } else {
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        
        updateLabels()
        configureGetButton()
    }
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "地图服务无法使用", message: "请在系统设置里打开本应用的地图服务权限", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "好的", style: .default, handler: nil)
   
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)")
        
        // For now It can't get any location imformation, but that doesn't mean all is lost.
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        
        lastLocationError = error
        
        stopLocationManager()
        updateLabels()
        configureGetButton()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")
        
//        location = newLocation
//        updateLabels()
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            return
        }
        
        // filtrate invalid location
        if newLocation.horizontalAccuracy < 0 {
            return
        }
        
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
            lastLocationError = nil
            location = newLocation
            updateLabels()
            
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("We are done!")
                stopLocationManager()
                configureGetButton()
            }
        }
    }
    
    // MARK: -
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocaion = true
        }
    }
    
    func stopLocationManager() {
        if updatingLocaion {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocaion = false
        }
    }
    
    func configureGetButton() {
        if updatingLocaion {
            getButton.setTitle("Stop", for: .normal)
        } else {
            getButton.setTitle("Get My Location", for: .normal)
        }
    }
    
    func updateLabels() {
        if let location = location {
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8", location.coordinate.longitude)
            tagButton.isHidden = false
            messageLabel.text = ""
        } else {
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            addressLabel.text = ""
            tagButton.isHidden = true
            messageLabel.text = "Tap 'Get My Location' to Start"
            
            // something wrong
            let statusMessage: String
            if let error = lastLocationError as? NSError {
                if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
                    statusMessage = "地图服务暂不能用"
                } else {
                    statusMessage = "获取定位失败"
                }
            } else if !CLLocationManager.locationServicesEnabled() {
                statusMessage = "地图服务暂不能使用"
            } else if updatingLocaion {
                statusMessage = "正在定位中..."
            } else {
                statusMessage = "Tap 'Get My Location' to Start"
            }
            
            messageLabel.text = statusMessage
        }
    }
}

