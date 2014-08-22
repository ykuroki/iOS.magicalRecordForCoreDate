//
//  User.h
//  coredata
//
//  Created by Yuki Kuroki on 2014/08/21.
//  Copyright (c) 2014年 YUKI KUROKI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;

@end
