//
//  Bookmark.m
//  Browser
//
//  Created by Kurs on 3/10/17.
//  Copyright © 2017 Kurs. All rights reserved.
//

#import "Bookmark.h"

@implementation Bookmark

#pragma mark - Designated Initilizer

- (instancetype)initWithTitle:(NSString *)title andURL:(NSString *)url {
    if (self = [super init]) {
        self.title = title;
        self.url = url;
    }
    
    return self;
}

@end
