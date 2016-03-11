//
//  ViewController.h
//  BTLE
//
//  Created by Nick Yang on 9/16/15.
//  Copyright (c) 2015 Nick Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEManager.h"

@interface ViewController : UIViewController<BLEManagerDelegate,UIActionSheetDelegate> {
    IBOutlet UILabel *bleDeviceName;
    
    IBOutlet UILabel *rssi;
    
    IBOutlet UITextField *serviceUUID;
    IBOutlet UITextField *characteristicUUID;
    IBOutlet UITextField *sendData;
    
    IBOutlet UILabel *receivedData;
}

@property (strong,nonatomic) NSMutableArray *peripherals;
@property (strong,nonatomic) CBPeripheral *connctedPeripheral;

-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)scanDevice:(id)sender;
-(IBAction)disconnection:(id)sender;
-(IBAction)readRSSI:(id)sender;
-(IBAction)sendData:(id)sender;
-(IBAction)readData:(id)sender;

@end

