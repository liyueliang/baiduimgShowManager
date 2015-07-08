//
//  YLAboutViewController.m
//  BaiduImgShow
//
//  Created by jlt on 15/7/3.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLAboutViewController.h"

@interface YLAboutViewController ()<UIWebViewDelegate>

@end

@implementation YLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(makeClick:)];
    self.navigationItem.leftBarButtonItem =leftBarButton;
    self.title=@"关于我们";
    
    UIWebView *webView =[[UIWebView alloc]initWithFrame:self.view.frame];
    webView.delegate=self;
    [self.view addSubview:webView];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
    
}
-(void)makeClick:(id)obj{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -web delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
