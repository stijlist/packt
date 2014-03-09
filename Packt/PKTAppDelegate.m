//
//  PKTAppDelegate.m
//  Packt
//
//  Created by Bert Muthalaly on 2/28/14.
//  Copyright (c) 2014 Bert Muthalaly. All rights reserved.
//

#import "PKTAppDelegate.h"
#import "PKTEventManager.h"
#import "PKTTask.h"

@implementation PKTAppDelegate

-(id) init {
    self = [super init];
    if (self) {
        _taskList = [[NSMutableArray alloc] init];
    }
    NSLog(@"%@", [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys]);
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // load data
    [self loadTasks];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self persistTasks];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self persistTasks];
}
- (void)persistTasks
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:[self taskListDictionaryRepresentation] forKey:@"tasks"];
    [defs synchronize];
    NSLog(@"Tasks saved!");
}
- (void)loadTasks
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray *tasksLoaded = [defs arrayForKey:@"tasks"];
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    if (tasksLoaded) {
        for (NSDictionary *dict in tasksLoaded) {
            PKTTask *task = [[PKTTask alloc] initFromDictionary:dict];
            [tasks addObject:task];
        }
        self.taskList = tasks;
        NSLog(@"Tasks loaded!");
    }
}
- (NSArray *)taskListDictionaryRepresentation
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (PKTTask *task in self.taskList) {
        [results addObject:[task dictionaryRepresentation]];
    }
    return results;
}
@end
