//
//  DepartmentTableViewController.m
//  USCourse
//
//  Created by Young Kim on 12/5/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import "DepartmentTableViewController.h"
#import "DepartmentModel.h"
#import "CourseTableViewController.h"
#import "CourseModel.h"

@interface DepartmentTableViewController ()
@property (strong, nonatomic) NSString* selectedPrefix;
@property (strong, nonatomic) DepartmentModel* model;
@end

@implementation DepartmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [DepartmentModel sharedModel:_term];
    self.navigationController.hidesBarsOnSwipe = YES;
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
    return [self.model numberOfDept];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DepartTableRow" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *department = [self.model departmentAtIndex:indexPath.row];
    cell.textLabel.text = department[nameKey];
    cell.detailTextLabel.text = department[prefixKey];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedPrefix = [self.model departmentAtIndex:indexPath.row][prefixKey];
    [self performSegueWithIdentifier:@"CourseSegue" sender:tableView];
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
    if ([segue.destinationViewController isKindOfClass:[CourseTableViewController class]]) {
        CourseTableViewController *cor = segue.destinationViewController;
        cor.prefix = _selectedPrefix;
        cor.term = _term;
    }
}


@end
