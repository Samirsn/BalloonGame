//
//  MyScene.m
//  4physicsBodys_Linked_By_RopeJoint
//
//  Created by YG on 2/17/14.
//  Copyright (c) 2014 YuryGitman. All rights reserved.
//


#import "MyScene.h"
//#import "SKSpriteNode+DebugDraw.h"
#import "SKTAudio.h"
#import "SKTUtils.h"

#define ARC4RANDOM_MAX 0x100000000
static inline CGFloat ScalarRandomRange(CGFloat min, CGFloat max) {
    return floorf(((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min);
}

//enumeration
typedef NS_OPTIONS(uint32_t, CNPhysicsCategory)
{
    CNPhysicsCategoryBalloon    = 1 << 0,  // 0001 = 1
    CNPhysicsCategoryAvoid  = 1 << 1,  // 0010 = 2
    
    CNPhysicsCategoryCoin    = 1 << 2,  // 0100 = 4
    
    CNPhysicsCategoryDetach   = 1 << 3,  // 1000 = 8
    
    CNPhysicsCategoryLabel   = 1 << 4,  // 10000 = 16
    CNPhysicsCategorySpring   = 1 << 5,  // 100000 = 32
    CNPhysicsCategoryHook   = 1 << 6,  // 1000000 = 64
    
};

@interface MyScene()<SKPhysicsContactDelegate>
@property SKSpriteNode* myCircle;
@property SKSpriteNode* mySquare2;
@property SKSpriteNode* mySquare3;
@property SKSpriteNode* mySquare4;
@property SKSpriteNode* mySquare5;
@property SKSpriteNode* mySquare6;
@property SKSpriteNode* mySquare7;
@property SKSpriteNode* mySquare8;

//@property SKSpriteNode* myWallLeft;
//@property SKSpriteNode* myWallR;
//@property SKSpriteNode* myWallB;


@property SKSpriteNode* myAvoid;

@property SKSpriteNode* myAvoid1;

@property SKSpriteNode* myCoin;

@property SKSpriteNode* myDetach;




//@property SKSpriteNode* myShelf;
//@property SKSpriteNode* myShelf1;

@property SKPhysicsJointPin* myRopeJoint;
@property SKPhysicsJointPin* myRopeJoint1;
@property SKPhysicsJointPin* myRopeJoint2;
@property SKPhysicsJointPin* myRopeJoint3;
@property SKPhysicsJointPin* myRopeJoint4;
@property SKPhysicsJointPin* myRopeJoint5;
@property SKPhysicsJointPin* myRopeJoint6;
@end

@implementation MyScene{
    SKNode *_hudLayerNode;
    SKAction *_scoreFlashAction;
    
    SKLabelNode *_playerHealthLabel;
    NSString *_healthBar;
    
    float testHealth;
    float scoreValue;
    
    SKLabelNode *_scoreLabel;
    
    NSTimeInterval _dt;
    NSTimeInterval _lastUpdateTime;
    CGVector _windForce;
    BOOL _blowing;
    NSTimeInterval _timeUntilSwitchWindDirection;
    
    
    SKLabelNode *_gameOverLabel;
    SKLabelNode *_tapScreenLabel;
    int _gameState;
}


- (void)setupSceneLayers {
    _hudLayerNode = [SKNode node];
    [self addChild:_hudLayerNode];
}


-(void) activateJointRope{
    
    
    _myRopeJoint = [SKPhysicsJointPin jointWithBodyA:_myCircle.physicsBody bodyB:_mySquare2.physicsBody anchor:_myCircle.position];
    
    [self.physicsWorld addJoint:_myRopeJoint];
    
    _myRopeJoint1 = [SKPhysicsJointPin jointWithBodyA:_mySquare2.physicsBody bodyB:_mySquare3.physicsBody anchor:_mySquare2.position];
    
    [self.physicsWorld addJoint:_myRopeJoint1];
    
    _myRopeJoint2 = [SKPhysicsJointPin jointWithBodyA:_mySquare3.physicsBody bodyB:_mySquare4.physicsBody anchor:_mySquare3.position];
    
    [self.physicsWorld addJoint:_myRopeJoint2];
    
    _myRopeJoint3 = [SKPhysicsJointPin jointWithBodyA:_mySquare4.physicsBody bodyB:_mySquare5.physicsBody anchor:_mySquare4.position];
    
    [self.physicsWorld addJoint:_myRopeJoint3];
    
    _myRopeJoint4 = [SKPhysicsJointPin jointWithBodyA:_mySquare5.physicsBody bodyB:_mySquare6.physicsBody anchor:_mySquare5.position];
    
    [self.physicsWorld addJoint:_myRopeJoint4];
    
    _myRopeJoint5 = [SKPhysicsJointPin jointWithBodyA:_mySquare6.physicsBody bodyB:_mySquare7.physicsBody anchor:_mySquare6.position];
    
    [self.physicsWorld addJoint:_myRopeJoint5];
    
    _myRopeJoint6 = [SKPhysicsJointPin jointWithBodyA:_mySquare7.physicsBody bodyB:_mySquare8.physicsBody anchor:_mySquare7.position];
    
    [self.physicsWorld addJoint:_myRopeJoint6];
    
    
    
    //    _myRopeJoint = [SKPhysicsJointLimit jointWithBodyA:_mySquare1.physicsBody bodyB:_mySquare2.physicsBody anchorA:_mySquare1.position anchorB:_mySquare2.position];
    //
    //
    //    [self.physicsWorld addJoint:_myRopeJoint];
    //
    //    _myRopeJoint1 = [SKPhysicsJointLimit jointWithBodyA:_mySquare2.physicsBody bodyB:_mySquare3.physicsBody anchorA:_mySquare2.position anchorB:_mySquare3.position];
    //
    //    [self.physicsWorld addJoint:_myRopeJoint1];
    //
    //
    //    _myRopeJoint2 = [SKPhysicsJointLimit jointWithBodyA:_mySquare3.physicsBody bodyB:_mySquare4.physicsBody anchorA:_mySquare3.position anchorB:_mySquare4.position];
    //
    //    [self.physicsWorld addJoint:_myRopeJoint2];
    //
    //
    //    _myRopeJoint3 = [SKPhysicsJointLimit jointWithBodyA:_mySquare4.physicsBody bodyB:_mySquare5.physicsBody anchorA:_mySquare4.position anchorB:_mySquare5.position];
    //
    //    [self.physicsWorld addJoint:_myRopeJoint3];
    //
    //    _myRopeJoint4 = [SKPhysicsJointLimit jointWithBodyA:_mySquare5.physicsBody bodyB:_mySquare6.physicsBody anchorA:_mySquare5.position anchorB:_mySquare6.position];
    //
    //    [self.physicsWorld addJoint:_myRopeJoint4];
    //
    //    _myRopeJoint5 = [SKPhysicsJointLimit jointWithBodyA:_mySquare6.physicsBody bodyB:_mySquare7.physicsBody anchorA:_mySquare6.position anchorB:_mySquare6.position];
    //
    //    [self.physicsWorld addJoint:_myRopeJoint5];
    //
    //    _myRopeJoint6 = [SKPhysicsJointLimit jointWithBodyA:_mySquare7.physicsBody bodyB:_mySquare8.physicsBody anchorA:_mySquare7.position anchorB:_mySquare8.position];
    //
    //    [self.physicsWorld addJoint:_myRopeJoint6];
}


-(void) spawnSquares{
    
    
    _myCircle = [SKSpriteNode spriteNodeWithImageNamed:@"balloon.png"];
    
    _myCircle.zPosition = 0;
    _mySquare2.zPosition = 0;
    _mySquare3.zPosition = 0;
    _mySquare4.zPosition = 0;
    _mySquare5.zPosition = 0;
    _mySquare6.zPosition = 0;
    _mySquare7.zPosition = 0;
    _mySquare8.zPosition = 0;
    
    
    
    //    _myCircle = [[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(25, 25)];
    //    _myCircle.alpha =0.8;
    
    _mySquare2 =[[SKSpriteNode alloc]initWithColor:[SKColor whiteColor] size:CGSizeMake(3, 15)];
    _mySquare2.alpha =0.7;
    
    _mySquare3 =[[SKSpriteNode alloc]initWithColor:[SKColor whiteColor] size:CGSizeMake(3, 15)];
    _mySquare3.alpha =.6;
    
    _mySquare4 =[[SKSpriteNode alloc]initWithColor:[SKColor whiteColor] size:CGSizeMake(3, 15)];
    _mySquare4.alpha =0.5;
    
    _mySquare5 =[[SKSpriteNode alloc]initWithColor:[SKColor whiteColor] size:CGSizeMake(3,15)];
    _mySquare5.alpha =0.4;
    
    _mySquare6 =[[SKSpriteNode alloc]initWithColor:[SKColor whiteColor] size:CGSizeMake(3,15)];
    _mySquare6.alpha =0.3;
    
    _mySquare7 =[[SKSpriteNode alloc]initWithColor:[SKColor whiteColor] size:CGSizeMake(3 ,15)];
    _mySquare7.alpha =0.2;
    
    _mySquare8 =[[SKSpriteNode alloc]initWithColor:[SKColor whiteColor] size:CGSizeMake(3, 15)];
    _mySquare8.alpha =0.1;
    
    
    [_myCircle setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.5)];
    [_mySquare2 setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.6)];
    [_mySquare3 setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.7)];
    [_mySquare4 setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.8)];
    [_mySquare5 setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.9)];
    [_mySquare6 setPosition:CGPointMake(self.size.width/1.5, self.size.height/2)];
    [_mySquare7 setPosition:CGPointMake(self.size.width/1.5, self.size.height/2.1)];
    [_mySquare8 setPosition:CGPointMake(self.size.width/1.5, self.size.height/2.2)];
    
    /*[_myCircle setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.5)];
     [_mySquare2 setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.6)];
     [_mySquare3 setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.7)];
     [_mySquare4 setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.8)];
     [_mySquare5 setPosition:CGPointMake(self.size.width/1.5, self.size.height/1.9)];
     [_mySquare6 setPosition:CGPointMake(self.size.width/1.5, self.size.height/2)];
     [_mySquare7 setPosition:CGPointMake(self.size.width/1.5, self.size.height/2.1)];
     [_mySquare8 setPosition:CGPointMake(self.size.width/1.5, self.size.height/2.2)];*/
    //[_mySquare8 setPosition:CGPointMake(200, 203)];
    
    _myCircle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myCircle.size];
    _mySquare2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare2.size];
    _mySquare3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare3.size];
    _mySquare4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare4.size];
    _mySquare5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare5.size];
    _mySquare6.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare6.size];
    _mySquare7.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare7.size];
    _mySquare8.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare8.size];
    //_mySquare8.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
    
    [_myCircle.physicsBody setRestitution:.5];
    //[_myCircle.physicsBody setVelocity:CGVectorMake(0, _myCircle.position.y +.05)];
    [_mySquare2.physicsBody setRestitution:0];
    [_mySquare3.physicsBody setRestitution:0];
    [_mySquare4.physicsBody setRestitution:0];
    [_mySquare5.physicsBody setRestitution:0];
    [_mySquare6.physicsBody setRestitution:0];
    [_mySquare7.physicsBody setRestitution:0];
    [_mySquare8.physicsBody setRestitution:0];
    
    
    [self addChild:_myCircle];
    [self addChild:_mySquare2];
    [self addChild:_mySquare3];
    [self addChild:_mySquare4];
    [self addChild:_mySquare5];
    [self addChild:_mySquare6];
    [self addChild:_mySquare7];
    [self addChild:_mySquare8];
    
    _myCircle.physicsBody.categoryBitMask = CNPhysicsCategoryBalloon;
    _mySquare2.physicsBody.categoryBitMask = CNPhysicsCategoryBalloon;
    _mySquare3.physicsBody.categoryBitMask = CNPhysicsCategoryBalloon;
    _mySquare4.physicsBody.categoryBitMask = CNPhysicsCategoryBalloon;
    _mySquare5.physicsBody.categoryBitMask = CNPhysicsCategoryBalloon;
    _mySquare6.physicsBody.categoryBitMask = CNPhysicsCategoryBalloon;
    _mySquare7.physicsBody.categoryBitMask = CNPhysicsCategoryBalloon;
    _mySquare8.physicsBody.categoryBitMask = CNPhysicsCategoryBalloon;
    
    _myCircle.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryCoin | CNPhysicsCategoryDetach;
    _mySquare2.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryCoin | CNPhysicsCategoryDetach;
    _mySquare3.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryCoin | CNPhysicsCategoryDetach;
    _mySquare4.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryCoin | CNPhysicsCategoryDetach;
    _mySquare5.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryCoin | CNPhysicsCategoryDetach;
    _mySquare6.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryCoin | CNPhysicsCategoryDetach;
    _mySquare7.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryCoin | CNPhysicsCategoryDetach;
    _mySquare8.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryCoin | CNPhysicsCategoryDetach;
    
    
    
}

//-(void)makeShelf{
//    _myShelf = [[SKSpriteNode alloc]initWithColor:[SKColor lightGrayColor] size:CGSizeMake(50, 20)];
//    _myShelf.position = CGPointMake(100, 400);
//    _myShelf.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myShelf.size];
//    [_myShelf.physicsBody setDynamic:NO];
//
//    [self addChild:_myShelf];
//
//    _myShelf1 = [[SKSpriteNode alloc]initWithColor:[SKColor lightGrayColor] size:CGSizeMake(50, 20)];
//    _myShelf1.position = CGPointMake(100, 300);
//    _myShelf1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myShelf1.size];
//    [_myShelf1.physicsBody setDynamic:NO];
//
//    [self addChild:_myShelf1];
//
//
//}



-(void)makeAvoid{
    
    _myAvoid = [SKSpriteNode spriteNodeWithImageNamed:@"avoid.png"];
    
    //_myAvoid = [[SKSpriteNode alloc]initWithColor:[SKColor yellowColor] size:CGSizeMake(50, 50)];
    _myAvoid.position = CGPointMake(ScalarRandomRange(15,300), 600);
    _myAvoid.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myAvoid.size];
    [_myAvoid.physicsBody setDynamic:YES];
    
    _myAvoid.physicsBody.categoryBitMask = CNPhysicsCategoryAvoid;
    _myAvoid.physicsBody.collisionBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryBalloon | CNPhysicsCategoryDetach;
    
    [self addChild:_myAvoid];
    
    _myAvoid1 = [SKSpriteNode spriteNodeWithImageNamed:@"avoid.png"];
    
    //_myAvoid1 = [[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(20, 20)];
    _myAvoid1.position = CGPointMake(ScalarRandomRange(15,300), 600);
    _myAvoid1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myAvoid1.size];
    [_myAvoid1.physicsBody setDynamic:YES];
    
    _myAvoid1.physicsBody.categoryBitMask = CNPhysicsCategoryAvoid;
    _myAvoid1.physicsBody.collisionBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryBalloon | CNPhysicsCategoryDetach;
    
    [self addChild:_myAvoid1];
    NSLog(@"avoid 1 here!!");
    
}

-(void)makeAvoid1{
    
    _myAvoid = [SKSpriteNode spriteNodeWithImageNamed:@"avoid.png"];
    
    //_myAvoid = [[SKSpriteNode alloc]initWithColor:[SKColor yellowColor] size:CGSizeMake(20, 20)];
    _myAvoid.position = CGPointMake(ScalarRandomRange(15,300), ScalarRandomRange(600,900));
    _myAvoid.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myAvoid.size];
    [_myAvoid.physicsBody setDynamic:YES];
    
    _myAvoid.physicsBody.categoryBitMask = CNPhysicsCategoryAvoid;
    _myAvoid.physicsBody.collisionBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryBalloon | CNPhysicsCategoryDetach;
    
    [self addChild:_myAvoid];
    
    _myAvoid1 = [SKSpriteNode spriteNodeWithImageNamed:@"avoid.png"];
    
    //_myAvoid1 = [[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(20, 20)];
    _myAvoid1.position = CGPointMake(ScalarRandomRange(15,300), ScalarRandomRange(600,900));
    _myAvoid1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myAvoid1.size];
    [_myAvoid1.physicsBody setDynamic:YES];
    
    _myAvoid1.physicsBody.categoryBitMask = CNPhysicsCategoryAvoid;
    _myAvoid1.physicsBody.collisionBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryBalloon | CNPhysicsCategoryDetach;
    
    [self addChild:_myAvoid1];
    NSLog(@"avoid 1 here!!");
    
}


-(void) makeCoins{
    _myCoin = [SKSpriteNode spriteNodeWithImageNamed:@"coin.png"];
    
    //_myCoin = [[SKSpriteNode alloc]initWithColor: [SKColor blackColor] size:CGSizeMake(25,25)];
    _myCoin.position = CGPointMake(ScalarRandomRange(15,300), 600);
    _myCoin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myCoin.size];
    [_myCoin.physicsBody setDynamic:YES];
    
    _myCoin.physicsBody.categoryBitMask = CNPhysicsCategoryCoin;
    _myCoin.physicsBody.collisionBitMask = CNPhysicsCategoryBalloon;
    
    [self addChild:_myCoin];
    NSLog(@"Coin here!!!");
    
    
}


-(void) makeDetach{
    
    _myDetach= [SKSpriteNode spriteNodeWithImageNamed:@"bubble.png"];
    
    // _myDetach = [[SKSpriteNode alloc]initWithColor: [SKColor greenColor] size:CGSizeMake(25,25)];
    _myDetach.position = CGPointMake(ScalarRandomRange(15,300), -100);
    _myDetach.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myCoin.size];
    [_myDetach.physicsBody setDynamic:YES];
    //[_myDetach.physicsBody setVelocity:CGVectorMake(0, 100)];
    
    _myDetach.physicsBody.categoryBitMask = CNPhysicsCategoryDetach;
    _myDetach.physicsBody.collisionBitMask = CNPhysicsCategoryBalloon;
    
    [self addChild:_myDetach];
    
}

//-(void)makeWall{
//        _myWallLeft = [[SKSpriteNode alloc]initWithColor:[SKColor lightGrayColor] size:CGSizeMake(10, 1150)];
//        _myWallLeft.position = CGPointMake(10, 0);
//        _myWallLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myWallLeft.size];
//        [_myWallLeft.physicsBody setDynamic:NO];
//
//        [self addChild:_myWallLeft];
//
//    _myWallR = [[SKSpriteNode alloc]initWithColor:[SKColor lightGrayColor] size:CGSizeMake(10, 1150)];
//    _myWallR.position = CGPointMake(315, 0);
//    _myWallR.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myWallR.size];
//    [_myWallR.physicsBody setDynamic:NO];
//
//    [self addChild:_myWallR];

//}



- (void)setupUI {
    int barHeight = 45;
    CGSize backgroundSize = CGSizeMake(self.size.width, barHeight);
    
    
    SKColor *backgroundColor =
    [SKColor colorWithRed:0 green:0 blue:0.05 alpha:1.0];
    SKSpriteNode *hudBarBackground =
    [SKSpriteNode spriteNodeWithColor:backgroundColor
                                 size:backgroundSize];
    hudBarBackground.position =
    CGPointMake(0, self.size.height - barHeight);
    hudBarBackground.anchorPoint = CGPointZero;
    [_hudLayerNode addChild:hudBarBackground];
    
    // 1
    _scoreLabel =
    [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    // 2
    _scoreLabel.fontSize = 20.0;
    // scoreLabel.text = @"%f", scoreValue;
    
    //    _scoreLabel.text = [NSString stringWithFormat: @"%f", scoreValue];
    //    _scoreLabel.name = @"scoreLabel";
    // 3
    _scoreLabel.verticalAlignmentMode =
    SKLabelVerticalAlignmentModeCenter;
    // 4
    _scoreLabel.position = CGPointMake(self.size.width / 2,
                                       self.size.height - _scoreLabel.frame.size.height -20);
    // 5
    [_hudLayerNode addChild:_scoreLabel];
    
    
    //makes the score flash
    _scoreFlashAction = [SKAction sequence:
                         @[[SKAction scaleTo:1.5 duration:0.1],
                           [SKAction scaleTo:1.0 duration:0.1]]];
    
    [_scoreLabel runAction:[SKAction repeatAction:_scoreFlashAction count:10]];
    
    
    
    
    scoreValue = 0;
    // 1
    _healthBar = @"===================================================";
    testHealth = 100;
    //    NSString * actualHealth = [_healthBar substringToIndex:
    //                               (testHealth / 100 * _healthBar.length)];
    // 2
    SKLabelNode *playerHealthBackground =
    [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    playerHealthBackground.name = @"playerHealthBackground";
    playerHealthBackground.fontColor = [SKColor darkGrayColor];
    playerHealthBackground.fontSize = 10.65f;
    playerHealthBackground.text = _healthBar;
    
    // 3
    playerHealthBackground.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    playerHealthBackground.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    playerHealthBackground.position = CGPointMake(0,
                                                  self.size.height - barHeight + playerHealthBackground.frame.size.height);
    [_hudLayerNode addChild:playerHealthBackground];
    
    // 4
    _playerHealthLabel =
    [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    _playerHealthLabel.name = @"playerHealth";
    _playerHealthLabel.fontColor = [SKColor greenColor];
    _playerHealthLabel.fontSize = 10.65f;
    //  _playerHealthLabel.text = actualHealth;
    _playerHealthLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    _playerHealthLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    _playerHealthLabel.position = CGPointMake(0, self.size.height - barHeight + playerHealthBackground.frame.size.height);
    [_hudLayerNode addChild:_playerHealthLabel];
    _playerHealthLabel.zPosition =1;
    
    
    
    ///
    
    
    _gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    _gameOverLabel.name = @"gameOver";
    _gameOverLabel.fontSize = 40.0f;
    _gameOverLabel.fontColor = [SKColor whiteColor];
    _gameOverLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    _gameOverLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    _gameOverLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _gameOverLabel.text = @"GAME OVER";
    
    _tapScreenLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    _tapScreenLabel.name = @"tapScreen";
    _tapScreenLabel.fontSize = 20.0f;
    _tapScreenLabel.fontColor = [SKColor whiteColor];
    _tapScreenLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    _tapScreenLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    _tapScreenLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 55);
    _tapScreenLabel.text = @"Tap Screen To Restart";
    
    
    
    
    hudBarBackground.zPosition =1;
    playerHealthBackground.zPosition = 1;
    
    
    
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
        
        
        //adding score label
        //        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        //
        //        myLabel.text = @"Score:";
        //        myLabel.fontSize = 30;
        //        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
        //                                       CGRectGetMidY(self.frame));
        //
        //        myLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        //
        //        [self addChild:myLabel];
        
        
        
        
        self.scaleMode = SKSceneScaleModeAspectFit;
        // self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        [self.physicsBody setRestitution:1];
        // [self.physicsBody setVelocity:CGVectorMake(0, -5)];
        
        
        
        [self spawnSquares];
        
        [self activateJointRope];
        
        //       [self makeShelf];
        
        
        //   [self makeWall];
        
        [self makeAvoid];
        [self makeCoins];
        [self makeDetach];
        
        
        self.physicsWorld.gravity = CGVectorMake(0, -1);
        
        //self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.contactDelegate = self;
        //self.physicsBody.categoryBitMask = CNPhysicsCategoryEdge;
        
        [[SKTAudio sharedInstance] playBackgroundMusic:@"BalloonSong.mp3"];
        
        
        [self setupSceneLayers];
        
        [self setupUI];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if (_mySquare8.position.x < location.x + 50 && _mySquare8.position.x > location.x - 50 &&
            
            _mySquare8.position.y < location.y + 50 && _mySquare8.position.y > location.y - 50) {
            
            if (_mySquare8.physicsBody.dynamic) {
                
                [_mySquare8.physicsBody setDynamic:NO];
                
                //                    _myCircle.color = [SKColor blueColor];
                //                    _mySquare2.color = [SKColor grayColor];
                //                    _mySquare3.color = [SKColor grayColor];
                //                    _mySquare4.color = [SKColor grayColor];
                //                    _mySquare5.color = [SKColor grayColor];
                //                    _mySquare6.color = [SKColor grayColor];
                //                    _mySquare7.color = [SKColor grayColor];
                //                    _mySquare8.color = [SKColor grayColor];
                
                
            }
            
            areWeTouchingAString = YES;
            
        }
        
    }
    
    if (_gameState == GameOver){
        [self restartGame];
    }
    
    
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if (areWeTouchingAString == YES) //
        {
            [_mySquare8 setPosition:CGPointMake(location.x, location.y)];
            _myCircle.color = [SKColor purpleColor];
        }
        
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {
    
    areWeTouchingAString = NO;
    
    if (!_mySquare8.physicsBody.dynamic) {
        [_mySquare8.physicsBody setDynamic:YES];
    }
    //  [_mySquare1.physicsBody setDynamic:YES];
    //  [_mySquare2.physicsBody setDynamic:YES];
    _myCircle.color = [SKColor greenColor];
    _mySquare2.color = [SKColor whiteColor];
    _mySquare3.color = [SKColor whiteColor];
    _mySquare4.color = [SKColor whiteColor];
    _mySquare5.color = [SKColor whiteColor];
    _mySquare6.color = [SKColor whiteColor];
    _mySquare7.color = [SKColor whiteColor];
    _mySquare8.color = [SKColor whiteColor];
    
    
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (!_mySquare8.physicsBody.dynamic) {
        [_mySquare8.physicsBody setDynamic:YES];
    }
    //  [_mySquare1.physicsBody setDynamic:YES];
    //  [_mySquare2.physicsBody setDynamic:YES];
    
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    [_myCircle.physicsBody setVelocity:CGVectorMake(0,100)];
    
    [_myDetach.physicsBody setVelocity:CGVectorMake(0, 100)];
    
    
    
    switch (_gameState) {
        case GameRunning:
        {
            
            
            //    //wind
            //    if (_lastUpdateTime) {
            //        _dt = currentTime - _lastUpdateTime;
            //    } else {
            //        _dt = 0;
            //    }
            //    _lastUpdateTime = currentTime;
            //    _timeUntilSwitchWindDirection -= _dt;
            //    if (_timeUntilSwitchWindDirection <= 0) {
            //        _timeUntilSwitchWindDirection = ScalarRandomRange(5, 7);
            //        _windForce = CGVectorMake(ScalarRandomRange(-.1,.1), -2);
            //
            //        NSLog(@"Wind force: %0.2f, %0.2f",
            //              _windForce.dx, _windForce.dy); }
            //
            //    for (SKSpriteNode *node in self.children) {
            //        [node.physicsBody applyForce:_windForce];
            //    }
            
            //FOR THE AVOID SQUARE
            if (_myAvoid.position.y < -100) {
                _myAvoid.position = CGPointMake(ScalarRandomRange(15,300), 600);
                _myAvoid.physicsBody.velocity = CGVectorMake(0, 0);
            }
            
            
            //FOR THE AVOID SQUARE
            if (_myAvoid1.position.y < -150) {
                _myAvoid1.position = CGPointMake(ScalarRandomRange(15,300), 600);
                _myAvoid1.physicsBody.velocity = CGVectorMake(0, 0);
            }
            
            if (_myCoin.position.y < -170) {
                _myCoin.position = CGPointMake(ScalarRandomRange(15,300), 600);
                _myCoin.physicsBody.velocity = CGVectorMake(0, 0);
            }
            
            if (_myDetach.position.y > 500) {
                //_myDetach.position = CGPointMake(200, -30);
                _myDetach.position = CGPointMake(ScalarRandomRange(15,300), -100);
                _myDetach.physicsBody.velocity = CGVectorMake(0, 0);
            }
            
            
            
            
            NSString * actualHealth = [_healthBar substringToIndex:
                                       (testHealth / 100 * _healthBar.length)];
            
            _playerHealthLabel.text = actualHealth;
            
            _scoreLabel.text = [NSString stringWithFormat: @"Score: %.0f", scoreValue];
            _scoreLabel.name = @"scoreLabel";
            _scoreLabel.zPosition =1;
            
            if (testHealth <= 0 | _myCircle.position.y > 630) {
                _gameState = GameOver;
            }
            
            
            
        }
            break;
        case GameOver:
        {
            if (!_gameOverLabel.parent) {
                [_myCircle removeFromParent];
                [_mySquare2 removeFromParent];
                [_mySquare3 removeFromParent];
                [_mySquare4 removeFromParent];
                [_mySquare5 removeFromParent];
                [_mySquare6 removeFromParent];
                [_mySquare7 removeFromParent];
                [_mySquare8 removeFromParent];
                
                
                
                
                
                [_hudLayerNode addChild:_gameOverLabel];
                [_hudLayerNode addChild:_tapScreenLabel];
            }
            
            
            
            
            
        }
            
    }
}

-(void)restartGame{
    
    // Reset the state of the game
    _gameState = GameRunning;
    
    // Set up the entities again and the score
    [self spawnSquares];
    [self activateJointRope];
    
    
    scoreValue = 0;
    
    // Reset the score and the players health
    SKLabelNode *scoreLabel = (SKLabelNode *)[_hudLayerNode childNodeWithName:@"scoreLabel"];
    scoreLabel.text = @"Score: 0";
    testHealth = 100;
    
    
    // Remove the game over HUD labels
    [[_hudLayerNode childNodeWithName:@"gameOver"] removeFromParent];
    [[_hudLayerNode childNodeWithName:@"tapScreen"] removeAllActions];
    [[_hudLayerNode childNodeWithName:@"tapScreen"] removeFromParent];
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    
    if(collision == (CNPhysicsCategoryBalloon|CNPhysicsCategoryAvoid))
    {
        NSLog(@"FAIL");
        [self runAction:[SKAction playSoundFileNamed:@"pop.mp3" waitForCompletion:NO]];
        testHealth --;
        
        //        _mySquare2.color = [SKColor blackColor];
        //        _mySquare3.color = [SKColor blackColor];
        //        _mySquare4.color = [SKColor blackColor];
        //        _mySquare5.color = [SKColor blackColor];
        //        _mySquare6.color = [SKColor blackColor];
        //        _mySquare7.color = [SKColor blackColor];
        //        _mySquare8.color = [SKColor blackColor];
    }
    else{
        NSLog(@"No longer touching.");
        //        _mySquare2.color = [SKColor grayColor];
        //        _mySquare3.color = [SKColor grayColor];
        //        _mySquare4.color = [SKColor grayColor];
        //        _mySquare5.color = [SKColor grayColor];
        //        _mySquare6.color = [SKColor grayColor];
        //        _mySquare7.color = [SKColor grayColor];
        //        _mySquare8.color = [SKColor grayColor];
    }
    
    
    if(collision == (CNPhysicsCategoryBalloon| CNPhysicsCategoryCoin))
        
    {
        [self runAction:[SKAction playSoundFileNamed:@"coin.wav" waitForCompletion:NO]];
        
        if (scoreValue >= 0 && scoreValue < 3) {
            [_myCoin removeFromParent];
            [self makeCoins];
        }
        if (scoreValue >= 3 && scoreValue < 45) {
            [_myCoin removeFromParent];
            [self makeCoins];
            [self makeAvoid1];
        }
        if (scoreValue >= 45 && scoreValue < 150) {
            [_myCoin removeFromParent];
            [self makeCoins];
            [self makeAvoid1];
            [self makeAvoid1];
        }
        if (scoreValue >= 150 && scoreValue < 300) {
            [_myCoin removeFromParent];
            [self makeCoins];
            [self makeAvoid1];
            [self makeAvoid1];
            [self makeAvoid1];
            
        }
        //        if (scoreValue > 6 && scoreValue < 14) {
        //            [_myCoin removeFromParent];
        //            [self makeCoins];
        //            [self makeAvoid1];
        //            [self makeAvoid1];
        //            [self makeAvoid1];
        //
        //        }
        //        if (scoreValue > 14 && scoreValue < 24) {
        //            [_myCoin removeFromParent];
        //            [self makeCoins];
        //            [self makeAvoid1];
        //            [self makeAvoid1];
        //            [self makeAvoid1];
        //            [self makeAvoid1];
        //
        //
        //        }
        //        if (scoreValue > 24 && scoreValue < 34) {
        //            [_myCoin removeFromParent];
        //            [self makeCoins];
        //            [self makeAvoid1];
        //            [self makeAvoid1];
        //            [self makeAvoid1];
        //            [self makeAvoid1];
        //            [self makeAvoid1];
        //
        //
        //
        //        }
        //        [_myCoin removeFromParent];
        //        [self makeCoins];
        
        NSLog(@"%f", scoreValue);
        //[self runAction:[SKAction playSoundFileNamed:@"pop.mp3" waitForCompletion:NO]];
        
        _myCoin.color = [SKColor redColor];
        scoreValue ++;
        
        
    }
    else{
        
        _myCoin.color = [SKColor blackColor];
    }
    
    
    
    if(collision == (CNPhysicsCategoryBalloon| CNPhysicsCategoryDetach))
        
    {
        [self runAction:[SKAction playSoundFileNamed:@"bubble.mp3" waitForCompletion:NO]];
        [_myDetach removeFromParent];
        [self makeDetach];
        
        NSLog(@"touch");
        [self runAction:[SKAction playSoundFileNamed:@"pop.mp3" waitForCompletion:NO]];
        
        areWeTouchingAString = NO;
        [_mySquare8.physicsBody setDynamic:YES];
        
        
    }
    
}

/*-(void)didEndContact:(SKPhysicsContact *)contact
 {
 uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
 
 if(collision ==! (CNPhysicsCategoryBalloon|CNPhysicsCategoryAvoid))
 {
 NSLog(@"No longer touching.");
 _mySquare2.color = [SKColor grayColor];
 _mySquare3.color = [SKColor grayColor];
 _mySquare4.color = [SKColor grayColor];
 _mySquare5.color = [SKColor grayColor];
 _mySquare6.color = [SKColor grayColor];
 _mySquare7.color = [SKColor grayColor];
 _mySquare8.color = [SKColor grayColor];
 }
 }*/

@end
