//
//  ViewController.m
//  allTest
//
//  Created by fly on 2020/3/26.
//  Copyright © 2020 fly. All rights reserved.
//

#import "ViewController.h"

#import <Security/Security.h>
#import<CommonCrypto/CommonDigest.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>

@implementation ViewController

@dynamic string_;

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSArray *array = @[@"yang",@"she",@"bing"];
    
    
}

-(void)ss{
    
}

-(void)launchLottery{
    UIScrollView* sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    sv.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*2);
    sv.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:sv];
    
    CFRunLoopObserverRef or = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), or, kCFRunLoopCommonModes);
    CFRelease(or);
}

-(void)runloopMode{
    NSTimer* timer_ = [NSTimer scheduledTimerWithTimeInterval:12 repeats:false block:^(NSTimer * _Nonnull timer) {
        
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer_ forMode:NSRunLoopCommonModes];
    [timer_ invalidate];
    
    CFRunLoopObserverRef or = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), or, kCFRunLoopDefaultMode);
    CFRelease(or);
    
}

//获取指定标示的钥匙串
+(NSMutableDictionary *)getKeychainService:(NSString *)service{
     NSDictionary*dic = @{
             (__bridge_transfer id)kSecClass:(__bridge_transfer id)kSecClassGenericPassword,
             (__bridge_transfer id)kSecAttrServer:service,
             (__bridge_transfer id)kSecAttrAccount:service,
             (__bridge_transfer id)kSecAttrAccessible:(__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock
             };
    return [dic mutableCopy];
}

//将数据添加到指定钥匙串中，先删除原有钥匙串，更改字典数据后再添加钥匙串
+(void)save:(NSString *)service data:(id)data{
    NSMutableDictionary*dic = [self getKeychainService:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)dic);
    [dic setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    SecItemAdd((__bridge_retained CFDictionaryRef)dic, NULL);
}

+(id)getKeyChainDic:(NSString*)service{
    id result = nil;
    NSMutableDictionary*dic = [self getKeychainService:service];
    //配置搜索服务
    [dic setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [dic setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef cfdata = NULL;
    SecItemCopyMatching((__bridge_retained CFDictionaryRef)dic, (CFTypeRef*)&cfdata);
    if ( cfdata ) {
        @try {
            result = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer id)cfdata];
        } @catch (NSException *exception) {
            NSLog(@"查询钥匙串数据失败");
        }
    }
    return result;
}

- (NSString *)md5_16:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end
