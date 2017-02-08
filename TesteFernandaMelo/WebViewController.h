//
//  WebViewController.h
//  TesteFernandaMelo
//
//  Created by Fernanda Melo on 07/02/17.
//  Copyright © 2017 Fernanda Melo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic) NSString *site;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSArray *activityItems;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
