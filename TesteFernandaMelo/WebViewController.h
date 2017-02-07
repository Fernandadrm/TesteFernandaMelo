//
//  WebViewController.h
//  TesteFernandaMelo
//
//  Created by Fernanda Melo on 07/02/17.
//  Copyright © 2017 Fernanda Melo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WebViewController : UIViewController<WKUIDelegate>

@property (nonatomic) NSString *site;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) WKWebView * web;
@property (nonatomic, strong) NSArray *activityItems;

@end
