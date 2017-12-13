//
//  ViewController.m
//  USCourse
//
//  Created by Young Kim on 12/5/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import "ViewController.h"
#import "DepartmentModel.h"
#import "DepartmentTableViewController.h"
@interface ViewController ()
@property (nonatomic, strong) DepartmentModel* model;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [[NSString alloc]initWithFormat:@""];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSString*)getTerm {
    return self.term;
}
- (IBAction)FallDidPressed:(UIButton *)sender {
    _term= [[NSString alloc]initWithFormat:@"20173"];
    self.model = [DepartmentModel sharedModel:_term];
}

- (IBAction)SpringDidPressed:(UIButton *)sender {
    _term= [[NSString alloc]initWithFormat:@"20181"];
    self.model = [DepartmentModel sharedModel:_term];
}
- (IBAction)SummerDidPressed:(UIButton *)sender {
    _term= [[NSString alloc]initWithFormat:@"20172"];
    self.model = [DepartmentModel sharedModel:_term];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    //NSLog(@"%s %@ %@", __FUNCTION__, segue.sourceViewController, segue.destinationViewController);
    DepartmentTableViewController *dep = segue.destinationViewController;
    dep.term = self.term;
}

@end
