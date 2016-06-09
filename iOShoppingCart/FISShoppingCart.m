//
//  FISShoppingCart.m
//  iOShoppingCart
//
//  Created by Jordan Kiley on 6/9/16.
//  Copyright © 2016 FIS. All rights reserved.
//

#import "FISShoppingCart.h"

@implementation FISShoppingCart

- (NSUInteger)calculateTotalPriceInCents {
    NSUInteger totalPrice = 0 ;
    if ( [ self.items count ] == 0 ) {
        totalPrice = 0 ;
    } else {
        for (FISItem *item in self.items) {
            totalPrice = totalPrice + item.priceInCents ;
        }
    }
    return totalPrice;
}

- (void)addItem:(FISItem *)item {
    [ self.items addObject:item ];
}

- (void)removeItem:(FISItem *)item {
    NSInteger i = [ self.items indexOfObject:item ] ;
    [ self.items removeObjectAtIndex:i ];
}

- (void)removeAllItemsLikeItem:(FISItem *)item {
    [ self.items removeObjectsInArray:@[ item ] ] ;
}

- (void)sortItemsByNameAsc{
    NSSortDescriptor *sortItemsByNameAscending = [ NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:) ];
    [ self.items sortUsingDescriptors:@[sortItemsByNameAscending] ];
}

- (void)sortItemsByNameDesc {
    NSSortDescriptor *sortItemsByNameDescending = [ NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO selector:@selector(caseInsensitiveCompare:) ];
    [ self.items sortUsingDescriptors:@[sortItemsByNameDescending] ];
}

- (void)sortItemsByPriceInCentsAsc {
    NSSortDescriptor *sortItemsByPriceAscending = [ NSSortDescriptor sortDescriptorWithKey:@"priceInCents" ascending:YES];
    [ self.items sortUsingDescriptors:@[sortItemsByPriceAscending] ];
}

- (void)sortItemsByPriceInCentsDesc {
    NSSortDescriptor *sortItemsByPriceDescending = [ NSSortDescriptor sortDescriptorWithKey:@"priceInCents" ascending:NO ];
    [ self.items sortUsingDescriptors:@[sortItemsByPriceDescending] ];
}

- (NSArray *)allItemsWithName:(NSString *)name {
    NSMutableArray *itemsWithName = [ NSMutableArray new ];
    for (FISItem *item in self.items) {
        if ( [item.name isEqualToString:name ] ) {
            [ itemsWithName addObject:item ];
        }
    }
    return itemsWithName ;
}

- (NSArray *)allItemsWithMinimumPriceInCents:(NSUInteger)price {
    NSPredicate *minimumPriceInCents = [ NSPredicate predicateWithFormat:@"priceInCents >= %lu", price ];
    NSArray *itemsWithMinimumPrice = [ self.items filteredArrayUsingPredicate:minimumPriceInCents ];
    return itemsWithMinimumPrice ;
}

- (NSArray *)allItemsWithMaximumPriceInCents:(NSUInteger)price {
    NSPredicate *maximumPriceInCents = [ NSPredicate predicateWithFormat:@"priceInCents <= %lu", price] ;
    NSArray *itemsWithMaximumPrice = [ self.items filteredArrayUsingPredicate:maximumPriceInCents ];
    return itemsWithMaximumPrice;
}

@end
