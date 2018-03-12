//
//  RXCollectionPB.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

@class RXProgressBar;

/*
This class is needed so that we can put an unlimited number of RXProgressBar in one uitableview
And after with easy can, delete them or add next rxprogressBars
*/
@interface RXCollectionPB : NSObject

@property(strong, nonatomic) NSMutableArray* pbArr;

- (void) deleteProgressBar:(RXProgressBar*) bar;
- (void) addPB:(RXProgressBar*) bar;

@end
