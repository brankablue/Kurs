//
//  DataManager.m
//  ToDo
//
//  Created by Kurs on 2/25/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"

@interface DataManager()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation DataManager


#pragma mark - Properties

- (void)setUserLocation:(CLLocation *)userLocation {
    _userLocation = userLocation;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"CLGeocoder error: %@", error.localizedDescription);
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            
            self.userLocality = placemark.locality;
            
            NSLog(@"ISOcountryCode: %@", placemark.ISOcountryCode);
            NSLog(@"Country: %@", placemark.country);
            NSLog(@"Postal code: %@", placemark.postalCode);
            NSLog(@"Administrative area: %@", placemark.administrativeArea);
            NSLog(@"Locality: %@", placemark.locality);
            NSLog(@"SubLocality: %@", placemark.subLocality);
            NSLog(@"sub troughfare: %@", placemark.subThoroughfare);
        }
    }];
}

- (void)setUserLocality:(NSString *)userLocality {
    _userLocality = userLocality;
    
    // Via delegate
    if (self.delegate) {
        [self.delegate dataManagerDidUpdateLocality];
    }
    
    //Via notification
    [[NSNotificationCenter defaultCenter] postNotificationName:userLocality object:nil];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedObjectContext = appDelegate.persistentContainer.viewContext;
    }
    return _managedObjectContext;
}

#pragma  marka - Designated Initializer

+ (instancetype)sharedManager {
    static DataManager *shared;
    
    @synchronized (self) {
        if (shared ==nil) {
            shared = [[DataManager alloc] init];
        }
    }
    
    return  shared;
}

#pragma mark - PUblic API

- (NSMutableArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortAsc:(BOOL)sortAscending
                         forKey:(NSString *)sortKey {
    
}

- (void)deleteObject:(NSManagedObject *)object {
    [self.managedObjectContext deleteObject:object];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(saveContext)]) {
         [appDelegate saveContext];
    }
   
}

- (void)updateObject:(NSManagedObject *)object {
    NSError *error = nil;
    if ([object.managedObjectContext hasChanges]) && ![object._managedObjectContext save:&error]) {
        NSLog(@"Error updating object in database: %@, %@", error.localizedDescription, error.userinfo);
        abort();
    }
}

- (void)logObject:(NSManagedObject *)object {
    
}

- (NSInteger)numberOfTaskPerTaskGroup:(TaskGroup *)group {
    NSArray *taskArray = [self fetchEntity:NSStringFromClass([DBTask class])
                                withFilter:[[NSString stringWithFormat:@"group = %ld", group]
                               withSortAsc:NO
                                    forKey:nil];
                          
        return taskArray.count;
    
}

- (void)saveTaskWithTitle:(NSString *)title
              description:(NSString *)description
                    group:(NSInteger)group{
                        DBTask *task = (DBTask *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(([DBTask class]) inManagedObjectContext:self.managedObjectContext];
                                                                                                                        
                    task.title = title;
                    task.desc = description;
                    if (self.userLocation) {
                    task.latitude = self.userLocation.coordinate.latitude;
                    task.longitude = self.userLocation.coordinate.longitude;
                        
}
                    task.date = [NSDate date];
                    task.group = group;
                                                                                                                        
                    //Save
                    [task.managedObjectContext save:nil];
                                                                                                            
}


@end
