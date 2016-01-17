//
//  Node1.h
//  MYT
//
//  Created by YUNRUIMAC on 16/1/17.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node1 : NSObject

@property (nonatomic , assign) int parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , assign) int nodeId;//本节点的id

@property (nonatomic , strong) NSString *name;//本节点的名称

@property (nonatomic , assign) int depth;//该节点的深度

@property (nonatomic , assign) BOOL expand;//该节点是否处于展开状态

@property (nonatomic , assign) BOOL child;//该节点是否有孩子
@property (nonatomic , assign)int typid;//物料规格id
@property (nonatomic , assign)int matid;//物料id
@property (nonatomic , assign)int needcount;
/**
 *快速实例化该对象模型
 */
- (instancetype)initWithParentId : (int)parentId nodeId : (int)nodeId name : (NSString *)name depth : (int)depth expand : (BOOL)expand child:(BOOL)child matid:(int)matid typid:(int)typid needcount:(int)needcount;
@end
