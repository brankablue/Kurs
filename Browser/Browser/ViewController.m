//
//  ViewController.m
//  Browser
//
//  Created by Kurs on 3/10/17.
//  Copyright © 2017 Kurs. All rights reserved.
//

#import "ViewController.h"
#import "Bookmark.h"

static NSString *const HOMEPAGE = @"www.google.com"; // in Constants.h

@interface ViewController () <UITextFieldDelegate, UIWebViewDelegate, UITableViewDataSource, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;


@property (strong, nonatomic) NSMutableArray *bookmarksArray;
@end

@implementation ViewController

#pragma mark - Properties

- (NSMutableArray *)bookmarksArray {
    if (!_bookmarksArray) {
        _bookmarksArray = [[NSMutableArray alloc] init];
    }
    
    //Adding predefined bookmarks.
   // Bookmark *apple = [[Bookmark alloc] initWithTitle:@"Apple" andURL:@"www.apple.com"];
   // [_bookmarksArray addObject:apple];
   //moze ovako ali moze i na sledeci nacin -->
    
    [_bookmarksArray addObject:[[Bookmark alloc] initWithTitle:@"Apple" andURL:@"www.apple.com"]];
    
    Bookmark *google = [[Bookmark alloc] initWithTitle:@"Google" andURL:@"www.google.com"];
    [_bookmarksArray addObject:google];
    
    return _bookmarksArray;
}

#pragma mark - Actins

- (IBAction)backBarButton:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)forwardBarButton:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

- (IBAction)shareBarButton:(UIBarButtonItem *)sender {
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"Check out this cool link!\n", self.urlTextField.text] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (IBAction)bookmarksBarButton:(UIBarButtonItem *)sender {
    [self toggleTableView:YES];

}

- (IBAction)addBarButton:(UIBarButtonItem *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Bookmark" message:@"please add title:" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:nil];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alertController.textFields[0];
        Bookmark *bookmark = [[Bookmark alloc] initWithTitle:textField.text andURL:self.urlTextField.text];
        [self.bookmarksArray addObject:bookmark];
        [self.tableView reloadData];
        
    }]];
  
}

- (IBAction)closeButton:(UIButton *)sender {
    [self toggleTableView:NO];
    
}

#pragma  mark - Private API

/**
 Loads homepage into our web view. If homepage needs to be changed, please update HOMPAGE constant.
 */
- (void)loadHomepage {
    [self openURL:HOMEPAGE];
}

/**
 Loads url into our web view

 @param urlString The URL to open
 */
- (void)openURL:(NSString *)urlString {
    NSString *httpString = [NSString stringWithFormat:@"http//%@", urlString];
    NSURL *url = [NSURL URLWithString:httpString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

/**
Fades in/fades out table view/
 @param toggle Wherther we want to fade in or fade out tableView
 */

- (void)toggleTableView:(BOOL)toggle {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.alpha = toggle ? 1.0f : 0.0f;
        self.closeButton.alpha = toggle ? 1.0f : 0.0f;

    }];
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.alpha = 0.0f;
    [self loadHomepage];
}

#pragma marka - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //Hide keyboard
    [textField resignFirstResponder];
    
    [self openURL:textField.text];
    
    return YES;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;


}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookmarksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Bookmark *bookmark = self.bookmarksArray[indexPath.row];
    cell.textLabel.text = bookmark.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Bookmark *bookmark = self.bookmarksArray[indexPath.row];
    [self openURL:bookmark.url];
    [self toggleTableView:NO];

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *) indexPath {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [self.bookmarksArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
}







@end
