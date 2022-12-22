//
//  TTNetStartUpTask.m
//  App
//
//  Created by bytedance on 2021/4/25.
//

#import "TTNetStartUpTask.h"
#import <OneKit/OKStartUpFunction.h>
#import <TTNetworkManager/TTNetworkManager.h>

OKAppTaskAddFunction () {
    [[TTNetStartUpTask new] scheduleTask];
}

@implementation TTNetStartUpTask

- (void)startWithLaunchOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    [TTNetworkManager setMonitorBlock:^(NSDictionary * json, NSString *logtype) {
        //NSLog(@"json: %@, log type: %@", json, logtype);
    }];
    
    [[TTNetworkManager shareInstance] setCommonParamsblock:^NSDictionary *{
            NSMutableDictionary *commonParams = [NSMutableDictionary dictionary];
            [commonParams setValue:@"99999" forKey:@"aid"];
            return [commonParams copy];
    }];
    
    [[TTNetworkManager shareInstance] setDomainHttpDns:@"xx.xx.xx"];
    [[TTNetworkManager shareInstance] setDomainNetlog:@"xx.xx.xx"];
    [[TTNetworkManager shareInstance] setDomainBoe:@"xxx"];
    

    NSString *tnc_config =
        @"{"
        "    \"data\": {"
        "         \"chromium_open\": 1,"                   // 开启cronet
        "         \"ttnet_http_dns_enabled\": 0,"          // 关闭HttpDns
        "         \"ttnet_quic_enabled\": 1,"              // 开启QUIC协议支持
        "         \"ttnet_local_dns_time_out\":5,"         // 设置LocalDns超时
        "         \"ttnet_h2_enabled\": 1,"                // 开启HTTP2协议支持
        "         \"ttnet_socket_pool_param\": {"          // 设置一个Host对应的连接数
        "             \"max_sockets_per_group\": 20"
        "         },"
        "         \"ttnet_preconnect_urls\": {"            // 设置预连接的域名以及连接数
        "             \"https://www.xxx.com\": 1,"         // 预连接可以根据业务自身需求
        "             \"https://www.xxx.com\": 2"          // 选择性配置（也可不配）
        "         },"
        "         \"ttnet_buffer_config\": {"              // 上传数据时的Buffer大小
        "             \"ttnet_request_body_buffer_size\": 1048576,"
        "         },"
        "    },"
        "    \"message\":\"success\""
        "}";
    [[TTNetworkManager shareInstance] setGetDomainDefaultJSON:tnc_config];
    
    [[TTNetworkManager shareInstance] start];
}
@end
