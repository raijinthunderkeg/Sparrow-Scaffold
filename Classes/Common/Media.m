//
//  Media.m
//  Stars
//
//  Created by macmini1 on 20.01.14.
//  Copyright (c) 2014 easylab. All rights reserved.
//

#import "Media.h"

@implementation Media
static SPTextureAtlas *atlas = NULL;
static NSMutableDictionary *sounds = NULL;

#pragma mark Texture Atlas

+ (void) initAtlas
{
    if(!atlas)
    {
        atlas = [[SPTextureAtlas alloc] initWithContentsOfFile:@"atlas.xml"];
    }
}
+(void)releaseAtlas
{
    atlas = nil;
}
+(SPTexture*)atlasTexture:(NSString *)name
{
    if(!atlas) [self initAtlas];
    return [atlas textureByName:name];
}
+(NSArray *)atlasTexturesWithPrefix:(NSString *)prefix
{
    if(!atlas) [self initAtlas];
    return [atlas texturesStartingWith:prefix];
}

#pragma mark Audio
+ (void)initSound
{
    if(sounds)return;
    [SPAudioEngine start];
    sounds = [[NSMutableDictionary alloc] init];
    
    NSString *soundDir = [[NSBundle mainBundle] resourcePath];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:soundDir];
    
    NSString *filename;
    while (filename = [dirEnum nextObject])
    {
        if ([[filename pathExtension] isEqualToString:@"caf"])
        {
            SPSound *sound = [[SPSound alloc] initWithContentsOfFile:filename];
            sounds[filename] = sound;
        }
    }
}
+ (void)releaseSound
{
    sounds = nil;
    [SPAudioEngine stop];
}
+ (void)playSound:(NSString *)soundName
{
    SPSound *sound = sounds[soundName];
    if (sound)
    {
        [sound play];
    }
    else
    {
        [[SPSound soundWithContentsOfFile:soundName] play];
    }
}
+ (SPSoundChannel*)soundChannel:(NSString *)soundName
{
    SPSound *sound = sounds[soundName];
    if(!sound)
    {
        sound = [SPSound soundWithContentsOfFile:soundName];
        
    }
    return [sound createChannel];
}
@end