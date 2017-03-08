//
//  UIViewController+Utilities.m
//  ToDo
//
//  Created by Kurs on 3/8/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "UIViewController+Utilities.h"

@implementation UIViewController (Utilities)

#pragma mark - Public API

- (void)showAlertWithTitle:(NSString *)title andMesage:(NSString *)massage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
