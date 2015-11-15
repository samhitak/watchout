#import "ViewController.h"
#import "PebbleKit/PebbleKit.h"
#import "WatchOut.h"
#import "WatchOutData.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import <Firebase/Firebase.h>

@interface ViewController () <PBPebbleCentralDelegate>

@property (weak, nonatomic) PBWatch *watch;
@property (weak, nonatomic) PBPebbleCentral *central;

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;


@property (weak, nonatomic) IBOutlet UILabel *output2;
@property (weak, nonatomic) IBOutlet UILabel *externLabel;
@property (weak, nonatomic) IBOutlet UIButton *sosButton;

@end

@implementation ViewController









- (void)pebbleCentral:(PBPebbleCentral *)central watchDidConnect:(PBWatch *)watch isNew:(BOOL)isNew {
    if (self.watch) {
        return;
    }
    self.watch = watch;
    self.outputLabel.text = @"Connected to watch";
    
    if (WatchOut.sharedWatchOut.recordedData.count > 0)
    {
      self.outputLabel.text = @"good data";
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
    
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://watchout.firebaseio.com"];
    
    // Get the data on a post that has changed
    [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        self.externLabel.text = @"Connected to database";
    }];
    
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        self.externLabel.text = @"New data";
    }];

    
    
    // Keep a weak reference to self to prevent it staying around forever
    __weak typeof(self) welf = self;
    
}

- (IBAction)buttonTapped:(UIButton *)sosButton {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}



- (void)pebbleCentral:(PBPebbleCentral *)central watchDidDisconnect:(PBWatch *)watch {
    // Only remove reference if it was the current active watch
    if (self.watch == watch) {
        self.watch = nil;
        self.outputLabel.text = @"Watch disconnected";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the delegate to receive PebbleKit events
    self.central = [PBPebbleCentral defaultCentral];
    self.central.delegate = self;
    
    // Register UUID
    self.central.appUUID = PBSportsUUID;
    
    // Begin connection
    [self.central run];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end