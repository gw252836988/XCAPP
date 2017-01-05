//
//  GridLayOut.m
//  XCAPP
//
//  Created by 新城集团 on 16-10-10.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "GridLayOut.h"


@interface GridLayOut ()

@property(nonatomic,strong) NSMutableArray * attrArray;
@end
@implementation GridLayOut

-(NSMutableArray * )attrArray
{
    
    if(!_attrArray)
    {
        _attrArray=[NSMutableArray array];
        
    }
    return _attrArray;
}
-(void)prepareLayout
{
    [super prepareLayout];
    NSInteger itemCount=[self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<itemCount; i++) {
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForItem:i inSection:0];
        
        [self.attrArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *attributes=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger index=indexPath.item;
    NSInteger row=index % 4;
    NSInteger col=index/4;
    CGFloat width=CGRectGetWidth(self.collectionView.frame)/4;
    CGFloat height=80;
    CGFloat originX=row*width;
    CGFloat originY=col*height;
    [attributes setFrame:CGRectMake(originX, originY, width,height)];
    return attributes;
    
}


-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return  self.attrArray;
    
}

-(CGSize)collectionViewContentSize
{
    
    NSInteger itemCount=[self.collectionView numberOfItemsInSection:0];
    NSInteger height=(itemCount/4+1)*80;
    return CGSizeMake(0, height);
    
}
@end
