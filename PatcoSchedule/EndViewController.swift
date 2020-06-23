//
//  EndViewController.swift
//  PatcoSchedule
//
//  Created by Rob Surrette on 8/27/17.
//  Copyright © 2017 Rob Surrette. All rights reserved.
//

import UIKit
import GoogleMobileAds

class EndViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //setting up for AdMob
        bannerView.isHidden = true
        bannerView.delegate = self

        
        //Change nav bar to red
        navigationController?.navigationBar.barTintColor = UIColor(red: 209/255, green: 17/255, blue: 64/255, alpha: 1.00)
        
        //Nav bar text is white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.title = "Destination Station"
        
        //back button
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(named: "back100"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(EndViewController.back))
        self.navigationItem.leftBarButtonItem = backButton
        self.automaticallyAdjustsScrollViewInsets = true
        backButton.tintColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
    
    
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 13
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "endStationCell", for: indexPath)
        
        //change start station to be gray-ed out and non slectable
        if stationList[indexPath.row] == stationList[startStation] {
            cell.textLabel?.text = stationList[indexPath.row]
            cell.isUserInteractionEnabled = false
            cell.textLabel?.textColor = UIColor.lightGray
            cell.textLabel?.font = UIFont(name:"Avenir", size:22)
        } else {
            cell.isUserInteractionEnabled = true
            cell.textLabel?.textColor = UIColor.black
            cell.textLabel?.text = stationList[indexPath.row]
            cell.textLabel?.font = UIFont(name:"Avenir", size:22)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        endStation = indexPath.row
        finalStartTimes = []
        finalEndTimes = []
        finalTime = []
        
        timeDiffFinal = []
        timeDiffMin = []
        timeDiffHour = []
        performSegue(withIdentifier: "segueTwo", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
