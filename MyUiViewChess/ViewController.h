//
//  ViewController.h
//  MyUiViewChess
//
//  Created by  Z on 05.04.17.
//  Copyright © 2017 ItStep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property  (strong) NSMutableArray<UIView *>    *views;
@property (strong)  NSMutableArray<UIView *>    *whiteCheckers;
@property (strong)  NSMutableArray<UIView *>    *redCheckers;

@property  BOOL    isColorChanged;
@property  UIInterfaceOrientation  orientationBefore;


@end

