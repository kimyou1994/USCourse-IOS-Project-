//
//  CourseTableViewController.m
//  USCourse
//
//  Created by Young Kim on 12/5/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import "CourseTableViewController.h"
#import "CourseModel.h"
#import "DepartmentModel.h"
#import "InfoTableViewController.h"

@interface CourseTableViewController ()
@property (strong, nonatomic) DepartmentModel* depart;
@property (strong, nonatomic) CourseModel* model;
@property (strong, nonatomic) NSDictionary* selectedCourse;
@end

@implementation CourseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.depart=  [DepartmentModel sharedModel:_term];
    self.model = [CourseModel sharedModel:self.prefix];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model numberOfCourse];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseTableRow" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *course = [self.model courseAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", course[preKey], course[numberKey]];
   // cell.detailTextLabel.text = course[prefixKey];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCourse = [self.model courseAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"InfoSegue" sender:tableView];
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[InfoTableViewController class]]) {
        InfoTableViewController *info = segue.destinationViewController;
        info.course = self.selectedCourse;
        info.term = self.term;
    }
}


@end
