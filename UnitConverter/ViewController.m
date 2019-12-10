//
//  ViewController.m
//  UnitConverter
//
//  Created by Nursultan on 26/11/2019.
//  Copyright © 2019 Nursultan Askarbekuly. All rights reserved.
//

#import "ViewController.h"
#import "CurrencyRequest/CRCurrencyRequest.h"
#import "CurrencyRequest/CRCurrencyResults.h"

@interface ViewController () <CRCurrencyRequestDelegate>

@property (nonatomic) CRCurrencyRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@end

@implementation ViewController

- (IBAction)convertButtonPressed:(id)sender {
    
    self.convertButton.enabled = false;
    self.req = CRCurrencyRequest.new;
    self.req.delegate = self;
    [self.req start];
}

- (void)currencyRequest:(CRCurrencyRequest *)req retrievedCurrencies:(CRCurrencyResults *)currencies {
    self.convertButton.enabled = true;
    double inputValue = [self.inputTextField.text doubleValue];
    double convertedValue;
    
    switch (self.segmentController.selectedSegmentIndex) {
        case 0:
            convertedValue = inputValue * currencies.EUR;
            break;
        case 1:
            convertedValue = inputValue * currencies.GBP;
            break;
        case 2:
            convertedValue = inputValue * currencies.JPY;
            break;
        default:
            self.outputLabel.text = @"No currency chosen";
            return;
    }
    
    NSString *temp = [NSString stringWithFormat:@"%.2f", convertedValue];
    self.outputLabel.text = temp;
}


@end
