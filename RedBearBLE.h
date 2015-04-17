#import "RCTBridgeModule.h"
#import "RCTLog.h"
#import "BLE.h"

@interface RedBearBLE : NSObject <BLEDelegate, RCTBridgeModule>

@property (strong, nonatomic) BLE *ble;

@end
