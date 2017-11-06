//
//  ViewController.m
//  MeatCure9000
//
//  Created by Mike Rioux on 2017-09-11.
//  Copyright © 2017 Mike Rioux. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end


NSString *ip = @"http://meatcure9000.hopto.org:8090";

bool removeSplash = false;
long code =0;
bool automated = true;
bool setButtons = true;

@implementation ViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     self.myDict = [[NSMutableDictionary alloc] init];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f
                                     target:self selector:@selector(refreshTandH:) userInfo:nil repeats:YES];
}


// Loop to constantly refresh
-(void)refreshTandH:(NSTimer *)timer {
   
    self.myDict = [self getStatusFromServer];

    
    if([self.myDict count] > 0) {
    
        
        NSLog(@"%@",self.myDict);
        
        [self setTempAndHumidity:self.myDict];
        if (automated)
            [self setButtons:self.myDict];
        
        
        // Do this once and only when we get our first Doc.
        if(!removeSplash){
            
            
            NSLog(@"removing splash");
            [self.splash removeFromSuperview];
            removeSplash = true;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fridgeOnClick:(id)sender {
    NSLog(@"Fridge ON");
    
   
    
    [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:[ ip stringByAppendingString:  @"/api/FridgeOn"]]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     
                                     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                     code = [httpResponse statusCode];
                                     
                                 }] resume ];
    
    if (code == 200) {
        NSLog(@"Server Ack Fridge ON");
        [self.fridgeOnButton setBackgroundColor:[UIColor greenColor]];
        [self.fridgeOffButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
        code = 0;
    } else {
        NSLog(@"Server DID NOT get Button Press");
        code = 0;
    }
    
    
}
- (IBAction)fridgeOffClick:(id)sender {
    NSLog(@"Fridge OFF");
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString: [ ip stringByAppendingString:  @"/api/FridgeOff"]]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                    
                                     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                     code = [httpResponse statusCode];
                                     
                                 }] resume ];

    if (code == 200) {
        NSLog(@"Server Ack Fridge OFF");
        [self.fridgeOnButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
        [self.fridgeOffButton setBackgroundColor:[UIColor redColor]];
        code = 0;
    } else {
        NSLog(@"Server DID NOT get Button Press");
        code = 0;
    }
}
- (IBAction)fanOnClick:(id)sender {
    NSLog(@"Fan ON");
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:[ip stringByAppendingString:  @"/api/FanOn"]]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
         code = [httpResponse statusCode];
                                    
    }] resume ];
    
    
    if (code == 200) {
        NSLog(@"Server Ack Fan ON");
        [self.fanOnButton setBackgroundColor:[UIColor greenColor]];
        [self.fanOffButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
        code = 0;
    } else {
        NSLog(@"Server DID NOT get Button Press");
        code = 0;
    }
    
}

- (IBAction)fanOffClick:(id)sender {
    NSLog(@"Fan OFF");
    
    [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:    [ip stringByAppendingString:  @"/api/FanOff"]]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
         code = (long)[httpResponse statusCode];
                                     
        
    }] resume ];
    
    if (code == 200) {
        NSLog(@"Server Ack Fan OFF");
        [self.fanOnButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
        [self.fanOffButton setBackgroundColor:[UIColor redColor]];
        code = 0;
    } else {
        NSLog(@"Server DID NOT get Button Press");
        code = 0;
    }
    
}

- (IBAction)humidifierOnClick:(id)sender {
    NSLog(@"Humidifier ON");
    

    [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:[ip stringByAppendingString:  @"/api/HumidifierOn"]]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                     code = (long)[httpResponse statusCode];
                                     
                                 }] resume ];
    
    if (code == 200) {
        NSLog(@"Server Ack Humidifier ON");
        [self.humidifierOnButton setBackgroundColor:[UIColor greenColor]];
        [self.humidifierOffButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
        code = 0;
    } else {
        NSLog(@"Server DID NOT get Button Press");
        code = 0;
    }
    
}
- (IBAction)humidifierOffClick:(id)sender {
    
    NSLog(@"Humidifier OFF");
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:[ip stringByAppendingString:  @"/api/HumidifierOff"]]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                     code = (long)[httpResponse statusCode];
                                     
                                     
                                 }] resume ];
    
    if (code == 200) {
        NSLog(@"Server Ack Humidifier OFF");
        [self.humidifierOnButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
        [self.humidifierOffButton setBackgroundColor:[UIColor redColor]];
        code = 0;
    } else {
        NSLog(@"Server DID NOT get Button Press");
        code = 0;
    }
}

- (IBAction)refreshOnClick:(id)sender {
    NSLog(@"Refresh");
    // Send Get to get most up to date temp/humidity
    
   
    [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString: [ip stringByAppendingString:  @"/api/status"]]
        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"Got reply");
    
            // parse the JSON string into an object - assuming json_string is a NSString of JSON data
           
            self.myDict = [self cleanJsonToObject:data];
            
            NSLog(@"Dict Version: %@", self.myDict);
           
            
                                     
    }] resume ];
    
     [self setTempAndHumidity:self.myDict];
    

    
}
- (IBAction)automatedOnClick:(id)sender {
    
    // get code to see if its on or off.
    
    if (!automated) {
    
    [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:    [ip stringByAppendingString:  @"/api/automatedOn"]]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                     code = (long)[httpResponse statusCode];
                                     
                                     
                                 }] resume ];
    
    if (code == 200) {
        NSLog(@"Server Ack Automation ON");
        [self.automatedButton setBackgroundColor:[UIColor greenColor]];
        
        [self.fanOnButton setEnabled:false];
        [self.fanOffButton setEnabled:false];
        [self.humidifierOnButton setEnabled:false];
        [self.humidifierOffButton setEnabled:false];
        [self.fridgeOnButton setEnabled:false];
        [self.fridgeOffButton setEnabled:false];
        automated = true;
        setButtons = false;
        
        code = 0;
    } else {
        NSLog(@"Server DID NOT get Button Press");
        code = 0;
    }
        
        
    } else {
        

        [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString:    [ip stringByAppendingString:  @"/api/automatedOff"]]
                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                         code = (long)[httpResponse statusCode];
                                         
                                         
                                     }] resume ];
        
        if (code == 200) {
            NSLog(@"Server Ack Automation OFF");
            [self.automatedButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
            [self.fanOnButton setEnabled:true];
            [self.fanOffButton setEnabled:true];
            [self.humidifierOnButton setEnabled:true];
            [self.humidifierOffButton setEnabled:true];
            [self.fridgeOnButton setEnabled:true];
            [self.fridgeOffButton setEnabled:true];
            code = 0;
            automated = false;
            setButtons = false;
        } else {
            NSLog(@"Server DID NOT get Button Press");
            code = 0;
        }
        
    }
   
}

- (id)getStatusFromServer {
    // run get on DB to get most recent temp/humiditiy.
    
    [[[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString: [ip stringByAppendingString:  @"/api/status"]]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     
    NSLog(@"Got reply");
                                     
    if (data != nil) {
        self.myDict = [self cleanJsonToObject:data];
        NSLog(@"Dict Updated");
    } else {
        NSLog(@"Dict NOT Updated");
    }
    }] resume ];

    return self.myDict;
    
}

    - (void)setButtons:(id)data {
        
         NSLog(@"Setting Buttons");
        
        NSDictionary *status =[data objectForKey:@"status"];
        NSString *automatedStatus = [data objectForKey:@"automation"];
        
        NSString *fridgeStatus = [status objectForKey:@"Fridge"];
        NSString *fanStatus = [status objectForKey:@"Fan"];
        NSString *humidifierStatus = [status objectForKey:@"Humidifier"];

        //Set Fridge buttons
        if ( [fridgeStatus isEqualToString: @"On" ]){
            [self.fridgeOnButton setBackgroundColor:[UIColor greenColor]];
            [self.fridgeOffButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
            
        } else {
            [self.fridgeOffButton setBackgroundColor:[UIColor redColor]];
            [self.fridgeOnButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
            
        }
        //Set Humidifier buttons
        if ( [humidifierStatus isEqualToString: @"On" ]){
            [self.humidifierOnButton setBackgroundColor:[UIColor greenColor]];
            [self.humidifierOffButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
            
        } else {
            [self.humidifierOffButton setBackgroundColor:[UIColor redColor]];
            [self.humidifierOnButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
        }
        //Set Fan buttons
        if ( [fanStatus isEqualToString: @"On" ]){
            [self.fanOnButton setBackgroundColor:[UIColor greenColor]];
            [self.fanOffButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
        } else {
            [self.fanOffButton setBackgroundColor:[UIColor redColor]];
            [self.fanOnButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
        }
        //Set Automated Button
        // lets only set these bad boys if didnt JUST click Automation.
        if (setButtons){
            if ([automatedStatus isEqualToString: @"On" ]){
                automated = true;
                [self.automatedButton setBackgroundColor:[UIColor greenColor]];
            
                [self.fanOnButton setEnabled:false];
                [self.fanOffButton setEnabled:false];
                [self.humidifierOnButton setEnabled:false];
                [self.humidifierOffButton setEnabled:false];
                [self.fridgeOnButton setEnabled:false];
                [self.fridgeOffButton setEnabled:false];
            } else {
                [self.automatedButton setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0]];
                automated = false;
            }
        }
        
        NSLog(@"Status: %@ %@ %@ %@", fridgeStatus, fanStatus, humidifierStatus, automatedStatus);
        setButtons = true;
    }

    - (void)setTempAndHumidity:(id)data {
        
        // TODO we should set the time here as well.
        
        
        NSLog(@"Setting Temp&Humidity&Time");
        
        
        float tempNum = [[self.myDict objectForKey:@"temp"]floatValue] ;
        NSString *temp = [NSString stringWithFormat:@"%.1f", tempNum];
        NSString * temperature = [temp stringByAppendingString: @"°"];
        
        float humidityNum = [[self.myDict objectForKey:@"humidity"]floatValue] ;
        NSString *humid = [NSString stringWithFormat:@"%.1f", humidityNum];
        NSString * humidity = [humid stringByAppendingString: @"%"];
        
        NSLog(@"NEW TEMP: %@", temperature);
        NSLog(@"NEW HUMIDITY: %@", humidity);
        
        self.tempLabel.text = temperature;
        self.humidityLabel.text = humidity;
        self.timeLabel.text = [self.myDict objectForKey:@"time"];
        
        
    }
    
    - (id)cleanJsonToObject:(id)data
    {
        NSError* error;
        if (data == (id)[NSNull null])
        {
            return [[NSObject alloc] init];
        }
        id jsonObject;
        if ([data isKindOfClass:[NSData class]])
        {
            jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        } else
        {
            jsonObject = data;
        }
        if ([jsonObject isKindOfClass:[NSArray class]])
        {
            NSMutableArray *array = [jsonObject mutableCopy];
            for (int i = (int)array.count-1; i >= 0; i--)
            {
                id a = array[i];
                if (a == (id)[NSNull null])
                {
                    [array removeObjectAtIndex:i];
                } else
                {
                    array[i] = [self cleanJsonToObject:a];
                }
            }
            return array;
        } else if ([jsonObject isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *dictionary = [jsonObject mutableCopy];
            for(NSString *key in [dictionary allKeys])
            {
                id d = dictionary[key];
                if (d == (id)[NSNull null])
                {
                    dictionary[key] = @"";
                } else
                {
                    dictionary[key] = [self cleanJsonToObject:d];
                }
            }
            return dictionary;
        } else
        {
            return jsonObject;
        }
    }

@end
