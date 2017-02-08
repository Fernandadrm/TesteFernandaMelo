//
//  DetalheViewController.m
//  TesteFernandaMelo
//
//  Created by Fernanda Melo on 06/02/17.
//  Copyright © 2017 Fernanda Melo. All rights reserved.
//

#import "DetalheViewController.h"

@interface DetalheViewController ()

@end

@implementation DetalheViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.acessar.hidden = true;
    self.stats.hidden = true;
    [self verificaSeleca];
    // Do any additional setup after loading the view.
}

-(void) verificaSeleca{
    
    if (![self.venue isEqualToString:@""]) {
        [self getValues];
    }else{
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Atenção"
                                     message:@"Não foi possivel carregar informações."
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    }
    
}

-(void)getValues{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *selecao = [[NSString alloc] initWithFormat:@"https://aviewfrommyseat.com/avf/api/venue.php?appkey=f6bcd8e8bb853890f4fb2be8ce0418fa&venue=%@&info=true", self.venue];
    
    NSString *escapedPath = [selecao stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *URL = [NSURL URLWithString: escapedPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"GET Error: %@", error.localizedDescription);
        } else {
            //NSLog(@"*response*%@", response);
            // NSLog(@"*responseObject*%@", responseObject);
            NSArray *resultArrayDict = [responseObject objectForKey:@"avfms"];
            NSDictionary* dicResult = [resultArrayDict firstObject];
            [self verificaResult: dicResult];
            
        }
    }];
    [dataTask resume];
}
-(void)verificaResult:(NSDictionary*) dicionario{
    if (dicionario == nil) {
        NSLog(@"Nao tem nada");
    }else{
        [self pegaValores:dicionario];
    }
    
}
-(void)pegaValores: (NSDictionary*) result{
    
    NSString* imagemURL = [[NSString alloc]initWithFormat: @"https://aviewfrommyseat.com/photos/%@", [self verificaRetorno: [result valueForKey:@"newest_image"]]];
    
    NSString *escapedPath = [imagemURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self.imagem sd_setImageWithURL:[NSURL URLWithString: escapedPath] placeholderImage: [UIImage imageNamed:@"paisagem"]];
    self.endereco.text = [self verificaRetorno: [result valueForKey:@"address"]];
    self.cidadeEstado.text = [[NSString alloc]initWithFormat: @"City %@ Estado %@", [self verificaRetorno: [result valueForKey:@"city"]],[self verificaRetorno: [result valueForKey:@"state"]]];
    
    self.pais.text = [self verificaRetorno: [result valueForKey:@"country"]];
    self.media.text = [self verificaRetorno: [result valueForKey:@"average_rating"]];
    self.nome.text = [self verificaRetorno:[result valueForKey:@"name"]];
    self.stats.text = [self formataStats:[self verificaRetorno:[result valueForKey:@"stats"]]];
    self.site = [self verificaRetorno:[result valueForKey:@"sameas"]];
    [self verificaSite];
}

-(NSString *)formataStats:(NSString *) stats{
    NSString *str = stats;
    if (![stats isEqualToString:@""]) {
        self.stats.hidden = false;
        str = [str stringByReplacingOccurrencesOfString:@"<br>"
                                             withString:@"\r"];
        str = [str stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
    }
    return str;
}

-(void) verificaSite{
    if ([self.site isEqualToString:@""]) {
        self.acessar.hidden = true;
    }else{
        NSString* newNSString =[[[[self.site componentsSeparatedByString:@"https://"]objectAtIndex:1] componentsSeparatedByString:@","]objectAtIndex:0];
        if ([newNSString isEqualToString:@""]) {
            newNSString =[[self.site componentsSeparatedByString:@"https://"]objectAtIndex:1];
        }
        
        if ([newNSString isEqualToString:@""]) {
            self.acessar.hidden = true;
        }else{
            self.acessar.hidden = false;
        }
        
        NSString* site = [[NSString alloc]initWithFormat: @"https://%@", newNSString];
        
        self.site = site;
    }
}

-(NSString *)verificaRetorno: (NSString*) objeto {
    if (objeto == nil || [objeto isEqual: [NSNull null] ]) {
        return @"";
    }
    return objeto;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Site"])
    {
        WebViewController *vc = [segue destinationViewController];
        vc.site = self.site;
    }
    
}


@end
