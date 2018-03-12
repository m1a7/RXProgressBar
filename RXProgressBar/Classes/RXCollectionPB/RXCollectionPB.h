//
//  RXCollectionPB.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>

@class RXProgressBar;

@interface RXCollectionPB : NSObject

@property(strong, nonatomic) NSMutableArray* pbArr;

- (void) deleteProgressBar:(RXProgressBar*) bar;
- (void) addPB:(RXProgressBar*) bar;

@end
