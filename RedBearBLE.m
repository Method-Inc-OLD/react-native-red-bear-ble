#import "RedBearBLE.h"

@interface RedBearBLE()

-(void) bleConnect;
-(void) connectionTimer:(NSTimer *)timer;

@end

@implementation RedBearBLE

RCT_EXPORT_MODULE();

@synthesize ble;

- (instancetype)init
{
    if ((self = [super init])) {
        self.ble = [[BLE alloc] init];
        [self.ble controlSetup];
        self.ble.delegate = self;
    }
    return self;
}

RCT_EXPORT_METHOD(connect)
{
    [self bleConnect];
}

// BLE


-(void) bleDidConnect {
    RCTLogInfo(@"Connected");
};
-(void) bleDidDisconnect {
    RCTLogInfo(@"Disconnected");
    
};
-(void) bleDidUpdateRSSI:(NSNumber *) rssi {
    RCTLogInfo(@"bleDidUpdateRSSI %d", rssi.intValue);
};
-(void) bleDidReceiveData:(unsigned char *) data length:(int) length {
    
};

- (void)bleConnect
{
    if (ble.activePeripheral)
        if(ble.activePeripheral.state == CBPeripheralStateConnected)
        {
            [[ble CM] cancelPeripheralConnection:[ble activePeripheral]];
            RCTLogInfo(@"Thing connected to other periperial");
            return;
        }
    
    if (ble.peripherals)
        ble.peripherals = nil;
    
    [ble findBLEPeripherals:2];
    RCTLogInfo(@"Searching for thing");
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
}

-(void) connectionTimer:(NSTimer *)timer
{
    
    if (ble.peripherals.count > 0)
    {
        [ble connectPeripheral:[ble.peripherals objectAtIndex:0]];
        RCTLogInfo(@"Connecting");
    }
    else
    {
        RCTLogInfo(@"Connection timeout");
    }
}

@end
