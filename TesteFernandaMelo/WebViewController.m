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
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    self.activity.hidden = false;
    [self.activity startAnimating];
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activity stopAnimating];
    self.activity.hidden = true;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
   
    [self.activity stopAnimating];
    [self mensagem:@"Atenção" eMensagem:@"Verifique sua conexão com a internet."];
}
-(void)mensagem:(NSString *) titulo eMensagem: (NSString *) mensagem{
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:titulo
                                 message:mensagem
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [view dismissViewControllerAnimated:YES completion:nil];
                             [self.navigationController popViewControllerAnimated: YES];
                         }];
    
    [view addAction:ok];
    [self presentViewController:view animated:YES completion:nil];
    
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
