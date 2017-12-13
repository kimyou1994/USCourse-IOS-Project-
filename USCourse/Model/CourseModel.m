//
//  CourseModel.m
//  USCourse
//
//  Created by Young Kim on 12/6/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import "CourseModel.h"
#import "DepartmentModel.h"
#import "SectionModel.h"
@interface CourseModel ()
@property (strong, nonatomic) DepartmentModel* depart;
@property (nonatomic, strong) NSMutableArray *courses;
@end
@implementation CourseModel

-(instancetype)initWithPrefix:(NSString*)prefix {
    self = [super init];
    self.prefix = prefix;
    self.depart = [DepartmentModel sharedModel:@""];
    self.term = [_depart term];
    self.courses = [[NSMutableArray alloc] init];
    NSError *error;
    //http://web-app.usc.edu/web/soc/api/classes/phys/20143
    NSString* course = [NSString stringWithFormat:@"http://web-app.usc.edu/web/soc/api/classes/%@/%@",self.prefix,self.term];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:course]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableArray *departs = [[json valueForKey:@"OfferedCourses"] mutableCopy];
    NSMutableArray *courses = [[departs valueForKey:@"course"] mutableCopy];
    @try {
        for (int i = 0; i < courses.count; i++) {
            NSMutableArray* data = [[courses objectAtIndex:i] valueForKey:@"CourseData"];
            NSString* prefix = [data valueForKey:@"prefix"];
            NSString* number = [data valueForKey:@"number"];
            NSString* title = [data valueForKey:@"title"];
            NSString* suffix = [data valueForKey:@"suffix"];
            NSString* description = [data valueForKey:@"description"];
            NSString* units = [data valueForKey:@"units"];
            NSMutableArray* sections = [[NSMutableArray alloc] init];
            NSMutableArray* getSection = [data valueForKey:@"SectionData"];
            if (getSection.count < 16) { //when it's not just one section
                for (int j = 0; j < getSection.count; j++) {
                    NSString* sectionId = [[getSection objectAtIndex:j] valueForKey:@"id"];
                    NSString* dclass = [[getSection objectAtIndex:j] valueForKey:@"dclass_code"];
                    NSString* space = [[getSection objectAtIndex:j]  valueForKey:@"spaces_available"];
                    NSString* registered = [[getSection objectAtIndex:j]  valueForKey:@"number_registered"];
                    NSString* start = [[getSection objectAtIndex:j]  valueForKey:@"start_time"];
                    NSString* end = [[getSection objectAtIndex:j]  valueForKey:@"end_time"];
                    NSString* day = [[getSection objectAtIndex:j]  valueForKey:@"day"];
                    NSString* location= [[getSection objectAtIndex:j] valueForKey:@"location"];
                    NSString* type = [[getSection objectAtIndex:j] valueForKey:@"type"];
                    NSMutableArray* instructors = [[getSection objectAtIndex:j]  valueForKey:@"instructor"];
                    NSString* instructor;
                    @try {
                        for (int k = 0; k < instructors.count; k++) {
                            if (k == 0) {
                                instructor = [NSString stringWithFormat:@"%@ %@", [[instructors objectAtIndex:k] valueForKey:@"first_name"], [[instructors objectAtIndex:k] valueForKey:@"last_name"]];
                            }else {
                                instructor = [NSString stringWithFormat:@"%@, %@ %@", instructor, [[instructors objectAtIndex:k] valueForKey:@"first_name"], [[instructors objectAtIndex:k] valueForKey:@"last_name"]];
                            }
                        }
                    }@catch(NSException *exception) {
                        instructor = [NSString stringWithFormat:@"%@ %@", [instructors valueForKey:@"first_name"], [instructors valueForKey:@"last_name"]];
                    }
                    SectionModel* section = [[SectionModel alloc] initWithSection:sectionId dclass:dclass availableSpace:space numberRegistered:registered start_time:start end_time:end location:location day:day instructor:instructor type:type];
                    [sections addObject:section];
                }
            }else {
                NSString* sectionId = [getSection valueForKey:@"id"];
                NSString* dclass = [getSection valueForKey:@"dclass_code"];
                NSString* space = [getSection valueForKey:@"spaces_available"];
                NSString* registered = [getSection valueForKey:@"number_registered"];
                NSString* start = [getSection valueForKey:@"start_time"];
                NSString* end = [getSection valueForKey:@"end_time"];
                NSString* day = [getSection valueForKey:@"day"];
                NSString* location= [getSection valueForKey:@"location"];
                NSString* type = [getSection valueForKey:@"type"];
                NSMutableArray* instructors = [getSection valueForKey:@"instructor"];
                NSString* instructor;
                @try {
                    for (int k = 0; k < instructors.count; k++) {
                        if (k == 0) {
                            instructor = [NSString stringWithFormat:@"%@ %@", [[instructors objectAtIndex:k] valueForKey:@"first_name"], [[instructors objectAtIndex:k] valueForKey:@"last_name"]];
                        }else {
                            instructor = [NSString stringWithFormat:@"%@, %@ %@", instructor, [[instructors objectAtIndex:k] valueForKey:@"first_name"], [[instructors objectAtIndex:k] valueForKey:@"last_name"]];
                        }
                    }
                }@catch(NSException *exception) {
                    instructor = [NSString stringWithFormat:@"%@ %@", [instructors valueForKey:@"first_name"], [instructors valueForKey:@"last_name"]];
                }
                SectionModel* section = [[SectionModel alloc] initWithSection:sectionId dclass:dclass availableSpace:space numberRegistered:registered start_time:start end_time:end location:location day:day instructor:instructor type:type];
                [sections addObject:section];
            }
            NSDictionary* course = @{ preKey:prefix, numberKey:number, titleKey:title, suffixKey:suffix, unitKey:units, descriptionKey:description, sectionKey:sections};
            [self.courses addObject:course];
        }
    }@catch(NSException *error) {
        NSMutableArray* data = [courses  valueForKey:@"CourseData"];
        NSString* prefix = [data valueForKey:@"prefix"];
        NSString* number = [data valueForKey:@"number"];
        NSString* title = [data valueForKey:@"title"];
        NSString* suffix = [data valueForKey:@"suffix"];
        NSString* description = [data valueForKey:@"description"];
        NSString* units = [data valueForKey:@"units"];
        NSMutableArray* sections = [[NSMutableArray alloc] init];
        NSMutableArray* getSection = [data valueForKey:@"SectionData"];
        if (getSection.count < 16) { //when it's not just one section
            for (int j = 0; j < getSection.count; j++) {
                NSString* sectionId = [[getSection objectAtIndex:j] valueForKey:@"id"];
                NSString* dclass = [[getSection objectAtIndex:j] valueForKey:@"dclass_code"];
                NSString* space = [[getSection objectAtIndex:j]  valueForKey:@"spaces_available"];
                NSString* registered = [[getSection objectAtIndex:j]  valueForKey:@"number_registered"];
                NSString* start = [[getSection objectAtIndex:j]  valueForKey:@"start_time"];
                NSString* end = [[getSection objectAtIndex:j]  valueForKey:@"end_time"];
                NSString* day = [[getSection objectAtIndex:j]  valueForKey:@"day"];
                NSString* location= [[getSection objectAtIndex:j] valueForKey:@"location"];
                NSString* type = [[getSection objectAtIndex:j] valueForKey:@"type"];
                NSMutableArray* instructors = [[getSection objectAtIndex:j]  valueForKey:@"instructor"];
                NSString* instructor;
                @try {
                    for (int k = 0; k < instructors.count; k++) {
                        if (k == 0) {
                            instructor = [NSString stringWithFormat:@"%@ %@", [[instructors objectAtIndex:k] valueForKey:@"first_name"], [[instructors objectAtIndex:k] valueForKey:@"last_name"]];
                        }else {
                            instructor = [NSString stringWithFormat:@"%@, %@ %@", instructor, [[instructors objectAtIndex:k] valueForKey:@"first_name"], [[instructors objectAtIndex:k] valueForKey:@"last_name"]];
                        }
                    }
                }@catch(NSException *exception) {
                    instructor = [NSString stringWithFormat:@"%@ %@", [instructors valueForKey:@"first_name"], [instructors valueForKey:@"last_name"]];
                }
                SectionModel* section = [[SectionModel alloc] initWithSection:sectionId dclass:dclass availableSpace:space numberRegistered:registered start_time:start end_time:end location:location day:day instructor:instructor type:type];
                [sections addObject:section];
            }
        }else {
            NSString* sectionId = [getSection valueForKey:@"id"];
            NSString* dclass = [getSection valueForKey:@"dclass_code"];
            NSString* space = [getSection valueForKey:@"spaces_available"];
            NSString* registered = [getSection valueForKey:@"number_registered"];
            NSString* start = [getSection valueForKey:@"start_time"];
            NSString* end = [getSection valueForKey:@"end_time"];
            NSString* day = [getSection valueForKey:@"day"];
            NSString* location= [getSection valueForKey:@"location"];
            NSString* type = [getSection valueForKey:@"type"];
            NSMutableArray* instructors = [getSection valueForKey:@"instructor"];
            NSString* instructor;
            @try {
                for (int k = 0; k < instructors.count; k++) {
                    if (k == 0) {
                        instructor = [NSString stringWithFormat:@"%@ %@", [[instructors objectAtIndex:k] valueForKey:@"first_name"], [[instructors objectAtIndex:k] valueForKey:@"last_name"]];
                    }else {
                        instructor = [NSString stringWithFormat:@"%@, %@ %@", instructor, [[instructors objectAtIndex:k] valueForKey:@"first_name"], [[instructors objectAtIndex:k] valueForKey:@"last_name"]];
                    }
                }
            }@catch(NSException *exception) {
                instructor = [NSString stringWithFormat:@"%@ %@", [instructors valueForKey:@"first_name"], [instructors valueForKey:@"last_name"]];
            }
            SectionModel* section = [[SectionModel alloc] initWithSection:sectionId dclass:dclass availableSpace:space numberRegistered:registered start_time:start end_time:end location:location day:day instructor:instructor type:type];
            [sections addObject:section];
        }
        NSDictionary* course = @{ preKey:prefix, numberKey:number, titleKey:title, suffixKey:suffix, unitKey:units, descriptionKey:description, sectionKey:sections};
        [self.courses addObject:course];
    }
    return self;
}

-(NSInteger) numberOfCourse {
    return self.courses.count;
}

-(NSDictionary *) courseAtIndex:(NSInteger)index {
    return self.courses[index];
}

+(instancetype) sharedModel:(NSString*) prefix{
    static CourseModel* sharedModel = nil;
    if([prefix length] != 0){
        sharedModel = [[self alloc] initWithPrefix:prefix];
    }
    return sharedModel;
}
@end
