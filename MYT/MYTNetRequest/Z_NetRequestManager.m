//
//  Z_NetRequestManager.m
//  MYT
//
//  Created by 熊凯 on 16/1/9.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "Z_NetRequestManager.h"
#import "UIViewController+Helper.h"
static Z_NetRequestManager * sharedInstance = nil;
@implementation Z_NetRequestManager
{
    CLLocationManager* _locationManager;
     CLGeocoder* _geocoder;
    float longi;
    float lati;
}
+ (Z_NetRequestManager *)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[Z_NetRequestManager alloc] init];
    }
    return sharedInstance;
}
-(NSDictionary *)postJson:(NSDictionary *)paradic url:(NSString *)url
{
    __block NSDictionary* dic;
    NSData *data = [NSJSONSerialization dataWithJSONObject:paradic options:NSJSONWritingPrettyPrinted error:nil];
    [[QQRequestManager sharedRequestManager] GET:url parameters:data showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        dic=(NSDictionary*)responseObject;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.superclass qq_performSVHUDBlock:^{
            [SVProgressHUD showErrorWithStatus:@"数据请求错误，请检查网络！"];
        }];
        
    }];
    
    return dic;
}
-(NSDictionary*)getClientList:(NSDictionary*) paraDic
{
    __block NSDictionary* dic;
    
    [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getAppUserList.action"] parameters:paraDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        dic=(NSDictionary*)responseObject;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.superclass qq_performSVHUDBlock:^{
            [SVProgressHUD showErrorWithStatus:@"数据请求错误，请检查网络！"];
        }];
       
    }];
    
    return dic;
}
-(void)getlongandlati
{
    NSMutableDictionary* dic=[[NSMutableDictionary alloc]init];
    _locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager requestWhenInUseAuthorization];
    }
    //定位管理器
    //_locationManager=[[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开");
    }
    //如果没有授权则请求授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }else if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=1.0;//一米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }
    NSString *longistr=[NSString stringWithFormat:@"%f",longi];
   NSString *latistr=[NSString stringWithFormat:@"%f",lati];
    [dic setValue:longistr forKey:@"longi"];
    [dic setValue:latistr forKey:@"lati"];
   
}
-(NSDictionary *)getlongla
{
    NSMutableDictionary* dic=[[NSMutableDictionary alloc]init];
    NSString *longistr=[NSString stringWithFormat:@"%f",longi];
    NSString *latistr=[NSString stringWithFormat:@"%f",lati];
    [dic setValue:longistr forKey:@"longi"];
    [dic setValue:latistr forKey:@"lati"];
    return dic;
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_locationManager requestAlwaysAuthorization];
            }
            break;
        default:
            break;
            
            
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    longi=coordinate.longitude;
    lati=coordinate.latitude;
    //如果不需要实时定位，使用完即使关闭定位服务
     [_locationManager stopUpdatingLocation];
}
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        NSLog(@"详细信息:%@",placemark.addressDictionary);
    }];
}
@end
