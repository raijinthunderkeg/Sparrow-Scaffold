//
//  Media.h
//  Stars
//
//  Created by macmini1 on 20.01.14.
//  Copyright (c) 2014 easylab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Sparrow-Framework/Sparrow.h>
@interface Media : NSObject
+ (void) initAtlas;
+ (void) releaseAtlas;

+ (SPTexture *)atlasTexture:(NSString *)name;
+ (NSArray *)atlasTexturesWithPrefix:(NSString*)prefix;

+ (void) initSound;
+ (void) releaseSound;

+ (SPSoundChannel *)soundChannel:(NSString *)soundName;
+ (void)playSound:(NSString*)soundName;
@end
