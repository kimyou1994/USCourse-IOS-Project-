//
//  DepartmentModel.h
//  USCourse
//
//  Created by Young Kim on 12/5/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *prefixKey = @"prefix";
static NSString *nameKey = @"name";

@interface DepartmentModel : NSObject
@property (strong, nonatomic) NSString* term;
+(instancetype) sharedModel:(NSString*)term;
-(instancetype) initWithTerm:(NSString*)term;
-(NSInteger) numberOfDept;
-(NSDictionary *)departmentAtIndex:(NSInteger)index;
@end
