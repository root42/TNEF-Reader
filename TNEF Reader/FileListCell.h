//
//  FileListCell.h
//  TNEF Reader
//
//  Created by Arne Schmitz on 01.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileListCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *subtitle;
@property (nonatomic, retain) IBOutlet UIImageView *image;

@end
