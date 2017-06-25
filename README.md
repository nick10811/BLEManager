# BLEManager

## Descriptions
This is a library of Bluetooth 4.0 which based on iOS. It makes you easy to implement Bluetooth technique on your project. First of all, you should initial object of BLEManager, it is a singleton object, then you can re-use in your program by the method of “sharedManager”. When you need to communicate with device, you should use the method of “scanningForServicesWithPeripheral“ to search all services and characters first. It is an important procedure before you want to send or receive data with device. If you do not use this method, it cannot correct to communicate with device. When the length of transmission data is too long, the write/read method may has long time to process.

## Installation

* BLEManager is available through [CocoaPods](http://cocoapods.org).
* You can also download the BLEManager.{m,h} files into your project directly.

## How to use

* Inital this object
```objc
+ (BLEManager *)sharedManagerWithDelegate:(id<BLEManagerDelegate>)delegate;
```

* Reuse object (singleton)
```objc
+ (BLEManager *)sharedManager;
```

* Kill object
```objc
- (void)disableBLEManager;
```

* Check bluetooth  device is connected
```objc
- (BOOL)isConnecting;
```

* Scan all devices
```objc
- (void)scanningForPeripherals;
```

* Scan all devices by restricted distance
```objc
- (void)scanningForPeripheralsWithDistance:(int)RSSI;
```

* Stop scan devices
```objc
- (void)stopScanningForPeripherals;
```

* Connect specified device
```objc
- (void)connectingPeripheral:(CBPeripheral *)peripheral;
```

* Disconnect specified device
```objc
- (void)disconnectPeripheral:(CBPeripheral *)peripheral;
```

* Get Received Signal Strength Indicator(RSSI) by device
```objc
- (int)readRSSI:(CBPeripheral *)peripheral;
```

* Scan all services in the device
```objc
- (void)scanningForServicesWithPeripheral:(CBPeripheral *)peripheral;
```

### Communicate with device after scanning all services
* Write data to device
```objc
- (NSError *)setValue:(NSData *) data forServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral;
```

* Read data from device
```objc
- (NSData *)readValueForServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral;
```

