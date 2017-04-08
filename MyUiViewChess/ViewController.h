//
//  ViewController.h
//  MyUiViewChess
//
//  Created by  Z on 05.04.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property  (strong,atomic, nonnull)  NSMutableArray<UIView *>    *views;
@property (strong, atomic, nonnull)  NSMutableArray<UIView *>    *whiteCheckers;
@property (strong, atomic, nonnull)  NSMutableArray<UIView *>    *redCheckers;
//@property (strong, atomic, nonnull)  NSMutableArray<UIView *>    *blackViews;

@property  BOOL    isColorChanged;
@property  UIInterfaceOrientation  orientationBefore;


-(void)swapXYInViews;

-(void)swapXYInCheckers;
-(void)addCheckers;
-(void)setAllViewResizingMask: (UIViewAutoresizing) ar;
-(void)setAllViewBlackToOther;




@end

