##### `RACTupleSequence`作为`RACSequence`的子类，顾名思义，就是对元祖的操作，根据新增加的方法`sequenceWithTupleBackingArray:offset:`可知，该类是对元祖的数组对象做处理。

完整测试用例[在这里](https://github.com/jianghui1/TestRACTupleSequence)。

`.m`中的方法如下：

    + (instancetype)sequenceWithTupleBackingArray:(NSArray *)backingArray offset:(NSUInteger)offset {
    	NSCParameterAssert(offset <= backingArray.count);
    
    	if (offset == backingArray.count) return self.empty;
    
    	RACTupleSequence *seq = [[self alloc] init];
    	seq->_tupleBackingArray = backingArray;
    	seq->_offset = offset;
    	return seq;
    }
创建`RACTupleSequence`对象，保存参数值`backingArray` `offset`。

测试用例：

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
***

    - (id)head {
    	id object = self.tupleBackingArray[self.offset];
    	return (object == RACTupleNil.tupleNil ? NSNull.null : object);
    }
获取`tupleBackingArray`指定偏移量`offset`下的值作为`head`值。

测试用例：

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
***

    - (RACSequence *)tail {
    	RACSequence *sequence = [self.class sequenceWithTupleBackingArray:self.tupleBackingArray offset:self.offset + 1];
    	sequence.name = self.name;
    	return sequence;
    }
通过`sequenceWithTupleBackingArray:offset:`并将偏移量增加`1`生成一个`RACSequence`对象作为`tail`值。

测试用例：

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
***

    - (NSArray *)array {
    	NSRange range = NSMakeRange(self.offset, self.tupleBackingArray.count - self.offset);
    	NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:range.length];
    
    	[self.tupleBackingArray enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range] options:0 usingBlock:^(id object, NSUInteger index, BOOL *stop) {
    		id mappedObject = (object == RACTupleNil.tupleNil ? NSNull.null : object);
    		[array addObject:mappedObject];
    	}];
    
    	return array;
    }
通过`tupleBackingArray`调用`enumerateObjectsAtIndexes:`方法获取数组从指定偏移量`offset`开始的所有数据，组成一个新的数组返回。

测试用例：

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
***

##### 所以该类的作用就是将元祖的数组转换成一个序列，通过序列的方法获取元祖的值。其实跟`RACArraySequence`的方法非常相似，只是`RACArraySequence`获取的值并不会做处理。而`RACTupleSequence`会将`RACTupleNil`类型转换为`NSNull`类型，如果对`RACTuple`有所了解，就会知道`RACTuple`某种情况下会将`NSNull`转为`RACTupleNil`，这里的操作刚好是还原原始数据。

如果对`RACTuple`不了解，请看[这里](https://blog.csdn.net/jianghui12138/article/details/81808544)。
