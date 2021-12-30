//
//  LoactionManger.swift
//  GPSDemo
//
//  Created by will on 2021/12/29.
//

import Foundation
import CoreLocation

class LocationMannger: NSObject {
    
    static let shared = LocationMannger()
    
    private var locationManger = CLLocationManager()
    
    //使用者座標
    var userCoordinate: CLLocationCoordinate2D? = nil
    //授權座標裝態
    var locationAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    
    //初始化定位協定
    private override init() {
        super.init()
        locationManger.delegate = self
        //設定 gps移動多少距離更新使用者最新位置資訊
        locationManger.distanceFilter = kCLLocationAccuracyNearestTenMeters
        //設定 取得自己gps定位的精準度
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func askPermission() {
        if #available(iOS 14.0, *) {
            locationAuthorizationStatus = locationManger.authorizationStatus
        } else {
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        switch locationAuthorizationStatus {
        case .notDetermined:
            //還沒決定
            locationManger.requestWhenInUseAuthorization()
            locationManger.startUpdatingLocation()
        case .restricted, .denied:
            //沒有權限
            break
        case .authorizedAlways, .authorizedWhenInUse:
            //允許過權限
            locationManger.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}

extension LocationMannger: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard userCoordinate == nil else {
            return
        }
        //取得使用者座標
        userCoordinate = manager.location?.coordinate
        //更新使用者座標
        manager.stopUpdatingLocation()
        
        guard let lat = userCoordinate?.latitude,
        let lon = userCoordinate?.longitude else {
            print("取得使用者座標失敗")
            return
        }
        
        print("User lat: = 緯度 \(lat)") //緯度
        print("User lon: = 經度 \(lon)") //經度
        
    }
}
