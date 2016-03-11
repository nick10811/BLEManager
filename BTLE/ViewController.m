//
//  ViewController.m
//  BTLE
//
//  Created by Nick Yang on 9/16/15.
//  Copyright (c) 2015 Nick Yang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize peripherals;
@synthesize connctedPeripheral;

// dismiss keyboard when pressing "return"
-(IBAction)dismissKeyboard:(id)sender{
    [serviceUUID resignFirstResponder];
    [characteristicUUID resignFirstResponder];
    [sendData resignFirstResponder];
}

// dismiss keyboard when tapping outside
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)scanDevice:(id)sender {
    [[BLEManager sharedManager]disableBLEManager];
    [BLEManager sharedManagerWithDelegate:self];
    [[BLEManager sharedManager] scanningForPeripherals];
}

-(IBAction)disconnection:(id)sender {
    [[BLEManager sharedManager] disconnectPeripheral:connctedPeripheral];
}

-(IBAction)readRSSI:(id)sender {
    rssi.text = [NSString stringWithFormat:@"%d",[[BLEManager sharedManager] readRSSI:connctedPeripheral]];
}

-(IBAction)sendData:(id)sender {
    
    NSError *error = [[BLEManager sharedManager] setValue:[sendData.text dataUsingEncoding:NSUTF8StringEncoding] forServiceUUID:serviceUUID.text andCharacteristicUUID:characteristicUUID.text withPeripheral:connctedPeripheral];
    NSLog(@"write and response:%d", (int)error.code);
}

-(IBAction)readData:(id)sender {
    NSData *data = [[BLEManager sharedManager] readValueForServiceUUID:serviceUUID.text andCharacteristicUUID:characteristicUUID.text withPeripheral:connctedPeripheral];
    NSLog(@"readData:%@", data);
    receivedData.text = (data == nil) ? @"(null)" : [NSString stringWithUTF8String:[data bytes]];
}

# pragma mark - BLEManager Methods
- (void)BLEManagerDisabledDelegate {
    
}

- (void)BLEManagerReceiveAllPeripherals:(NSMutableArray *) peripherals {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Blue Devices" delegate:self cancelButtonTitle:@"Back" destructiveButtonTitle:nil otherButtonTitles:nil];
    
    self.peripherals = peripherals;
    for(CBPeripheral *p in self.peripherals){
        NSLog(@"peripheral.name:%@",p.name);
        [actionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@(%@)",p.name,[p.identifier.UUIDString substringToIndex:5]]];
    }
    
    [actionSheet showInView:self.view];
}

- (void)BLEManagerDidConnectPeripheral:(CBPeripheral *)peripheral{
    connctedPeripheral = peripheral;
    
    // after connecting peripheral, set all services and characteristics into connected peripheral
    [[BLEManager sharedManager] scanningForServicesWithPeripheral:connctedPeripheral];
    sleep(1);
    bleDeviceName.text = [NSString stringWithFormat:@"%@(%@)",connctedPeripheral.name,[connctedPeripheral.identifier.UUIDString substringToIndex:5]];
}

- (void)BLEManagerDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    connctedPeripheral = nil;
    bleDeviceName.text = @"";
    rssi.text = @"0";
}

- (void)BLEManagerReceiveData:(NSData *) value fromPeripheral:(CBPeripheral *)peripheral andServiceUUID:(NSString *)serviceUUID andCharacteristicUUID:(NSString *)charUUID {
    NSLog(@"Recived Data:%@", value);
    NSLog(@"servcie.UUID:%@, char.UUID:%@", serviceUUID, charUUID);
    
}

# pragma mark - UIActionSheet Methods
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger index = buttonIndex - 1;
    if(index == -1){
        [[BLEManager sharedManager] stopScanningForPeripherals];
        return;
    }
    [[BLEManager sharedManager] connectingPeripheral:[self.peripherals objectAtIndex:index]];
}

@end