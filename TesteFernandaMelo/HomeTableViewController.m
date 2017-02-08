//
//  HomeTableViewController.m
//  TesteFernandaMelo
//
//  Created by Fernanda Melo on 06/02/17.
//  Copyright © 2017 Fernanda Melo. All rights reserved.
//

#import "HomeTableViewController.h"

@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    _reachability = [Reachability reachabilityForInternetConnection];
    [_reachability startNotifier];
    
    [self reachabilityCurrent];
    [self getValues];
}

-(void) reachabilityCurrent{
    NetworkStatus remoteHostStatus = [_reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
         [self mensagem:@"Atenção" eMensagem:@"Verifique sua conexão com a internet."];
    }
}

- (void) handleNetworkChange:(NSNotification *)notice
{
    [self reachabilityCurrent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)getValues{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://aviewfrommyseat.com/avf/api/featured.php?appkey=f6bcd8e8bb853890f4fb2be8ce0418fa"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            //NSLog(@"*response*%@", response);
            // NSLog(@"*responseObject*%@", responseObject);
            NSArray *resultArrayDict = [responseObject objectForKey:@"avfms"];
            [self verificaResult: resultArrayDict];
            
        }
    }];
    [dataTask resume];
}
-(void)verificaResult:(NSArray*) array{
    if (array == nil) {
        [self mensagem:@"Atenção" eMensagem:@"Não temos resultados na pesquisa."];
    }else{
        [self pegaValores:array];
    }
    
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
                             
                         }];
    
    [view addAction:ok];
    [self presentViewController:view animated:YES completion:nil];
    
}

-(void)pegaValores: (NSArray*) arrayResult{
    if (self.listaLugares == nil)
        self.listaLugares = [[NSMutableArray alloc] init];
    
    for (NSDictionary* atual in arrayResult) {
        Lugar * novo = [[Lugar alloc]init];
        novo.nome = [self verificaRetorno: [atual valueForKey:@"venue"]];
        novo.descricao =[self verificaRetorno:  [atual valueForKey:@"note"]];
        
        novo.imagemURL = [[NSString alloc]initWithFormat: @"https://aviewfrommyseat.com/wallpaper/%@", [self verificaRetorno: [atual valueForKey:@"image"]]];
        
        novo.secaoRowSeat = [[NSString alloc]initWithFormat: @"Section %@ %@ %@ %@ %@", [self verificaRetorno: [atual valueForKey:@"section"]], @"Row", [self verificaRetorno: [atual valueForKey:@"row"]], @"Seat", [self verificaRetorno: [atual valueForKey:@"reat"]]];
        
        novo.visualizacoes = [self verificaRetorno: [atual valueForKey:@"views"]];
        
        [self.listaLugares addObject:novo];
    }
    
    [self.tableView reloadData];
}

-(NSString *)verificaRetorno: (NSString*) objeto {
    if (objeto == nil || [objeto isEqual: [NSNull null] ]) {
        return @"";
    }
    return objeto;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.listaLugares.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CelHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellHome" forIndexPath:indexPath];
    
    Lugar * lugar = [[Lugar alloc]init];
    
    lugar = [self.listaLugares objectAtIndex: indexPath.row];
    [cell.imagem sd_setImageWithURL:[NSURL URLWithString:lugar.imagemURL] placeholderImage: [UIImage imageNamed:@"paisagem"]];
    cell.section.text =  lugar.secaoRowSeat;
    cell.venue.text = lugar.nome;
    cell.note.text = lugar.descricao;
    cell.views.text = lugar.visualizacoes;
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self performSegueWithIdentifier:@"lugarDetalhe" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"lugarDetalhe"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetalheViewController *vc = [segue destinationViewController];
        Lugar * lugar = [_listaLugares objectAtIndex:indexPath.row];
        vc.venue = lugar.nome;
    }
}


@end
