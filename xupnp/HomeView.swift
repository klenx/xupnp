//
//  ContentView.swift
//  xupnp
//
//  Created by moja on 2020/04/06.
//  Copyright © 2020 moja. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject  var devices : Discovery
    
    var body: some View {
        NavigationView {
            List(devices.upnpDevices, id: \.self) { device in
                VStack(alignment: .leading, spacing: 8){
                    Image(uiImage: device.smallIcon).resizable().frame(width: 120, height: 120)
                    Text(device.friendlyName)
                }
            }.navigationBarTitle("XUPNP")
                .navigationBarItems(trailing: Button(action: {
                    self.devices.rediscover()
                }) {
                    Image(systemName: "arrow.clockwise.circle").font(.title)
                })
        }
    }
}

