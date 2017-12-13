//
//  NotifyViewController.h
//  USCourse
//
//  Created by Young Kim on 12/10/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NotifyControllerCompletionHandler)(NSString *email, NSString *section);

@interface NotifyViewController : UIViewController

@property (copy, nonatomic) NotifyControllerCompletionHandler completionHandler;
@end
