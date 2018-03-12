//
//  RXIndexPath.h
//  RXProgressBar
//
//  Created by Uber on 27/02/2018.
//

#import <Foundation/Foundation.h>

/*
   This object is needed to work in the viewmodel layer
*/
@interface RXIndexPath : NSObject

@property (assign, nonatomic) NSInteger row;
@property (assign, nonatomic) NSInteger section;

- (instancetype)initWithRow:(NSInteger) row withSection:(NSInteger) section;
@end
