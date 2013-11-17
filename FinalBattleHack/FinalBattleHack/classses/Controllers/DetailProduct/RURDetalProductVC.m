//
//  RURDetalProductVC.m
//  FinalBattleHack
//
//  Created by Oriol Capdevila on 16/11/13.
//  Copyright (c) 2013 The Synthesizers. All rights reserved.
//

#import "RURDetalProductVC.h"
#import "PayPalPaymentViewController.h"

@interface RURDetalProductVC ()

@end

@implementation RURDetalProductVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
}

- (IBAction)payWithPP:(id)sender {
    PayPalPayment *payment = [[PayPalPayment alloc]init];
    payment.currencyCode = @"USD";
    payment.amount = (NSDecimalNumber *) @60;
    payment.shortDescription = @"Nice Apple magic mouse!";
    
    if (payment.processable) {
        PayPalPaymentViewController *paymentScreen = [[PayPalPaymentViewController alloc]initWithClientId:clientId receiverEmail:@"r.lapuente-facilitator@gmail.com" payerId:@"PLAYEDID" payment:payment delegate:self];
        [self presentViewController:paymentScreen animated:YES completion:nil];
    } else {
        NSLog(@"something went wrong");
    }
}

- (IBAction)addToChart:(id)sender {
    //code for add to chart
}

#pragma mark - PayPal Delegate

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment
{
    //payment dictionary payment{amount,currency_code,short_description
    //payment dictionary proof_of_payment{adaptative_payment{app_id,pay_key,payment:exec_status,timestamp}}
    NSDictionary *payment = completedPayment.confirmation;
    
    //dismiss screen to show confirmation paye + sending home/pick-up at shop
}

- (void)payPalPaymentDidCancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"PayPal was cancelled");
    }];
}

@end
