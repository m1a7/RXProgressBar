//
//  UITableViewCell+RelatedTable.m
//  RXProgressBar
//
//  Created by Uber on 03/03/2018.
//

#import "UITableViewCell+RelatedTable.h"

@implementation UITableViewCell (RelatedTable)

- (UITableView *)relatedTable
{
    if ([self.superview isKindOfClass:[UITableView class]])
        return (UITableView *)self.superview;
    else if ([self.superview.superview isKindOfClass:[UITableView class]])
        return (UITableView *)self.superview.superview;
    else
    {
        NSAssert(NO, @"UITableView shall always be found.");
        return nil;
    }
    
}

@end
