//
//  SectionModel.h
//  USCourse
//
//  Created by Young Kim on 12/9/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SectionModel : NSObject

@property (nonatomic, strong) NSString* section_id;
@property (nonatomic, strong) NSString* dclass;
@property (nonatomic, strong) NSString* availableSpace;
@property (nonatomic, strong) NSString* numberRegisterd;
@property (nonatomic, strong) NSString* start_time;
@property (nonatomic, strong) NSString* end_time;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* day;
@property (nonatomic, strong) NSString* instructor;
@property (nonatomic, strong) NSString* type;

-(instancetype) initWithSection: (NSString*) section_id
                         dclass: (NSString*) dclass
                 availableSpace: (NSString*) space
               numberRegistered: (NSString*) registered
                      start_time: (NSString*) start
                       end_time: (NSString*) end
                       location: (NSString*) location
                            day: (NSString*) day
                     instructor: (NSString*) instructor
                           type: (NSString*) type;
@end
