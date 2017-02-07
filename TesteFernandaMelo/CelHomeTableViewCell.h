//
//  CelHomeTableViewCell.h
//  TesteFernandaMelo
//
//  Created by Fernanda Melo on 06/02/17.
//  Copyright © 2017 Fernanda Melo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CelHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UILabel *venue;
@property (weak, nonatomic) IBOutlet UILabel *section;
@property (weak, nonatomic) IBOutlet UILabel *note;
@property (weak, nonatomic) IBOutlet UILabel *views;

@end
