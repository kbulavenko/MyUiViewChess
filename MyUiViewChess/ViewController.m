//
//  ViewController.m
//  MyUiViewChess
//
//  Created by  Z on 05.04.17.
//  Copyright © 2017 ItStep. All rights reserved.
//
/*
 Итак наконец-то мы начали изучать графику :) Надо тренироваться! Повышаем градус заданий :)
 
 Ученик
 
 1. В цикле создавайте квадратные UIView с черным фоном и расположите их в виде шахматной доски
 2. доска должна иметь столько клеток, как и настоящая шахматная
 
 Студент
 
 3. Доска должна быть вписана в максимально возможный квадрат, т.е. либо бока, либо верх или низ должны касаться границ экрана
 4. Применяя соответствующие маски сделайте так, чтобы когда устройство меняет ориентацию, то все клетки растягивались соответственно и ничего не вылетало за пределы экрана.
 
 Мастер
 5. При повороте устройства все черные клетки должны менять цвет :)
 6.Сделайте так, чтобы доска при поворотах всегда строго находилась по центру
 
 Супермен
 8. Поставьте белые и красные шашки (квадратные вьюхи) так как они стоят на доске. Они должны быть сабвьюхами главной вьюхи (у них и у клеток один супервью)
 9. После каждого переворота шашки должны быть перетасованы используя соответствующие методы иерархии UIView
 
 */


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize views, isColorChanged, orientationBefore, whiteCheckers, redCheckers;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.isColorChanged  = NO;
    self.views  = [NSMutableArray<UIView*>  array];
    self.orientationBefore= 505555;
    srand((unsigned int)time(NULL));
    CGRect   fr  = self.view.frame;
    CGFloat cellWidth  = fr.size.width / 8;
    CGFloat cellHeigh  = fr.size.height /8;
    CGFloat  startX = 0.0, startY = 0.0;
    if(cellWidth > cellHeigh)
    {
        startY = (fr.size.width - fr.size.height) /2;
        cellWidth = cellHeigh;
    }
    else
    {
        startX = (fr.size.height   - fr.size.width) /2;
        cellHeigh  = cellWidth;
    }
    NSInteger  count = 0;
    for(NSInteger   row = 0 ; row < 8; row++)
    {
        for (NSInteger column =  0; column < 8; column ++)
        {
            CGRect  cellFrame  =  CGRectMake(startY * 1 + column * cellHeigh, startX * 1 + row * cellWidth , cellWidth, cellHeigh);
            
            
            
            
            BOOL isBlack  = (row % 2 + column)%2;
            UIColor  *blackCellColor =  [[UIColor blackColor] colorWithAlphaComponent:0.8];
            UIColor  *brownCellColor  = [[UIColor brownColor] colorWithAlphaComponent:0.8];
            UIView  *v  = [[UIView alloc]  initWithFrame: cellFrame];
            v.backgroundColor  = (isBlack)? blackCellColor: brownCellColor;
            //v.layoutMargins
            UITextField   *tf   = [[UITextField alloc]  initWithFrame: CGRectMake(0, 0, 30, 20)];
            tf.text  =  [NSString  stringWithFormat:@"%li",(count++)];
            [v addSubview: tf];
            [self.view addSubview: v];
            [self.views addObject: v];
        }
    }
    
    [self addCheckers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillLayoutSubviews
{
   
    CGRect   r = self.views.firstObject.frame;
    
    NSLog(@"Frame = %@", NSStringFromCGRect(r));
    
    
    NSArray   *arr =@[
                      @"UIDeviceOrientationPortrait",
                      @"UIDeviceOrientationPortraitUpsideDown",
                      @"UIDeviceOrientationPortraitUpsideDown",
                      @"UIDeviceOrientationLandscapeLeft"
                      ];
    
    UIInterfaceOrientation  orientation  = [[UIApplication sharedApplication] statusBarOrientation];
    NSLog(@"viewWillLayoutSubviews orientation = %li:%li",orientation, [UIDevice currentDevice].orientation);
    NSLog(@"Orientation is \'%@\'", [arr objectAtIndex: orientation -1]);
    
    
    if(self.orientationBefore  == 505555)
    {
        self.orientationBefore  = orientation;
    }
    else
    {
        
       // NSLog(@"");
        if(orientation != self.orientationBefore)
        {
         //   NSLog(@"Перекрашиваем  черные (или места черных)");
            [self setAllViewBlackToOther];
        }
        
        if(self.orientationBefore >=3  && orientation <= 2)
        {
            
           // NSLog(@"Из горизонтального в вертикальное");
            [self swapXYInViews];
        }
        
        if(self.orientationBefore <=2  && orientation >= 3)
        {
           // NSLog(@"Из вертикального  в горизонтальное");
            [self swapXYInViews];
        }
        
        self.orientationBefore  = orientation;

        
    }
    
    
   //    switch (orientation) {
//        case 1:
//            [self setAllViewResizingMask: UIViewAutoresizingFlexibleLeftMargin];
//            
//            break;
//        case 2:
//            [self setAllViewResizingMask: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
//            break;
//        case 3:
//            [self setAllViewResizingMask: UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
//            break;
//        case 4:
//            [self setAllViewResizingMask: UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
//            break;
//            
//        default:
//            break;
//    }
}

-(void)setAllViewResizingMask: (UIViewAutoresizing) ar
{
    for (UIView *v in self.views)
    {
        v.autoresizingMask  = ar;
    }
        
}

-(void)setAllViewBlackToOther
{
  //  if(isColorChanged)   return;
    
    for(NSInteger   row = 0 ; row < 8; row++)
    {
        for (NSInteger column =  0; column < 8; column ++)
        {
            
            UIView *v  = [self.views objectAtIndex: row * 8 + column];
            if(v == nil) return;
            BOOL isBlack  = (row % 2 + column)%2;
            //v.backgroundColor  = (isBlack)? blackCellColor: brownCellColor;
            if(isBlack)
            {
                CGFloat   red   =  0.3 + (double)(rand() % 700)  / 1000.0;
                CGFloat   green =  0.2 + (double)(rand() % 700)  / 1000.0;
                CGFloat   blue  =  0.6 + (double)(rand() % 400)  / 1000.0;
                CGFloat   alpha =  0.7 + (double)(rand() % 200)  / 1000.0;
                v.backgroundColor  = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
            }
        }
    }
    self.isColorChanged  = YES;
}

- (UIInterfaceOrientationMask)   supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait |
    UIInterfaceOrientationMaskPortraitUpsideDown |
    UIInterfaceOrientationMaskLandscapeLeft *  1|
    UIInterfaceOrientationMaskLandscapeRight * 1;
}


- (BOOL)shouldAutorotate{
    //NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    return YES;
}

-(void)swapXYInViews
{
    for (UIView *v in self.views)
    {
        CGRect    fr  = v.frame;
        CGFloat  t =  fr.origin.x;
        fr.origin.x  = fr.origin.y;
        fr.origin.y  = t;
        v.frame  = fr;
        
    }
}


-(void)addCheckers
{
    //CGRect   fr   =  self.views.firstObject.frame;
    
    NSInteger  count  = 0;
    
    for (NSInteger i = 0; i < 12; i++)
    {
        
        count = 1 + i * 2 - ((i) / 4) % 2;
         NSLog(@"i = %li , count = %li",i , count);
        CGRect   fr   =  [self.views objectAtIndex: count ].frame;
        fr.origin.x += fr.size.width / 4.0;
        fr.origin.y += fr.size.height / 4.0;
        fr.size.width  *=  0.5;
        fr.size.height  *=  0.5;
        UIView   *checker   = [[UIView alloc]  initWithFrame: fr];
        checker.backgroundColor   = [[UIColor whiteColor ]  colorWithAlphaComponent: 0.8];
        [self.view addSubview: checker];
        [self.whiteCheckers  addObject: checker];
    }
    
    for (NSInteger i = 0; i < 12; i++ )
    {
        count = 40 + i * 2 + ((i) / 4  ) % 2;
        NSLog(@"i = %li , count = %li",i , count);
        CGRect   fr   =  [self.views objectAtIndex: count ].frame;
        fr.origin.x += fr.size.width / 4.0;
        fr.origin.y += fr.size.height / 4.0;
        fr.size.width  *=  0.5;
        fr.size.height  *=  0.5;
        UIView   *checker   = [[UIView alloc]  initWithFrame: fr];
        checker.backgroundColor   = [[UIColor redColor ]  colorWithAlphaComponent: 0.8];
        [self.view addSubview: checker];
        [self.redCheckers  addObject: checker];
    }
    
    
    
}

@end
