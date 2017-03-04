//
//  DBTask+Utilities.m
//  ToDo
//
//  Created by Kurs on 3/4/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "DBTask+Utilities.h"

@implementation DBTask (Utilities)

#pragma  mark - Public API

- (UIColor *) groupColor {
    if (self.group == TaskGroupNotCompleted) {
        return  kColorComplited;
    } else if (self.group == TaskGroupNotCompleted) {
        return kColorNotComplited;
    } else {
        return kColorInProgress;
    }
}
@end
