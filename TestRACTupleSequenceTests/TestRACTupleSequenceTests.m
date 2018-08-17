//
//  TestRACTupleSequenceTests.m
//  TestRACTupleSequenceTests
//
//  Created by ys on 2018/8/17.
//  Copyright © 2018年 ys. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <ReactiveCocoa.h>
#import <RACTupleSequence.h>

@interface TestRACTupleSequenceTests : XCTestCase

@end

@implementation TestRACTupleSequenceTests

- (void)test_sequenceWithTupleBackingArray
{
    RACTuple *tuple = RACTuplePack(@1, @2, @3);
    RACSequence *sequence = [RACTupleSequence sequenceWithTupleBackingArray:tuple.allObjects offset:1];
    NSLog(@"sequenceWithTupleBackingArray -- %@", sequence);
    
    // 打印日志；
    /*
     2018-08-17 17:40:07.673830+0800 TestRACTupleSequence[52426:18393668] sequenceWithTupleBackingArray -- <RACTupleSequence: 0x600000236600>{ name = , tuple = (
     1,
     2,
     3
     ) }
     */
}

- (void)test_head
{
    RACTuple *tuple = RACTuplePack(@1, @2, @3);
    RACSequence *sequence = [RACTupleSequence sequenceWithTupleBackingArray:tuple.allObjects offset:1];
    NSLog(@"head -- %@", sequence.head);
    
    // 打印日志；
    /*
     2018-08-17 17:41:34.131249+0800 TestRACTupleSequence[52496:18398390] head -- 2
     */
}

- (void)test_tail
{
    RACTuple *tuple = RACTuplePack(@1, @2, @3);
    RACSequence *sequence = [RACTupleSequence sequenceWithTupleBackingArray:tuple.allObjects offset:1];
    NSLog(@"tail -- %@", sequence.tail);
    
    // 打印日志；
    /*
     2018-08-17 17:42:32.102848+0800 TestRACTupleSequence[52540:18401646] tail -- <RACTupleSequence: 0x60000022c300>{ name = , tuple = (
     1,
     2,
     3
     ) }
     */
}

- (void)test_array
{
    RACTuple *tuple = RACTuplePack(@1, @2, @3);
    RACSequence *sequence = [RACTupleSequence sequenceWithTupleBackingArray:tuple.allObjects offset:1];
    NSLog(@"array -- %@", sequence.array);
    
    // 打印日志；
    /*
     2018-08-17 17:43:20.283402+0800 TestRACTupleSequence[52589:18404640] array -- (
     2,
     3
     )
     */
}

@end
