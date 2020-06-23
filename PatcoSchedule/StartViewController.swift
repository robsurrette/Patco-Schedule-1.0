//
//  StartViewController.swift
//  PatcoSchedule
//
//  Created by Rob Surrette on 8/27/17.
//  Copyright © 2017 Rob Surrette. All rights reserved.
//

import UIKit
import GoogleMobileAds

var stationList = ["Lindenwold", "Ashland", "Woodcrest", "Haddonfield", "Westmont", "Collingswood", "Ferry Avenue", "Broadway", "City Hall", "8th & Market", "9/10th & Locust", "12/13th & Locust", "15/16th & Locust"]
var startStation = 0
var endStation = 0

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up for AdMob
        bannerView.isHidden = true
        bannerView.delegate = self

        
        //Change nav bar to red
        navigationController?.navigationBar.barTintColor = UIColor(red: 209/255, green: 17/255, blue: 64/255, alpha: 1.00)
        
        //Nav bar text is white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Set nav bar text to Origin Station
        self.navigationItem.title="Origin Station"
        
        //Check if user has bought Remove Ads or not
        let save = UserDefaults.standard
        if save.value(forKey: "Purchase") == nil {
            
            bannerView.adUnitID = "ca-app-pub-1650430001549870/3815844675"
            bannerView.adSize = kGADAdSizeSmartBannerPortrait
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            
        } else {
            
            bannerView.isHidden = true
            
        }
        
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0 //set row height
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "startStationCell", for: indexPath)
        
        cell.textLabel?.text = stationList[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Avenir", size:22)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        startStation = indexPath.row
        
        performSegue(withIdentifier: "segueOne", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
