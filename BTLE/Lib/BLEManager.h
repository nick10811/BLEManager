//
//  BLEManager.h
//  BTLE
//
//  Created by Nick Yang on 10/10/15.
//  Copyright (c) 2015 Nick Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define timeInverval 2.0f // timeount for scanning peripherals
#define defaultRSSI -100 // signal of blue device for detecting

@class BLEManager;
@protocol BLEManagerDelegate <NSObject>

@required
- (void)BLEManagerDisabledDelegate;

@optional
- (void)BLEManagerReceiveAllPeripherals:(NSMutableArray *) peripherals;
- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral;
- (void)BLEManagerDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
- (void)BLEManagerReceiveData:(NSData *) value fromPeripheral:(CBPeripheral *)peripheral andServiceUUID:(NSString *)serviceUUID andCharacteristicUUID:(NSString *)charUUID;

@end

@interface BLEManager : NSObject <CBCentralManagerDelegate,CBPeripheralManagerDelegate>
{
    CBCentralManager *centralManager;
}

@property (strong,nonatomic) NSMutableArray *discoveredPeripherals;

@property (assign,nonatomic) id<BLEManagerDelegate> delegate;

+ (BLEManager *)sharedManagerWithDelegate:(id<BLEManagerDelegate>)delegate; // inital
+ (BLEManager *)sharedManager; // singleton

- (void)disableBLEManager; // disable delegate
- (BOOL)isConnecting;
- (void)scanningForPeripherals;
- (void)scanningForPeripheralsWithDistance:(int)RSSI;
- (void)stopScanningForPeripherals;
- (void)connectingPeripheral:(CBPeripheral *)peripheral;
- (void)disconnectPeripheral:(CBPeripheral *)peripheral;
- (int)readRSSI:(CBPeripheral *)peripheral;

- (void)scanningForServicesWithPeripheral:(CBPeripheral *)peripheral;

// after discovering services and characteristics
- (NSError *)setValue:(NSData *) data forServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral;
- (NSData *)readValueForServiceUUID:(NSString *) serviceUUID andCharacteristicUUID:(NSString *) charUUID withPeripheral:(CBPeripheral *)peripheral;

@end
