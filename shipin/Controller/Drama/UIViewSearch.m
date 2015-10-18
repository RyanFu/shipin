//
//  UIViewSearch.m
//  shipin
//
//  Created by Mapollo27 on 15/8/17.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <LKDBHelper/LKDBHelper.h>
#import "UIViewSearch.h"
#import "SearchViewController.h"


@implementation UIViewSearch
@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        _strType = @"1";
        _strCountry = @"0";
        _strPlot= @"0";
        _strYear= @"0";
        
        _strTypeName = @"";
        _strCountryName = @"";
        _strPlotName = @"";
        _strYearName = @"";
        
        _strName = @"";
        DramaTags *tag = [[DramaTags alloc] init];
        tag.id=0;
        tag.name=@"全部";

        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        _searchBar = [[UISearchBar alloc ] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
        [_searchBar setBackgroundColor:[UIColor whiteColor]];
        _searchBar.delegate = self;
        [self addSubview:_searchBar];
        
        _arrayOne = [[NSMutableArray alloc] init];
        [_arrayOne addObject:tag];
        [_arrayOne addObjectsFromArray:[self getTags:@(1)]];
        for (int i = 0; i < [_arrayOne count]; i++)
        {
            btnLine1[i] = [[UIButton alloc ] initWithFrame:CGRectMake(10+(i*43), _searchBar.frame.size.height+_searchBar.frame.origin.y+10, 40, 15)];
            [ btnLine1[i] setTitle:[_arrayOne[i] name] forState:UIControlStateNormal];
             btnLine1[i].titleLabel.font = [UIFont systemFontOfSize:10];
             btnLine1[i].layer.masksToBounds = YES;
             btnLine1[i].layer.cornerRadius =2;
            btnLine1[i].tag = i;
            [btnLine1[i] addTarget:self action:@selector(onButtonOne:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview: btnLine1[i]];
            if (i ==0 )
            {
                [ btnLine1[i] setBackgroundColor:yellowRgb];
            }
            else
            {
                [ btnLine1[i] setBackgroundColor:[UIColor whiteColor]];
                [ btnLine1[i] setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
            }
        }

        _arrayTwo = [[NSMutableArray alloc] init];
        [_arrayTwo addObject:tag];
        [_arrayTwo addObjectsFromArray:[self getTags:@(2)]];


        NSInteger rowCount = [_arrayTwo count]%7;
        if(rowCount != 0){
            rowCount= [_arrayTwo count]/7+1;
        } else{
            rowCount = [_arrayTwo count]/7;
        }

        for (int row = 0; row < rowCount; row++)
        {
            for (int i = 0; i < 7; i++)
            {
                if ((row*7)+i < [_arrayTwo count])
                {
                    btnLine2[(row*7)+i] = [[UIButton alloc ] initWithFrame:CGRectMake(10+(i*43),  btnLine1[0].frame.size.height+ btnLine1[0].frame.origin.y+10 +(row*25), 40, 15)];
                    [btnLine2[(row*7)+i] setTitle:[_arrayTwo[(row * 7) + i] name] forState:UIControlStateNormal];
                    btnLine2[(row*7)+i].titleLabel.font = [UIFont systemFontOfSize:10];
                    btnLine2[(row*7)+i].layer.masksToBounds = YES;
                    btnLine2[(row*7)+i].layer.cornerRadius =2;
                    btnLine2[(row*7)+i].tag = (row*7)+i;
                    [btnLine2[(row*7)+i] addTarget:self action:@selector(onButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:btnLine2[(row*7)+i]];
                    
                    if ((row*7)+i ==0 )
                    {
                        [ btnLine2[(row*7)+i] setBackgroundColor:yellowRgb];
                    }
                    else
                    {
                        [ btnLine2[(row*7)+i] setBackgroundColor:[UIColor whiteColor]];
                        [ btnLine2[(row*7)+i] setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
                    }

                }
            }
        }


        _arrayThree = [[NSMutableArray alloc] init];
        [_arrayThree addObject:tag];
        [_arrayThree addObjectsFromArray:[self getTags:@(3)]];

        NSInteger threeRowCount = [_arrayThree count]%7;
        if(threeRowCount != 0){
            threeRowCount= [_arrayThree count]/7+1;
        } else{
            threeRowCount = [_arrayThree count]/7;
        }
//       _arrayThree = [[NSArray alloc ] initWithArray:[self getTags:@(3)]];

        for (int row = 0; row <threeRowCount; row++)
        {
            for (int i = 0; i < 7; i++)
            {
                if ((row*7)+i < [_arrayThree count])
                {
                    btnLine3[(row*7)+i] = [[UIButton alloc ] initWithFrame:CGRectMake(10+(i*43),  btnLine2[[_arrayTwo count]-1].frame.size.height+ btnLine2[[_arrayTwo count]-1].frame.origin.y+10 +(row*23), 40, 15)];
                    [btnLine3[(row*7)+i] setTitle:[_arrayThree[(row * 7) + i] name] forState:UIControlStateNormal];
                    btnLine3[(row*7)+i].titleLabel.font = [UIFont systemFontOfSize:10];
                    btnLine3[(row*7)+i].layer.masksToBounds = YES;
                    btnLine3[(row*7)+i].layer.cornerRadius =2;
                    btnLine3[(row*7)+i].tag = (row*7)+i;
                    [btnLine3[(row*7)+i] addTarget:self action:@selector(onButtonThree:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:btnLine3[(row*7)+i]];

                    if ((row*7)+i ==0 )
                    {
                        [ btnLine3[(row*7)+i] setBackgroundColor:yellowRgb];
                    }
                    else
                    {
                        [ btnLine3[(row*7)+i] setBackgroundColor:[UIColor whiteColor]];
                        [ btnLine3[(row*7)+i] setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
                    }

                }
            }
        }

        _arrayFour = [[NSMutableArray alloc] init];
        [_arrayFour addObject:tag];
        [_arrayFour addObjectsFromArray:[self getTags:@(4)]];

        NSInteger fourRowCount = [_arrayFour count]%7;
        if(fourRowCount != 0){
            fourRowCount= [_arrayFour count]/7+1;
        } else{
            fourRowCount = [_arrayFour count]/7;
        }
//        _arrayFour = [[NSArray alloc ] initWithArray:[self getTags:@(4)]];
//        for (int i = 0; i < fourRowCount; i++)
//        {
//            btnLine4[i] = [[UIButton alloc ] initWithFrame:CGRectMake(10+(i*43), btnLine3[[_arrayThree count]-1].frame.size.height+ btnLine3[[_arrayThree count]-1].frame.origin.y+10 , 40, 15)];
//            [ btnLine4[i] setTitle:[_arrayFour[i] name] forState:UIControlStateNormal];
//            btnLine4[i].titleLabel.font = [UIFont systemFontOfSize:10];
//            btnLine4[i].layer.masksToBounds = YES;
//            btnLine4[i].layer.cornerRadius =2;
//            btnLine4[i].tag = i;
//            [btnLine4[i] addTarget:self action:@selector(onButtonFour:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview: btnLine4[i]];
//            if (i ==0 )
//            {
//                [ btnLine4[i] setBackgroundColor:yellowRgb];
//            }
//            else
//            {
//                [ btnLine4[i] setBackgroundColor:[UIColor whiteColor]];
//                [ btnLine4[i] setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
//            }
//        }



        for (int row = 0; row <fourRowCount; row++)
        {
            for (int i = 0; i < 7; i++)
            {
                if ((row*7)+i < [_arrayFour count])
                {
                    btnLine4[(row*7)+i] = [[UIButton alloc ] initWithFrame:CGRectMake(10+(i*43),  btnLine3[[_arrayThree count]-1].frame.size.height+ btnLine3[[_arrayThree count]-1].frame.origin.y+10 +(row*23), 40, 15)];
                    [btnLine4[(row*7)+i] setTitle:[_arrayFour[(row * 7) + i] name] forState:UIControlStateNormal];
                    btnLine4[(row*7)+i].titleLabel.font = [UIFont systemFontOfSize:10];
                    btnLine4[(row*7)+i].layer.masksToBounds = YES;
                    btnLine4[(row*7)+i].layer.cornerRadius =2;
                    btnLine4[(row*7)+i].tag = (row*7)+i;
                    [btnLine4[(row*7)+i] addTarget:self action:@selector(onButtonFour:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:btnLine4[(row*7)+i]];

                    if ((row*7)+i ==0 )
                    {
                        [ btnLine4[(row*7)+i] setBackgroundColor:yellowRgb];
                    }
                    else
                    {
                        [ btnLine4[(row*7)+i] setBackgroundColor:[UIColor whiteColor]];
                        [ btnLine4[(row*7)+i] setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
                    }

                }
            }
        }
    }
    return self;
}


-(void) onButtonOne:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
    for (int btnIndex=0; btnIndex < [_arrayOne count]; btnIndex++)
    {
        if (btnIndex == sender.tag)
        {
            _tagModle =  [_arrayOne objectAtIndex:btnIndex];
            _strType =[_tagModle.id stringValue];
            _strTypeName =_tagModle.name;
            
            [self tagClick:_strType oneName:_strTypeName Country:_strCountry countryName:_strCountryName Plot:_strPlot plotName:_strPlotName Year:_strYear yearName:_strYearName];
            [ btnLine1[btnIndex] setBackgroundColor:yellowRgb];
            [ btnLine1[btnIndex] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [ btnLine1[btnIndex] setBackgroundColor:[UIColor whiteColor]];
            [ btnLine1[btnIndex] setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        }
    }
}


-(void) onButtonTwo:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
    for (int btnIndex=0; btnIndex < [_arrayTwo count]; btnIndex++)
    {
        if (btnIndex == sender.tag)
        {
            _tagModle =  [_arrayTwo objectAtIndex:btnIndex];
            _strCountry =[_tagModle.id stringValue];
            _strCountryName =_tagModle.name;
            
            [self tagClick:_strType oneName:_strTypeName Country:_strCountry countryName:_strCountryName Plot:_strPlot plotName:_strPlotName Year:_strYear yearName:_strYearName];
            [ btnLine2[btnIndex] setBackgroundColor:yellowRgb];
            [ btnLine2[btnIndex] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [ btnLine2[btnIndex] setBackgroundColor:[UIColor whiteColor]];
            [ btnLine2[btnIndex] setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        }
    }
}


-(void) onButtonThree:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
    for (int btnIndex=0; btnIndex < [_arrayThree count]; btnIndex++)
    {
        if (btnIndex == sender.tag)
        {
            _tagModle =  [_arrayThree objectAtIndex:btnIndex];
            _strPlot =[_tagModle.id stringValue];
            _strPlotName =_tagModle.name;
            
           [self tagClick:_strType oneName:_strTypeName Country:_strCountry countryName:_strCountryName Plot:_strPlot plotName:_strPlotName Year:_strYear yearName:_strYearName];
            [ btnLine3[btnIndex] setBackgroundColor:yellowRgb];
            [ btnLine3[btnIndex] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [ btnLine3[btnIndex] setBackgroundColor:[UIColor whiteColor]];
            [ btnLine3[btnIndex] setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        }
    }
}

-(void) onButtonFour:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
    for (int btnIndex=0; btnIndex < [_arrayFour count]; btnIndex++)
    {
        if (btnIndex == sender.tag)
        {
            _tagModle =  [_arrayFour objectAtIndex:btnIndex];
            _strYear =[_tagModle.id stringValue];
            _strYearName =_tagModle.name;
            
            [self tagClick:_strType oneName:_strTypeName Country:_strCountry countryName:_strCountryName Plot:_strPlot plotName:_strPlotName Year:_strYear yearName:_strYearName];
            [ btnLine4[btnIndex] setBackgroundColor:yellowRgb];
            [ btnLine4[btnIndex] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [ btnLine4[btnIndex] setBackgroundColor:[UIColor whiteColor]];
            [ btnLine4[btnIndex] setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        }
    }
}

-(void) tagClick:(NSString *)one oneName:(NSString *)OneName
         Country:(NSString *)country  countryName:(NSString *)CountryName
            Plot:(NSString *)plot plotName:(NSString *)PlotName
            Year:(NSString *)year yearName:(NSString *)YearName
{
//    NSMutableArray *arrName = [[NSMutableArray alloc ] init];
//    [arrName removeAllObjects];
//    if([OneName length]>0)
//    {
//        [arrName addObject:OneName];
//    }
//    if([CountryName length]>0)
//    {
//        [arrName addObject:CountryName];
//    }
//    if([PlotName length]>0)
//    {
//        [arrName addObject:PlotName];
//    }
//    if([YearName length]>0)
//    {
//        [arrName addObject:YearName];
//    }
//    for (int i = 0; i < [arrName count]; i++)
//    {
//        _strName = [_strName stringByAppendingString:arrName[i]];
//    }
    [_searchBar setText:[NSString stringWithFormat:@"%@,%@,%@,%@",OneName,CountryName,PlotName,YearName]];
    
    _arrayTags = [[NSMutableArray alloc ] initWithObjects:one,country,plot,year,OneName,CountryName,PlotName,YearName, nil];
    [[NSNotificationCenter defaultCenter ] postNotificationName:@"notification_tags" object:_arrayTags];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if ([_arrayTags count] >0)
    {
        if ([delegate respondsToSelector:@selector(pushToSearcheView)])
        {
            [delegate pushToSearcheView];
        }
    }
    else
    {
        [Tool showWarningTip:@"请选择要搜索标签" view:self.window time:1];
    }
    return FALSE;
}

-(NSMutableArray *) getTags:(NSNumber *)type{

    LKDBHelper *helper = [LKDBHelper getUsingLKDBHelper];
    NSString *orderBy = @"CAST(id as integer) asc";
    NSString *where = [NSString stringWithFormat:@"type=%@", type];
    NSMutableArray *tagArray = [helper search:[DramaTags class] where:where orderBy:orderBy offset:0 count:50];

   if(tagArray!=nil){

       return tagArray;
   } else
       return [[NSMutableArray alloc] init];
}

@end
