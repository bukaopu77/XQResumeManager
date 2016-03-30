//
//  ViewController.m
//  XQResumeManager
//
//  Created by 周剑 on 16/3/30.
//  Copyright © 2016年 bukaopu. All rights reserved.
//

#import "ViewController.h"
#import "XQResumeManager.h"

@interface ViewController ()

@property (nonatomic, strong) XQResumeManager *manager;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, strong) NSString *targetPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressView.progress = 0;
}


#pragma mark - 开始请求
- (IBAction)startRequset:(id)sender {
    //1.准备
    if (self.manager) {
        
        [self cancelRequest:nil];
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    self.targetPath = [documentsDirectory stringByAppendingPathComponent:@"myPic"];
    
    NSURL *url = [NSURL URLWithString:@"http://p1.pichost.me/i/40/1639665.png"];
    
    self.manager = [XQResumeManager resumeManagerWithURL:url targetPath:self.targetPath success:^{
        
        NSLog(@"success");
        self.imageView.image = [UIImage imageWithContentsOfFile:self.targetPath];
        self.deleteBtn.hidden = NO;
        
    } failure:^(NSError *error) {
        
        NSLog(@"failure");
        
    } progress:^(long long totalReceivedContentLength, long long totalContentLength) {
        
        float percent = 1.0 * totalReceivedContentLength / totalContentLength;
        NSString *strPersent = [[NSString alloc]initWithFormat:@"%.f", percent *100];
        self.progressView.progress = percent;
        self.progressLabel.text = [NSString stringWithFormat:@"已下载%@%%", strPersent];
    }];
    
    //2.启动
    [self.manager start];

}

#pragma mark - 取消请求
- (IBAction)cancelRequest:(id)sender {
    [self.manager cancel];
    self.manager = nil;
}

#pragma mark - 删除文件
- (IBAction)deleteImage:(id)sender {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    [manager removeItemAtPath:self.targetPath error:&error];
    
    if (error == nil) {
        
        self.imageView.image = [UIImage imageWithContentsOfFile:self.targetPath];
        self.progressView.progress = 0;
        self.progressLabel.text = nil;
        
        self.deleteBtn.hidden = YES;
    }

}

@end
