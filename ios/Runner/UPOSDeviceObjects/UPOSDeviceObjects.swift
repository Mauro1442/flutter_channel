
var p1 = UPOSDeviceObjects1.instance.printerCon
let m1 = UPOSDeviceObjects1.instance.msrCon
let s1 = UPOSDeviceObjects1.instance.scrCon
let c1 = UPOSDeviceObjects1.instance.cdCon
let pL1 = UPOSDeviceObjects1.instance.printerList
let mL1 = UPOSDeviceObjects1.instance.msrList
let sL1 = UPOSDeviceObjects1.instance.scrList
let cL1 = UPOSDeviceObjects1.instance.cdList

let p2 = UPOSDeviceObjects2.instance.printerCon
let m2 = UPOSDeviceObjects2.instance.msrCon
let s2 = UPOSDeviceObjects2.instance.scrCon
let c2 = UPOSDeviceObjects2.instance.cdCon
let pL2 = UPOSDeviceObjects2.instance.printerList
let mL2 = UPOSDeviceObjects2.instance.msrList
let sL2 = UPOSDeviceObjects2.instance.scrList
let cL2 = UPOSDeviceObjects2.instance.cdList


class UPOSDeviceObjects1:NSObject {
    static let instance = UPOSDeviceObjects1()
    var printerCon  = UPOSPrinterController()
    var printerList = UPOSPrinters()
    var msrCon      = UPOSMSRController()
    var msrList     = UPOSMSRs()
    var scrCon      = UPOSSCRController()
    var scrList     = UPOSSCRs()
    var cdCon       = UPOSCDController()
    var cdList      = UPOSCashDrawers()
    
    override init() {
        super.init()
        printerList = printerCon.getRegisteredDevice() as! UPOSPrinters
        msrList     = msrCon.getRegisteredDevice() as! UPOSMSRs
        scrList     = scrCon.getRegisteredDevice() as! UPOSSCRs
        cdList      = cdCon.getRegisteredDevice() as! UPOSCashDrawers
    }
}

class UPOSDeviceObjects2:NSObject {
    static let instance = UPOSDeviceObjects1()
    var printerCon  = UPOSPrinterController()
    var printerList = UPOSPrinters()
    var msrCon      = UPOSMSRController()
    var msrList     = UPOSMSRs()
    var scrCon      = UPOSSCRController()
    var scrList     = UPOSSCRs()
    var cdCon       = UPOSCDController()
    var cdList      = UPOSCashDrawers()
    
    override init() {
        super.init()
        printerList = printerCon.getRegisteredDevice() as! UPOSPrinters
        msrList     = msrCon.getRegisteredDevice() as! UPOSMSRs
        scrList     = scrCon.getRegisteredDevice() as! UPOSSCRs
        cdList      = cdCon.getRegisteredDevice() as! UPOSCashDrawers
    }
}
