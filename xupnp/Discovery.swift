//
//  Discovery.swift
//  xupnp
//
//  Created by moja on 2020/04/06.
//  Copyright © 2020 moja. All rights reserved.
//

import Foundation
import upnpx

class Discovery : NSObject, ObservableObject , UPnPDBObserver {
    
    @Published var upnpDevices : [BasicUPnPDevice] = []
    
    var upnpdb : UPnPDB?
    
     func rediscover() {
        print(#function)
        upnpDevices.removeAll()
        upnpdb = UPnPManager.getInstance()?.db
        upnpdb?.add(self)
        UPnPManager.getInstance()?.ssdp.setUserAgentProduct("Xupnp 1.0", andOS: "IOS13ver")
        _ = UPnPManager.getInstance()?.ssdp.searchSSDP
        
        upnpDevices = upnpdb?.rootDevices as! [BasicUPnPDevice]
    }
    
    override init() {
        super.init()
        guard  upnpdb == nil else {
            return
        }
        rediscover()
        
    }
    
    
    func uPnPDBUpdated(_ sender: UPnPDB!) {
        DispatchQueue.main.async {
            self.upnpDevices = sender.rootDevices as! [BasicUPnPDevice]
        }
    }
}
