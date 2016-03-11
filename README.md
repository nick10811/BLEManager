# BLEManager

## Descriptions
This project is bluetooth 4.0 lib for iOS.

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

