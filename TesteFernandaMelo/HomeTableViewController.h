//
//  HomeTableViewController.h
//  TesteFernandaMelo
//
//  Created by Fernanda Melo on 06/02/17.
//  Copyright © 2017 Fernanda Melo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "Reachability.h"
#import "CelHomeTableViewCell.h"
#import "Lugar.h"
#import "DetalheViewController.h"
@interface HomeTableViewController : UITableViewController
@property (nonatomic) Reachability* reachability;
@property(nonatomic) NSMutableArray* listaLugares;

@end
