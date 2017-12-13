//
//  CourseModel.h
//  USCourse
//
//  Created by Young Kim on 12/6/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *preKey = @"prefix";
static NSString *numberKey = @"number";
static NSString *suffixKey = @"suffix";
static NSString *titleKey = @"title";
static NSString *unitKey = @"units";
static NSString *descriptionKey = @"description";
static NSString *sectionKey = @"sections";
static NSString *typeKey = @"type";
@interface CourseModel : NSObject
@property (strong, nonatomic) NSString* prefix;
@property (strong, nonatomic) NSString* term;
+(instancetype) sharedModel:(NSString*)course;
-(instancetype) initWithPrefix:(NSString*)prefix;
-(NSInteger) numberOfCourse;
-(NSDictionary *)courseAtIndex:(NSInteger)index;
@end
