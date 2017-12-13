//
//  SectionModel.m
//  USCourse
//
//  Created by Young Kim on 12/9/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import "SectionModel.h"

@implementation SectionModel
-(instancetype) initWithSection: (NSString*) section_id dclass: (NSString*) dclass availableSpace:(NSString*) space numberRegistered:(NSString*) registered start_time: (NSString*) start end_time: (NSString*) end location: (NSString*) location day: (NSString*) day instructor: (NSString*) instructor type:(NSString*) type{
    self = [super init];
    if (self) {
        _section_id = section_id;
        _dclass = dclass;
        _availableSpace = space;
        _numberRegisterd = registered;
        _start_time = start;
        _end_time = end;
        _location = location;
        _day = day;
        _instructor = instructor;
        _type = type;
    }
    return self;
}
@end
