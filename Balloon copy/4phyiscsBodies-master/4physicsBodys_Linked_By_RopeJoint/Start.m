//
//  Start.m
//  BalloonGame
//
//  Created by Edgar Castro on 5/11/14.
//  Copyright (c) 2014 YuryGitman. All rights reserved.
//

#import "Start.h"
#import "MyScene.h"

@implementation Start{
    
    SKLabelNode *_startLabel;
    SKLabelNode *_tapLabel;
}





-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        
        
        //adding background image
        SKSpriteNode *bg =
        [SKSpriteNode spriteNodeWithImageNamed:@"background2.png"];
        
        bg.position =
        CGPointMake(self.size.width/2, self.size.height/2);
        
        [self addChild:bg];
        
        
        self.scaleMode = SKSceneScaleModeAspectFit;

        
        
        _startLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _startLabel.name = @"start";
        _startLabel.fontSize = 40.0f;
        _startLabel.fontColor = [SKColor whiteColor];
        _startLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        _startLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        _startLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        _startLabel.text = @"Tap to begin";
        
//        _tapLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
//        _tapLabel.name = @"tapScreen";
//        _tapLabel.fontSize = 20.0f;
//        _tapLabel.fontColor = [SKColor whiteColor];
//        _tapLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
//        _tapLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
//        _tapLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 55);
//        _tapLabel.text = @"Tap Screen To Start";
        
        [self addChild:_startLabel];
        //[self addChild:_tapLabel];

        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"start"]) {
        
        SKTransition *reveal = [SKTransition fadeWithDuration:3];
        
        MyScene *scene = [MyScene sceneWithSize:self.view.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition:reveal];
    }
}

@end
