# BLEManager

## Descriptions
This is a library of Bluetooth 4.0 which based on iOS. It makes you easy to implement Bluetooth technique on your project. First of all, you should initial object of BLEManager, it is a singleton object, then you can re-use in your program by the method of “sharedManager”. When you need to communicate with device, you should use the method of “scanningForServicesWithPeripheral“ to search all services and characters first. It is an important procedure before you want to send or receive data with device. If you do not use this method, it cannot correct to communicate with device. When the length of transmission data is too long, the write/read method may has long time to process.

## Installation

copy Lib folder to your project

## How to use

* Inital this object
```ruby
+ (BLEManager *)sharedManagerWithDelegate:(id<BLEManagerDelegate>)delegate;
```

* Reuse object (singleton)
```ruby
+ (BLEManager *)sharedManager;
```

* Kill object
```ruby
- (void)disableBLEManager;
```

* Check bluetooth  device is connected
```ruby
- (BOOL)isConnecting;
```

* Scan all devices
```ruby
- (void)scanningForPeripherals;
```

* Scan all devices by restricted distance
```ruby
- (void)scanningForPeripheralsWithDistance:(int)RSSI;
```

* Stop scan devices
```ruby
- (void)stopScanningForPeripherals;
```

* Connect specified device
```ruby
- (void)connectingPeripheral:(CBPeripheral *)peripheral;
```

* Disconnect specified device
```ruby
- (void)disconnectPeripheral:(CBPeripheral *)peripheral;
```

* Get Received Signal Strength Indicator(RSSI) by device
```ruby
- (int)readRSSI:(CBPeripheral *)peripheral;
```

* Scan all services in the device
```ruby
- (void)scanningForServicesWithPeripheral:(CBPeripheral *)peripheral;
```

### Communicate with device after scanning all services
* Write data to device
```ruby
- (NSError *)setValue:(NSData *) data forServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral;
```

* Read data from device
```ruby
- (NSData *)readValueForServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral;
```

