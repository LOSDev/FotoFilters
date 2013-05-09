//
//  FiltersViewController.h
//  CoreImageFun
//
//  Created by Rincewind on 03.05.13.
//  Copyright (c) 2013 Rincewind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbNail.h"



@protocol FilterControllerDelegate <NSObject>

-(void) userDidMakeChoice:(NSString *)choice;

@end

@interface FiltersViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) id <FilterControllerDelegate> delegate;

@property NSArray *properties;
@property (weak, nonatomic) UIPopoverController *popoverController;
@property (weak, nonatomic) IBOutlet UITableView *tView;
@property UIImage *image;
@property NSMutableDictionary *previews;

- (IBAction)goBack:(id)sender;



@end
