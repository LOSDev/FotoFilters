//
//  ThumbNail.h
//  FotoFilters
//
//  Created by Rincewind on 07.05.13.
//  Copyright (c) 2013 Rincewind. All rights reserved.
//

#import <Foundation/Foundation.h>

#define THUMBNAIL_SIZE 70

@interface ThumbNail : NSObject

//Creates a Square Thumbnail from an UIImage with the Size defined above
+(UIImage *) createThumbNailFromImage : (UIImage *) image;

@end
