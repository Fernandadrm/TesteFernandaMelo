//
//  WebViewController.m
//  TesteFernandaMelo
//
//  Created by Fernanda Melo on 07/02/17.
//  Copyright © 2017 Fernanda Melo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction target:self action:@selector(compartilhar)];
    self.navigationItem.rightBarButtonItem = item;
    
    NSString *site = [self.site stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *targetURL = [NSURL URLWithString:site];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.webView loadRequest:request];
}

- (void)compartilhar{
    NSString *site = [self.site stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSArray *items = @[site];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];

    [self presentActivityController:controller];
}

- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // iPad
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.rightBarButtonItem;
    
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){

        if (completed) {
            NSLog(@"Compartilhou usando:%@", activityType);
            
        } else {
            NSLog(@"Cancelou o compartilhamento.");
        }
        
        if (error) {
            NSLog(@"Ocorreu um erro: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
