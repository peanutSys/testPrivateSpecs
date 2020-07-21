//
//  allTestTests.m
//  allTestTests
//
//  Created by fly on 2020/3/26.
//  Copyright © 2020 fly. All rights reserved.
//

#import <XCTest/XCTest.h>

typedef struct mystruct {
    int a;
} * point_my;

@interface allTestTests : XCTestCase

@end

@implementation allTestTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //构造方法
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    //析构方法
}

-(void)testAddition{
    XCTestExpectation* te = [[XCTestExpectation alloc] init];
    NSLog(@"%d",[te isKindOfClass:[NSObject class]]);
    NSLog(@"%d",[te isMemberOfClass:[NSObject class]]);
    
}

- (void)testAsyncFunction{
    //创建一个XCTestExpectation对象。
    //这个测试只有一个，可以等待多个XCTestExpectation对象。
    
    XCTestExpectation * expectation = [self expectationWithDescription:@"测试异步"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        NSLog(@"Async test");
        XCTAssert(YES,"should pass");
        //完成相应操作后调用fulfill  这将导致-waitForExpectation
        [expectation fulfill];
    });
    
    //测试将在此暂停，运行runloop，直到超时调用或所有的expectations都调用了fulfill方法。
    [self waitForExpectationsWithTimeout:0.5 handler:^(NSError *error) {
        //Do something when time out关闭文件等操作
    }];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        for (NSInteger index = 0; index < 10000; index ++) {
            NSString *str = [@((index+1) % 100) description];
            NSLog(@"%@",str);
        }
    }];
}

@end
