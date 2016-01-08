//
//  ViewController.m
//  测试
//
//  Created by zccl2 on 16/1/7.
//  Copyright © 2016年 Wyg. All rights reserved.
//

#import "ViewController.h"
#import "YGTimeQuantumChooseView.h"

#define VERSION_IS_IOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

@interface ViewController ()<YGTimeQuantumChooseViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate>
{
    YGTimeQuantumChooseView *_timeQuantumChooseView;/**< 时间段选择视图*/
    
    NSArray *_timeArray;/**< 时间段数组*/
    
    NSString *_chooseText;/**< 选择的文字*/
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**< 创建时间选择控件*/
    if (!_timeQuantumChooseView) {
        _timeQuantumChooseView = [[YGTimeQuantumChooseView alloc] initWithFrame:CGRectMake(20, 100, 300, 30)];
        _timeQuantumChooseView.delegate = self;
        [self.view addSubview:_timeQuantumChooseView];
    }
    
    _timeArray = @[@"本月",@"近三个月",@"近六个月",@"本年度"];/**< 对应的时间段数组*/
    _chooseText = @"本月";/**< 默认选择的时间段*/

    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark YGBusinessViewDelegate
- (void)YGTimeQuantumChooseViewTimeChooseButtonPress {
    _chooseText = @"本月";
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.frame = CGRectMake(0, 0, self.view.frame.size.width-20, 180);
    pickerView.showsSelectionIndicator = YES;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    if(VERSION_IS_IOS8)/**< 判断系统版本*/
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n"  message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"  style:UIAlertActionStyleCancel  handler:^(UIAlertAction *action) {
            
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"选择"  style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action) {
            [_timeQuantumChooseView timeChooseButtonSetTitle:_chooseText];/**< 修改显示的时间段*/
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [alertController.view addSubview:pickerView];
        [self presentViewController:alertController animated:YES completion:nil];
    }else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择", nil];
        [actionSheet addSubview:pickerView];
        [actionSheet showInView:self.view.window];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [_timeQuantumChooseView timeChooseButtonSetTitle:_chooseText];/**< 修改显示的时间段*/
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _timeArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _timeArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _chooseText = _timeArray[row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
