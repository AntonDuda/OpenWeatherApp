//
//  OpenWeatherViewController.swift
//  OpenWeatherApp
//
//  Created by Anton on 07.02.2021.
//

import UIKit
import CoreLocation

class OpenWeatherViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelInformation: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelDayOfWeek: UILabel!
    @IBOutlet weak var labelMaxDayTemp: UILabel!
    @IBOutlet weak var labelMinNightTemp: UILabel!
    
    var weather: [List] = []
    
    let apiManager = APIManager()
    var locationManager: CLLocationManager!
    var kelvin = 273.15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            
        requestUserLocation()
    }
    
    private func requestUserLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }

     private func getData(location: CLLocationCoordinate2D) {

        apiManager.fetchWeather(for: Coordinates(latitude: location.latitude, longitude: location.longitude)) { [weak self] (responce) -> Void in
            guard let sself = self else { return }
                sself.weather = responce!.list
                sself.labelCity.text = responce?.city.name
                sself.labelInformation.text = responce?.city.country
            self!.labelTemp.text = String(Int((self!.weather.first?.temp.day)! - self!.kelvin))
            self!.labelMaxDayTemp.text = String(Int((self!.weather.first?.temp.max)! - self!.kelvin))
            self!.labelMinNightTemp.text = String(Int((self!.weather.first?.temp.min)! - self!.kelvin))
            
            DispatchQueue.main.async {
                sself.tableView.reloadData()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations   locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
            }
        }
        locationManager.stopUpdatingLocation()
        getData(location: CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weath = weather[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {
            fatalError("NewsCollectionViewCell is not registered!")
        }
        
        cell.labelDayOfWeak?.text = String(weath.dt)
        cell.labelDayMaxTemp?.text = String(Int((weath.temp.max) - kelvin))
        cell.labelNightMinTemp?.text = String(Int((weath.temp.min) - kelvin))
        
        return cell
 }
}

