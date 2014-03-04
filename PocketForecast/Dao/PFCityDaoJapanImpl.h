//
//  PFCityDaoJapanImpl.h
//  PocketForecast
//
//  Created by Uchio KONDO on 2014/03/04.
//  Copyright (c) 2014年 typhoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFCityDao.h"

@interface PFCityDaoJapanImpl : NSObject <PFCityDao>
{
    NSUserDefaults* _defaults;
}
@end
