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

//enumeration
typedef NS_OPTIONS(uint32_t, CNPhysicsCategory)
{
    CNPhysicsCategoryBalloon    = 1 << 0,  // 0001 = 1
    CNPhysicsCategoryAvoid  = 1 << 1,  // 0010 = 2
    
    CNPhysicsCategoryBed    = 1 << 2,  // 0100 = 4
    CNPhysicsCategoryEdge   = 1 << 3,  // 1000 = 8
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

@property SKSpriteNode* myWallLeft;
@property SKSpriteNode* myWallR;
@property SKSpriteNode* myWallB;


@property SKSpriteNode* myAvoid;

@property SKSpriteNode* myAvoid1;




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

//    _myCircle = [[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(25, 25)];
//    _myCircle.alpha =0.8;

    _mySquare2 =[[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(3, 15)];
    _mySquare2.alpha =0.7;

    _mySquare3 =[[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(3, 15)];
    _mySquare3.alpha =.6;

    _mySquare4 =[[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(3, 15)];
    _mySquare4.alpha =0.5;

    _mySquare5 =[[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(3,15)];
    _mySquare5.alpha =0.4;

    _mySquare6 =[[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(3,15)];
    _mySquare6.alpha =0.3;

    _mySquare7 =[[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(3 ,15)];
    _mySquare7.alpha =0.2;

    _mySquare8 =[[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(3, 15)];
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
    
    _myCircle.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid;
    _mySquare2.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid;
    _mySquare3.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid;
    _mySquare4.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid;
    _mySquare5.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid;
    _mySquare6.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid;
    _mySquare7.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid;
    _mySquare8.physicsBody.contactTestBitMask = CNPhysicsCategoryAvoid;
    
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
    _myAvoid = [[SKSpriteNode alloc]initWithColor:[SKColor yellowColor] size:CGSizeMake(50, 50)];
    _myAvoid.position = CGPointMake(100, 300);
    _myAvoid.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myAvoid.size];
    [_myAvoid.physicsBody setDynamic:YES];
    
    _myAvoid.physicsBody.categoryBitMask = CNPhysicsCategoryAvoid;
    _myAvoid.physicsBody.collisionBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryBalloon | CNPhysicsCategoryEdge;

    [self addChild:_myAvoid];
    
    
    _myAvoid1 = [[SKSpriteNode alloc]initWithColor:[SKColor redColor] size:CGSizeMake(50, 50)];
    _myAvoid1.position = CGPointMake(100, 100);
    _myAvoid1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myAvoid1.size];
    [_myAvoid1.physicsBody setDynamic:YES];
    
    _myAvoid1.physicsBody.categoryBitMask = CNPhysicsCategoryAvoid;
    _myAvoid1.physicsBody.collisionBitMask = CNPhysicsCategoryAvoid | CNPhysicsCategoryBalloon | CNPhysicsCategoryEdge;
    
    [self addChild:_myAvoid1];

}
-(void)makeWall{
        _myWallLeft = [[SKSpriteNode alloc]initWithColor:[SKColor lightGrayColor] size:CGSizeMake(10, 1150)];
        _myWallLeft.position = CGPointMake(10, 0);
        _myWallLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myWallLeft.size];
        [_myWallLeft.physicsBody setDynamic:NO];
    
        [self addChild:_myWallLeft];
    
    _myWallR = [[SKSpriteNode alloc]initWithColor:[SKColor lightGrayColor] size:CGSizeMake(10, 1150)];
    _myWallR.position = CGPointMake(315, 0);
    _myWallR.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myWallR.size];
    [_myWallR.physicsBody setDynamic:NO];
    
    [self addChild:_myWallR];
    
//    _myWallB = [[SKSpriteNode alloc]initWithColor:[SKColor lightGrayColor] size:CGSizeMake(250, 10)];
//    _myWallB.position = CGPointMake(225, 200);
//    _myWallB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myWallR.size];
//    [_myWallB.physicsBody setDynamic:NO];
//    
//    [self addChild:_myWallB];
    }



- (void)setupUI {
    int barHeight = 45; CGSize
    backgroundSize =
    CGSizeMake(self.size.width, barHeight);
    
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
    SKLabelNode *scoreLabel =
    [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    // 2
    scoreLabel.fontSize = 20.0; scoreLabel.text = @"Score: 0"; scoreLabel.name = @"scoreLabel";
    // 3
    scoreLabel.verticalAlignmentMode =
    SKLabelVerticalAlignmentModeCenter;
    // 4
    scoreLabel.position = CGPointMake(self.size.width / 2,
                                      self.size.height - scoreLabel.frame.size.height + 3); // 5
    [_hudLayerNode addChild:scoreLabel];
    
   
    //makes the score flash
    _scoreFlashAction = [SKAction sequence:
  @[[SKAction scaleTo:1.5 duration:0.1],
    [SKAction scaleTo:1.0 duration:0.1]]];
    
    [scoreLabel runAction:[SKAction repeatAction:_scoreFlashAction count:10]];
    
    
    
    
    
    // 1
    _healthBar = @"===================================================";
    float testHealth = 70;
    NSString * actualHealth = [_healthBar substringToIndex:
                               (testHealth / 100 * _healthBar.length)];
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
    _playerHealthLabel.name = @"playerHealth"; _playerHealthLabel.fontColor = [SKColor whiteColor]; _playerHealthLabel.fontSize = 10.65f; _playerHealthLabel.text = actualHealth; _playerHealthLabel.horizontalAlignmentMode =
    SKLabelHorizontalAlignmentModeLeft; _playerHealthLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop; _playerHealthLabel.position =
    CGPointMake(0,
                self.size.height - barHeight +
                _playerHealthLabel.frame.size.height);
    [_hudLayerNode addChild:_playerHealthLabel];
    
    
    
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
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        myLabel.text = @"Score:";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        myLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        
        [self addChild:myLabel];
        
        
        
        
        self.scaleMode = SKSceneScaleModeAspectFit;
       // self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        [self.physicsBody setRestitution:1];
        
        
        [self spawnSquares];
        
        [self activateJointRope];
//       [self makeShelf];
     
        
        [self makeWall];
        
        [self makeAvoid];
        
        self.physicsWorld.gravity = CGVectorMake(0, 1);
        
        //self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.contactDelegate = self;
        self.physicsBody.categoryBitMask = CNPhysicsCategoryEdge;
        
        [[SKTAudio sharedInstance] playBackgroundMusic:@"bgMusic.mp3"];
        
       
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
                    
                    _myCircle.color = [SKColor blueColor];
                    _mySquare2.color = [SKColor grayColor];
                    _mySquare3.color = [SKColor grayColor];
                    _mySquare4.color = [SKColor grayColor];
                    _mySquare5.color = [SKColor grayColor];
                    _mySquare6.color = [SKColor grayColor];
                    _mySquare7.color = [SKColor grayColor];
                    _mySquare8.color = [SKColor grayColor];
                    
                    
                }
                
                areWeTouchingAString = YES;
               
            }
            else{

            }
    
        }
    
    
    
    
//    if (_mySquare8.physicsBody.dynamic) {
//        
//        [_mySquare8.physicsBody setDynamic:NO];
//        
//        
//        
//        
//        _myCircle.color = [SKColor blueColor];
//        _mySquare2.color = [SKColor grayColor];
//        _mySquare3.color = [SKColor grayColor];
//        _mySquare4.color = [SKColor grayColor];
//        _mySquare5.color = [SKColor grayColor];
//        _mySquare6.color = [SKColor grayColor];
//        _mySquare7.color = [SKColor grayColor];
//        _mySquare8.color = [SKColor grayColor];
//
//
//        
//    }
//    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        [_mySquare8 setPosition:CGPointMake(location.x, location.y)];
//        [_mySquare7 setPosition:CGPointMake(location.x, location.y+34)];
//        [_mySquare6 setPosition:CGPointMake(location.x, location.y+45)];
//        [_mySquare5 setPosition:CGPointMake(location.x, location.y+58)];
//        [_mySquare4 setPosition:CGPointMake(location.x, location.y+60)];
//        [_mySquare3 setPosition:CGPointMake(location.x, location.y+62)];
//        [_mySquare2 setPosition:CGPointMake(location.x, location.y+75)];
//        [_myCircle setPosition:CGPointMake(location.x, location.y+90)];
//
//
//        
//        
//    
//        // [_mySquare1.physicsBody setDynamic:NO];
//        //  [_mySquare2.physicsBody setDynamic:NO];
//        
//        
//        
//        
//    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if (areWeTouchingAString == YES) //
        {
            [_mySquare8 setPosition:CGPointMake(location.x, location.y)];
            _myCircle.color = [SKColor purpleColor];
        }

        
       
        //[_mySquare8 setPosition:location];
        
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
    
    //FOR THE AVOID SQUARE
    if (_myAvoid.position.y > 550) {
        _myAvoid.position = CGPointMake(200, -30);
        _myAvoid.physicsBody.velocity = CGVectorMake(0, 0);
    }
    
    
    //FOR THE AVOID SQUARE
    if (_myAvoid1.position.y > 550) {
        _myAvoid1.position = CGPointMake(80, -30);
        _myAvoid1.physicsBody.velocity = CGVectorMake(0, 0);
    }
    

}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    
    if(collision == (CNPhysicsCategoryBalloon|CNPhysicsCategoryAvoid))
    {
        NSLog(@"FAIL");
        [self runAction:[SKAction playSoundFileNamed:@"pop.mp3" waitForCompletion:NO]];
        
    
        _mySquare2.color = [SKColor blackColor];
        _mySquare3.color = [SKColor blackColor];
        _mySquare4.color = [SKColor blackColor];
        _mySquare5.color = [SKColor blackColor];
        _mySquare6.color = [SKColor blackColor];
        _mySquare7.color = [SKColor blackColor];
        _mySquare8.color = [SKColor blackColor];
    } else{
        NSLog(@"No longer touching.");
        _mySquare2.color = [SKColor grayColor];
        _mySquare3.color = [SKColor grayColor];
        _mySquare4.color = [SKColor grayColor];
        _mySquare5.color = [SKColor grayColor];
        _mySquare6.color = [SKColor grayColor];
        _mySquare7.color = [SKColor grayColor];
        _mySquare8.color = [SKColor grayColor];
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
