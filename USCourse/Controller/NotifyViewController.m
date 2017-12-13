//
//  NotifyViewController.m
//  USCourse
//
//  Created by Young Kim on 12/10/17.
//  Copyright © 2017 Young Jin Kim. All rights reserved.
//

#import "NotifyViewController.h"

@interface NotifyViewController () <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextView;
@property (weak, nonatomic) IBOutlet UITextField *sectionTextField;
@property (weak, nonatomic) IBOutlet UIButton *notifyButton;

@end

@implementation NotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.emailTextView becomeFirstResponder];
    self.emailTextView.delegate = self;
    self.sectionTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   // NSLog(@"here");
    [self enableOrDisableSaveButton];
    
    return YES;
}

- (void)enableOrDisableSaveButton{
    // Validate the input and enable or disable save button accordingly
    if (self.emailTextView.text.length > 0 && self.sectionTextField.text.length > 0){
        self.notifyButton.enabled = YES;
    } else{
        self.notifyButton.enabled = NO;
    }
    
}
- (IBAction)notifyButtonDidPressed:(UIButton *)sender {
    self.completionHandler(self.emailTextView.text, self.sectionTextField.text);
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Success" message:@"Notify Success"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                }];
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    [self enableOrDisableSaveButton];
    
    return YES;
}

- (IBAction)cancelButtonDidPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
