#import "RedBearBLE.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@interface RedBearBLE()

-(void) bleConnect;
-(void) connectionTimer:(NSTimer *)timer;

@end

@implementation RedBearBLE

RCT_EXPORT_MODULE();

@synthesize ble;
@synthesize bridge = _bridge;

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
    [self.bridge.eventDispatcher sendDeviceEventWithName:@"BLEConnected"
                                                 body:@"ok"
     ];
};
-(void) bleDidDisconnect {
    RCTLogInfo(@"Disconnected");
    [self.bridge.eventDispatcher sendDeviceEventWithName:@"BLEDisconnected"
                                                 body:@"ok"
     ];
    
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
    
    // We need to do this so that the timer isn't garbage collected before it fires!
    [self performSelectorOnMainThread:@selector(setupTimer) withObject:self waitUntilDone:NO];
}

-(void) setupTimer
{
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
