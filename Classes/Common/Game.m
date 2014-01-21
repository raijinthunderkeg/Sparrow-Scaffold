//
//  Game.m
//  Stars
//
//  Created by macmini1 on 20.01.14.
//  Copyright (c) 2014 easylab. All rights reserved.
//

#import "Game.h"
#import "Media.h"
@interface Game()
- (void) setup;
- (void) onImageTouched:(SPTouchEvent *)event;
- (void) onResize:(SPResizeEvent *) event;
@end

@implementation Game
{
    SPSprite *_contents;
}

- (id) init
{
    if ((self = [super init]))
    {
        [self setup];
    }
    return self;
}
- (void) dealloc
{
    [Media releaseAtlas];
    [Media releaseSound];
}
- (void)setup
{
    [SPAudioEngine start];
    
    [Media initAtlas];
    [Media initSound];
    
    _contents = [SPSprite sprite];
    [self addChild:_contents];
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"background.jpg"];
    [_contents addChild:background];
    
    NSString *text = @"To find out how to create your own game out of this scaffold, "
    @"have a look at the 'First Steps' section of the Sparrow website!";
    SPTextField *textField = [[SPTextField alloc] initWithWidth:280 height:80 text:text];
    textField.x = (background.width - textField.width) / 2;
    textField.y = (background.height / 2) - 135;
    [_contents addChild:textField];
    
    SPImage *image = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"sparrow"]];
    image.pivotX = (int)image.width  / 2;
    image.pivotY = (int)image.height / 2;
    image.x = background.width  / 2;
    image.y = background.height / 2 + 40;
    [_contents addChild:image];
    
    [self updateLocations];
    
    // play a sound when the image is touched
    [image addEventListener:@selector(onImageTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // and animate it a little
    SPTween *tween = [SPTween tweenWithTarget:image time:1.5 transition:SP_TRANSITION_EASE_IN_OUT];
    [tween animateProperty:@"y" targetValue:image.y + 30];
    [tween animateProperty:@"rotation" targetValue:0.1];
    tween.repeatCount = 0; // repeat indefinitely
    tween.reverse = YES;
    [Sparrow.juggler addObject:tween];
    [self addEventListener:@selector(onResize:) atObject:self forType:SP_EVENT_TYPE_RESIZE];
}

- (void)updateLocations
{
    int gameWidth  = Sparrow.stage.width;
    int gameHeight = Sparrow.stage.height;
    
    _contents.x = (int) (gameWidth  - _contents.width)  / 2;
    _contents.y = (int) (gameHeight - _contents.height) / 2;
}

- (void)onImageTouched:(SPTouchEvent *)event
{
    NSSet *touches = [event touchesWithTarget:self andPhase:SPTouchPhaseEnded];
    if ([touches anyObject]) [Media playSound:@"sound.caf"];
}

- (void)onResize:(SPResizeEvent *)event
{
    NSLog(@"new size: %.0fx%.0f (%@)", event.width, event.height,
          event.isPortrait ? @"portrait" : @"landscape");
    
    [self updateLocations];
}
@end