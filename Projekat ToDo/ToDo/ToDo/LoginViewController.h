//
//  LoginViewController.h
//  ToDo
//
//  Created by Administrator on 14/12/2016.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordTextView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmInButtonLeadingConstraint;
@property (strong, nonatomic) NSDictionary *attributes;
- (void) configurePlaceholders;

- (void) configureTextField:(UITextField *)textField;

@end
