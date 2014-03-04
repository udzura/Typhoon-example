//
//  PFCityDaoJapanImpl.m
//  PocketForecast
//
//  Created by Uchio KONDO on 2014/03/04.
//  Copyright (c) 2014年 typhoon. All rights reserved.
//

#import "PFCityDaoJapanImpl.h"

@implementation PFCityDaoJapanImpl

static NSString* const pfCitiesListKey = @"pfWeather.cities2";
static NSString* const pfCurrentCityKey = @"pfWeather.currentCityKey2";


/* ============================================================ Initializers ============================================================ */
- (id)init
{
    self = [super init];
    if (self)
    {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}


/* =========================================================== Protocol Methods ========================================================= */

- (NSArray*)listAllCities
{
    
    NSArray* cities = [_defaults objectForKey:pfCitiesListKey];
    if (cities == nil)
    {
        cities = @[
                   @"Tokyo",
                   @"Osaka",
                   @"Fukuoka"
                   ];
        
        [_defaults setObject:cities forKey:pfCitiesListKey];
    }
    return [cities sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (void)saveCity:(NSString*)name
{
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray* cities = [NSMutableArray arrayWithArray:[_defaults objectForKey:pfCitiesListKey]];
    BOOL canAddCity = YES;
    for (NSString* city in cities)
    {
        if ([city caseInsensitiveCompare:name] == NSOrderedSame)
        {
            canAddCity = NO;
        }
    }
    if (canAddCity)
    {
        [cities addObject:name];
        [_defaults setObject:cities forKey:pfCitiesListKey];
    }
}

- (void)deleteCity:(NSString*)name
{
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray* cities = [NSMutableArray arrayWithArray:[_defaults objectForKey:pfCitiesListKey]];
    NSString* cityToRemove = nil;
    for (NSString* city in cities)
    {
        if ([city caseInsensitiveCompare:name] == NSOrderedSame)
        {
            cityToRemove = city;
        }
    }
    [cities removeObject:cityToRemove];
    [_defaults setObject:cities forKey:pfCitiesListKey];
}

- (void)saveCurrentlySelectedCity:(NSString*)cityName
{
    NSString* trimmed = [cityName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([trimmed length] > 0)
    {
        [_defaults setObject:cityName forKey:pfCurrentCityKey];
    }
}

- (void)clearCurrentlySelectedCity
{
    [_defaults setObject:nil forKey:pfCurrentCityKey];
}


- (NSString*)getCurrentlySelectedCity
{
    return [_defaults objectForKey:pfCurrentCityKey];
}

@end
