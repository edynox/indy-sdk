#import "ViewController.h"
#import <Indy/Indy.h>

@implementation ViewController

NSString *walletConfig = @"{\"id\":\"wallet\"}";
NSString *credentials = @"{\"key\":\"6nxtSiXFvBd593Y2DCed2dYvRY1PGK9WMtxCBjLzKgbw\", \"key_derivation_method\": \"RAW\"}";

/* DEMO LOGIC */

- (void)openWallet {
    __block IndyHandle walletHandle;
    [[IndyWallet sharedInstance]
      openWalletWithConfig:walletConfig
      credentials:credentials
      completion:^(NSError *error, IndyHandle h) {
        walletHandle = h;
        if ([error code]) {
          [self.StatusText insertText: [error localizedDescription]];
        } else {
          [self.StatusText insertText: @"OK\n"];
        }
    }];
}

- (void)createWallet {
    [[IndyWallet sharedInstance]
      createWalletWithConfig:walletConfig
      credentials:credentials
      completion:^(NSError *error) {
        if ([error code]) {
          [self.StatusText insertText: [error localizedDescription]];
        } else {
          [self.StatusText insertText: @"OK\n"];
          [self openWallet];
        }
    }];

}

- (void)connectToLedger {
  [IndyPool setProtocolVersion:@(2)
    completion:^(NSError *error) {
    if ([error code]) {
      self.StatusText.text = [error localizedDescription];
    } else {
      self.StatusText.text = @"OK\n";
      [self createWallet];
    }
  }];
}


/* VIEW LOGIC */

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connectToLedger];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
