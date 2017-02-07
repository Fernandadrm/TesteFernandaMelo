//
//  DetalheViewController.h
//  TesteFernandaMelo
//
//  Created by Fernanda Melo on 06/02/17.
//  Copyright © 2017 Fernanda Melo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "WebViewController.h"

@interface DetalheViewController : UIViewController
@property (nonatomic) NSString * venue;
@property (nonatomic) NSString * site;
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (weak, nonatomic) IBOutlet UILabel *media;
@property (weak, nonatomic) IBOutlet UILabel *nome;
@property (weak, nonatomic) IBOutlet UILabel *endereco;
@property (weak, nonatomic) IBOutlet UILabel *cidadeEstado;
@property (weak, nonatomic) IBOutlet UILabel *pais;

@property (weak, nonatomic) IBOutlet UIButton *acessar;
@property (weak, nonatomic) IBOutlet UITextView *stats;

@end
