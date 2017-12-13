//
//  DepartmentModel.m
//  USCourse
//
//  Created by Young Kim on 12/5/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import "DepartmentModel.h"
@interface DepartmentModel ()

@property (nonatomic, strong) NSMutableArray *departments;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation DepartmentModel

-(instancetype) initWithTerm:(NSString *)term {
    self = [super init];
    self.term = term;
    NSError *error;
    NSString* dept = [NSString stringWithFormat:@"http://web-app.usc.edu/web/soc/api/depts/%@",self.term];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:dept]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //Get all schools of departments
    NSMutableArray *departs = [[json valueForKey:@"department"] mutableCopy];
    _departments = [[NSMutableArray alloc] init];
    for (int i = 0; i < departs.count; i++) {
        NSMutableArray *lists = [[departs[i] valueForKey:@"department"] mutableCopy];
        if (lists.count != 3) {
            for (int j = 0; j < lists.count; j++) {
                NSString* name = [[lists objectAtIndex:j] valueForKey:@"name"];
                NSString* prefix = [[lists objectAtIndex:j] valueForKey:@"code"];
                NSDictionary *department = @{prefixKey: prefix, nameKey: name };
                [self.departments addObject:department];
            }
        } else {
            @try {
                for (int j = 0; j < 3; j++) {
                    NSString* name = [[lists objectAtIndex:j] valueForKey:@"name"];
                    NSString* prefix = [[lists objectAtIndex:j] valueForKey:@"code"];
                    NSDictionary *department = @{prefixKey: prefix, nameKey: name };
                    [self.departments addObject:department];
                }
            }@catch(NSException *exception) {
                NSString* name = [lists valueForKey:@"name"];
                NSString* prefix = [lists valueForKey:@"code"];
                NSDictionary *department = @{prefixKey: prefix, nameKey: name };
                [self.departments addObject:department];
            }
        }
    }
    NSSortDescriptor* brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSMutableArray* sortDescriptors = [NSMutableArray arrayWithObject:brandDescriptor];
    NSMutableArray* sortedArray = (NSMutableArray*)[_departments sortedArrayUsingDescriptors:sortDescriptors];
    _departments = sortedArray;
    return self;
}

-(NSInteger) numberOfDept {
    return self.departments.count;
}
-(NSDictionary *) departmentAtIndex:(NSInteger)index {
    return self.departments[index];
}

+(instancetype) sharedModel:(NSString*) term{
    static DepartmentModel* sharedModel = nil;
    if([term length] != 0){
        sharedModel = [[self alloc] initWithTerm:term];
    }
    return sharedModel;
}

@end
