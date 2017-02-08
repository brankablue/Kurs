//
//  WebViewController.h
//  Vesti
//
//  Created by Kurs on 2/8/17.
//  Copyright © 2017 Kurs. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 WebViewController is used to present webview. You only need to set url and that's it
 */

@interface WebViewController : UIViewController


/**
 Set this url in order to present webView with loaded website (from url)
 */
@property (strong, nonatomic) NSString *url;
@end
