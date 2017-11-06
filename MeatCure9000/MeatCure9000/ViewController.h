//
//  ViewController.h
//  MeatCure9000
//
//  Created by Mike Rioux on 2017-09-11.
//  Copyright © 2017 Mike Rioux. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
    @property (nonatomic, retain) NSMutableDictionary *myDict;
    @property (weak, nonatomic) IBOutlet UILabel *tempLabel;
    @property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
    @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
    @property (weak, nonatomic) IBOutlet UIButton *fridgeOnButton;
    @property (weak, nonatomic) IBOutlet UIButton *fridgeOffButton;
    @property (weak, nonatomic) IBOutlet UIButton *fanOnButton;
    @property (weak, nonatomic) IBOutlet UIButton *fanOffButton;
    @property (weak, nonatomic) IBOutlet UIButton *humidifierOnButton;
    @property (weak, nonatomic) IBOutlet UIButton *humidifierOffButton;
    @property (weak, nonatomic) IBOutlet UIButton *refreshButton;
    @property (weak, nonatomic) IBOutlet UIView *splash;
    @property (weak, nonatomic) IBOutlet UIButton *automatedButton;

@end

