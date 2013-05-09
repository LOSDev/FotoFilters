//
//  ThumbNail.m
//  FotoFilters
//
//  Created by Rincewind on 07.05.13.
//  Copyright (c) 2013 Rincewind. All rights reserved.
//

#import "ThumbNail.h"

@implementation ThumbNail

//creates a square Thumbnail of an Image
+(UIImage *) createThumbNailFromImage : (UIImage *) image{
    
    //Calculating the Aspect Ratio
    float ratio = image.size.width / image.size.height;
    
    //setting the width and height of the Thumbnail
    float width=THUMBNAIL_SIZE;
    float height=THUMBNAIL_SIZE;
    
    //adjust the Width or Height depending on the Aspect Ratio
    if (ratio > 1) {
        height = THUMBNAIL_SIZE/ratio;
    }else{
        width = THUMBNAIL_SIZE*ratio;
    }
    
    //set up the Context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    [image drawInRect:CGRectMake(0, 0, width, height)];
    
    //Create the Thumbnail
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;

}
@end
