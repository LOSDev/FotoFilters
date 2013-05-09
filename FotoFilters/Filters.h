//
//  Filters.h
//  CoreImageFun
//
//  Created by Rincewind on 03.05.13.
//  Copyright (c) 2013 Rincewind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filters : NSObject
//Class method to return all the availabe Filters in an Array of Strings
+(NSArray *) getAllFilters;

//Class method to return the Filtered Image
+(CIImage *) changeImage:(CIImage *) image withFilter:(NSString *) filter;
@end
