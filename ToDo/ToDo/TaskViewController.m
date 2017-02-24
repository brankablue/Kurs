//
//  TaskViewController.m
//  ToDo
//
//  Created by Kurs on 2/22/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "TaskViewController.h"
#import <MapKit/MapKit.h>

@interface TaskViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *groupTextField;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectorImageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (weak, nonatomic) IBOutlet UIView *greenView;
//@property (weak, nonatomic) IBOutlet UIView *purpleView;
//@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *viewsArray;
@end
@implementation TaskViewController


#pragma mark - Actions

- (IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButton:(UIButton *)sender {
}

- (IBAction)groupButtonTapped:(UIButton *)sender {
//
//    switch (sender.tag) {
//        case TaskGroupCompleted:
//            center = self.greenView.center;
//            break;
//        case TaskGroupNotCompleted:
//            center = self.orangeView.center;
//            break;
//        case TaskGroupInProgress:
//            center = self.purpleView.center;
//            break;
//    }
    
    for (UIView *view in self.viewsArray) {
        if (view.tag == sender.tag) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.selectorImageView.center = view.center;
            }];
         }
     }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

@end
