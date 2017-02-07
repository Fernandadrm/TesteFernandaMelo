//
//  Lugar.m
//  TesteFernandaMelo
//
//  Created by Fernanda Melo on 06/02/17.
//  Copyright © 2017 Fernanda Melo. All rights reserved.
//

#import "Lugar.h"

@implementation Lugar

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imagemURL = @"";
        _nome = @"";
        _descricao = @"";
        _visualizacoes = @"";
        _secaoRowSeat = @"";
    }
    return self;
}

@end
