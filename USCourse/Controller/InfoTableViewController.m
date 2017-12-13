//
//  InfoTableViewController.m
//  USCourse
//
//  Created by Young Kim on 12/10/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import "InfoTableViewController.h"
#import "MainTableViewCell.h"
#import "SectionModel.h"
#import "NotifyViewController.h"
#import <AWSCore/AWSCore.h>
#import <AWSCognito/AWSCognito.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@interface InfoTableViewController () <SKPSMTPMessageDelegate>
@property (strong, nonatomic) NSMutableArray *sections;
@property (strong, nonatomic) NSString *selected_section;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *open_space;
@end

@implementation InfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // NSLog(@"%@", [_course allKeys]);
    self.sections = [_course objectForKey:@"sections"];
    self.tableView.rowHeight = 200;
    self.navigationItem.title = [_course objectForKey:@"prefix"];
  // NSLog(@"%i",[self.sections count]);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([self.sections count] + 1);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTableRow" forIndexPath:indexPath];
        cell.title.text = [NSString stringWithFormat:@"%@%@ - %@ units", [_course objectForKey:@"prefix"], [_course objectForKey:@"number"],[_course objectForKey:@"units"]];
        cell.detail.text = [_course objectForKey:@"description"];
        return cell;
    } else {
        MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTableRow" forIndexPath:indexPath];
        SectionModel *section = [self.sections objectAtIndex:indexPath.row - 1];
        NSString* instructors = [section instructor];
        if ([instructors length] == 0) {
            instructors = @"";
        }
        if ([[section type] isEqualToString:@"Lec"]) {
            cell.title.text =[NSString stringWithFormat:@"Lecture %@%@",[section section_id],[section dclass]];
            cell.detail.text = [NSString stringWithFormat:@"Instructor: %@\nDay: %@\nStart time: %@\nEnd time: %@\nLocation: %@\nCurrently Registered: %@\nSpace Available: %@", instructors, [section day], [section start_time], [section end_time], [section location], [section numberRegisterd], [section availableSpace]];
        }else if ([[section type] isEqualToString:@"Dis"]) {
            cell.title.text =[NSString stringWithFormat:@"Discussion %@%@",[section section_id],[section dclass]];
            cell.detail.text = [NSString stringWithFormat:@"Day: %@\nStart time: %@\nEnd time: %@\nLocation: %@\nCurrently Registered: %@\nSpace Available: %@", [section day], [section start_time], [section end_time], [section location], [section numberRegisterd], [section availableSpace]];
        }else if ([[section type] isEqualToString:@"Lab"]){
            cell.title.text =[NSString stringWithFormat:@"Lab %@%@",[section section_id],[section dclass]];
            cell.detail.text = [NSString stringWithFormat:@"Day: %@\nStart time: %@\nEnd time: %@\nLocation: %@\nCurrently Registered: %@\nSpace Available: %@",  [section day], [section start_time], [section end_time], [section location], [section numberRegisterd], [section availableSpace]];
        }else if ([[section type] isEqualToString:@"Lec-Lab"]) {
            cell.title.text =[NSString stringWithFormat:@"Lecture/Lab %@%@",[section section_id],[section dclass]];
            cell.detail.text = [NSString stringWithFormat:@"Instructor: %@\nDay: %@\nStart time: %@\nEnd time: %@\nLocation: %@\nCurrently Registered: %@\nSpace Available: %@", instructors, [section day], [section start_time], [section end_time], [section location], [section numberRegisterd], [section availableSpace]];
        }else {
            cell.title.text =[NSString stringWithFormat:@"Quiz %@%@",[section section_id],[section dclass]];
            cell.detail.text = [NSString stringWithFormat:@"Day: %@\nStart time: %@\nEnd time: %@\nLocation: %@\nCurrently Registered: %@\nSpace Available: %@", [section day], [section start_time], [section end_time], [section location], [section numberRegisterd], [section availableSpace]];
        }
        return cell;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[NotifyViewController class]]) {
        NotifyViewController *not = segue.destinationViewController;
        not.completionHandler = ^ (NSString *email, NSString *section) {
            self.email = email;
            self.selected_section = section;
            AWSCognito *syncClient = [AWSCognito defaultCognito];
            
            // Create a record in a dataset and synchronize with the server
            AWSCognitoDataset *dataset = [syncClient openOrCreateDataset:@"myDataset"];
            [dataset setString:email forKey:@"email"];
            [dataset setString:section forKey:@"section_id"];
            [dataset setString:_term forKey:@"term"];
            [dataset setString:[_course objectForKey:@"prefix"] forKey:@"prefix"];
            [dataset setString:[_course objectForKey:@"number"] forKey:@"number"];
            [[dataset synchronize] continueWithBlock:^id(AWSTask *task) {
                // Your handler code here
                if (task.error == nil) {
                    NSLog(@"Saved to AWS Cognito");
                }
                return nil;
            }];
            [NSTimer scheduledTimerWithTimeInterval:10.0f
                                             target:self selector:@selector(methodB:) userInfo:nil repeats:YES];
        };
    }
}

- (void) methodB:(NSTimer *)timer {
    NSLog(@"here fore 60 sec");
    NSString* course = [NSString stringWithFormat:@"http://web-app.usc.edu/web/soc/api/classes/%@/%@",[_course objectForKey:@"prefix"],_term];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:course]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSMutableArray *departs = [[json valueForKey:@"OfferedCourses"] mutableCopy];
    NSMutableArray *courses = [[departs valueForKey:@"course"] mutableCopy];
    for (int i = 0; i < courses.count; i++) {
        NSMutableArray* data = [[courses objectAtIndex:i] valueForKey:@"CourseData"];
        NSString* number = [data valueForKey:@"number"];
        if ([number isEqualToString:[_course objectForKey:@"number"]]) {
            NSMutableArray* getSection = [data valueForKey:@"SectionData"];
            if (getSection.count < 16) { //when it's not just one section
                for (int j = 0; j < getSection.count; j++) {
                    NSString* sectionId = [[getSection objectAtIndex:j] valueForKey:@"id"];
                    NSString* space = [[getSection objectAtIndex:j]  valueForKey:@"spaces_available"];
                    if ([sectionId isEqualToString:_selected_section]) {
                        NSLog(@"Space available: %@", space);
                        _open_space = space;
                        if(![space isEqualToString:@"0"]) {
                            [self sendEmailInBackground];
                            [timer invalidate];
                        }
                        break;
                    }
                }
            }else {
                NSString* sectionId = [getSection valueForKey:@"id"];
                NSString* space = [getSection valueForKey:@"spaces_available"];
                if ([sectionId isEqualToString:_selected_section]) {
                    NSLog(@"Space available: %@", space);
                    _open_space = space;
                    if(![space isEqualToString:@"0"]) {
                        [self sendEmailInBackground];
                        [timer invalidate];
                    }
                    break;
                }
            }
        }
    }
}

-(void) sendEmailInBackground {
    NSLog(@"Start Sending");
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = @"kimyou1994@gmail.com"; //sender email address
    emailMessage.toEmail =_email; //receiver email address
    emailMessage.relayHost = @"smtp.gmail.com";
    emailMessage.requiresAuth = YES;
    emailMessage.login = @"kimyou1994@gmail.com"; //sender email address
    emailMessage.pass = @"VVvv0405"; //sender email password
    NSString *header = [NSString stringWithFormat:@"@%@%@ Section ID:%@ has available space",[_course objectForKey:@"prefix"], [_course objectForKey:@"number"], _selected_section];
    emailMessage.subject = header;
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self; // you must include <SKPSMTPMessageDelegate> to your class
    NSString *body = [NSString stringWithFormat:@"%@%@ Section ID:%@ has %@ available space.\nGo to usc website to register!\n https://my.usc.edu/",[_course objectForKey:@"prefix"], [_course objectForKey:@"number"], _selected_section, _open_space];
    NSString *messageBody = body;
    // Now creating plain text email message
    NSDictionary *plainMsg = [NSDictionary
                              dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                              messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
    [emailMessage send];
    // sending email- will take little time to send so its better to use indicator with message showing sending...
}

-(void)messageSent:(SKPSMTPMessage *)message{
    NSLog(@"delegate - message sent");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message sent." message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    // open an alert with just an OK button
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
}

@end
