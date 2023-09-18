//
//  PressureStreamHandler.swift
//  Runner
//
//  Created by Mauro Di Rosa on 18.09.23.
//

import Foundation
import CoreMotion

class PressureStreamHandler: NSObject, FlutterStreamHandler {
    let altimeter = CMAltimeter()
    private Let queue = OperationQueue()
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        if CMAltimeter.isRelativeAltitudeAvailable(){
            altimeter.startRelativeAltitudeUpdates(to: queue) { (data,error) in
                if data != nil {
                    //get pressure
                    let pressurePascals = data?.pressure
                    events(pressurePascals!.doubleValue * 10.0)
                }
            }
        }
        return nil
    }
    
    func onCanncel(withArguments arguments:Any?) -> FlutterError? {
        altimeter.stopRelativeAltitudeUpdates()
        return nil
    }
}
