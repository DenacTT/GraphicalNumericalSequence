//
//  ViewController.m
//  GraphicalNumericalSequence
//
//  Created by xpg on 16/8/18.
//  Copyright © 2016年 China's Dream. All rights reserved.
//

#import "ViewController.h"
#import "Animal.h"
#import "GraphicalNumericalSequence-Swift.h"


@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedSize;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedSingleDouble;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedType;

@property (weak, nonatomic) IBOutlet UITextField *zodiacTextFild;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;

@property (weak, nonatomic) IBOutlet UITextView *numberTextView;

@property (strong, nonatomic) Animal * mouse;
@property (strong, nonatomic) Animal * cow;
@property (strong, nonatomic) Animal * tiger;
@property (strong, nonatomic) Animal * rabbit;
@property (strong, nonatomic) Animal * dragon;
@property (strong, nonatomic) Animal * snake;
@property (strong, nonatomic) Animal * horse;
@property (strong, nonatomic) Animal * sheep;
@property (strong, nonatomic) Animal * monkey;
@property (strong, nonatomic) Animal * chicken;
@property (strong, nonatomic) Animal * dog;
@property (strong, nonatomic) Animal * pig;

@property (strong, nonatomic) NSArray * animalArray;

@property (assign, nonatomic) int yearIndex;

@property (strong, nonatomic) NSDictionary * animalDic;

@property (strong, nonatomic) DropDown * dropdown;

@property (strong, nonatomic) NSString * sizeStr;
@property (strong, nonatomic) NSString * typeStr;
@property (assign, nonatomic) int singleDouble;

@property (strong, nonatomic) UITextField * seleTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mouse = [[Animal alloc]init];
    self.cow = [[Animal alloc]init];
    self.tiger = [[Animal alloc]init];
    self.rabbit = [[Animal alloc]init];
    self.dragon = [[Animal alloc]init];
    self.snake = [[Animal alloc]init];
    self.horse = [[Animal alloc]init];
    self.sheep = [[Animal alloc]init];
    self.monkey = [[Animal alloc]init];
    self.chicken = [[Animal alloc]init];
    self.dog = [[Animal alloc]init];
    self.pig = [[Animal alloc]init];
    
    self.animalDic = [[NSDictionary alloc]init];
    
    self.dropdown = [[DropDown alloc]init];
    
    int year = 2016;
    
    self.yearIndex = year % 12;
    //    NSLog(@"%d",self.yearIndex);
    
    [self setAnimal:self.monkey andName:@"猴" andType:@"野" andYearInadex:0];
    [self setAnimal:self.sheep andName:@"羊" andType:@"家" andYearInadex:1];
    [self setAnimal:self.horse andName:@"马" andType:@"家" andYearInadex:2];
    [self setAnimal:self.snake andName:@"蛇" andType:@"野" andYearInadex:3];
    [self setAnimal:self.dragon andName:@"龙" andType:@"野" andYearInadex:4];
    [self setAnimal:self.rabbit andName:@"兔" andType:@"野" andYearInadex:5];
    [self setAnimal:self.tiger andName:@"虎" andType:@"野" andYearInadex:6];
    [self setAnimal:self.cow andName:@"牛" andType:@"家" andYearInadex:7];
    [self setAnimal:self.mouse andName:@"鼠" andType:@"野" andYearInadex:8];
    [self setAnimal:self.pig andName:@"猪" andType:@"家" andYearInadex:9];
    [self setAnimal:self.dog andName:@"狗" andType:@"家" andYearInadex:10];
    [self setAnimal:self.chicken andName:@"鸡" andType:@"家" andYearInadex:11];
    
    
    self.animalArray = @[self.monkey, self.sheep, self.horse ,  self.snake, self.dragon, self.rabbit, self.tiger, self.cow, self.mouse, self.pig, self.dog, self.chicken];
    
    NSInteger twelve = 12;
//    NSMutableArray * numberArray = [[NSMutableArray alloc]init];
//    NSLog(@"animals:%@",self.animalArray);
    for (Animal * animal in self.animalArray) {
        NSInteger index = [self.animalArray indexOfObject:animal];
        if (self.yearIndex == 0) {
            [self setAnimalNumber:animal andInitialData:index+1];
        }
        else {
            if (self.yearIndex > index) {
                [self setAnimalNumber:animal andInitialData:self.yearIndex - index + 1];
                
            } else if (self.yearIndex == index) {
                [self setAnimalNumber:animal andInitialData:1];
                
            } else {
                [self setAnimalNumber:animal andInitialData:twelve];
                twelve--;
            }
        }
        //        NSLog(@"animal index:%ld name:%@ type:%@ number:%@",(long)index,animal.name,animal.type,animal.numberArray);
        //        [self.animalDic setValue:animal forKey:@"animal"];
        
    }
    self.sizeStr = @"全";
    self.typeStr = @"全";
    self.singleDouble = 3;
    [self relodeData];
    
    [self registerForKeyboardNotifications];
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[NSString stringWithFormat:@"%d",year] forKey:@"year"];
    [ud synchronize]; //同步,写到磁盘中；
    // getting an NSString
    NSString *myString = [ud stringForKey:@"year"];
    NSLog(@"%@",myString);
    
    
}



- (void) relodeData {
    self.numberTextView.text = nil;
    NSArray * animalNamearray = @[@"monkey", @"sheep", @"horse", @"snake", @"dragon", @"rabbit",  @"tiger", @"cow",@"mouse", @"pig", @"dog", @"chicken"];
    //    删选
    NSDictionary *dictionary = @{animalNamearray: self.animalArray};
    NSMutableArray * numberArr = [NSMutableArray array];
    for (NSArray * animalArray in dictionary.allValues) {
        
        //拿到所选动物
        for (Animal * animal in animalArray) {
            
            //删选家野
            //                            NSLog(@"杀尾:numberStr :%@ :%d",numberStr,[numberStr intValue] % 2);

            if ([self.typeStr isEqualToString:@"全"]?YES:[self.typeStr isEqualToString:animal.type]?YES:NO) {
                
                //杀肖
                if (self.zodiacTextFild.text?[self.zodiacTextFild.text rangeOfString:animal.name].location != NSNotFound?NO:YES:YES) {
                    NSLog(@"animal name:%@ type:%@ number:%@",animal.name,animal.type,animal.numberArray);
                    
                    //快速遍历所选生肖号码
                    for (id numberStr in animal.numberArray) {
                        //                        NSLog(@"number:%@",numberStr);
                        
                        //杀尾
                        if ([self mantissaFiltrate:numberStr]) {
                            
//                            NSLog(@"杀尾:numberStr :%@ :%d",numberStr,[numberStr intValue] % 2);
                            
                            //单双
                            if (self.singleDouble != 3?([numberStr intValue] % 2 == self.singleDouble)?YES:NO:YES) {
                                
                                //大小
                                if ([self.sizeStr isEqualToString:@"全"]?[numberStr intValue] > 0:[self.sizeStr isEqualToString:@"大"]?[numberStr intValue] >= 25:[numberStr intValue] <= 24) {
                                    [numberArr addObject:numberStr];
                                    //                                    NSLog(@"daxiao_numberStr:%@",numberArr);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    //    NSLog(@"numberArray:%@",numberArray);
    
    //    NSArray *originalArray = @[@"1",@"21",@"12",@"11",@"0"];
    //block比较方法，数组中可以是NSInteger，NSString（需要转换）
    NSComparator finderSort = ^(id string1,id string2){
        
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    
    NSLog(@"paixu____numberArr:%@",numberArr);
    
    
    //数组排序：
    NSArray *resultArray = [numberArr sortedArrayUsingComparator:finderSort];
    NSLog(@"第一种排序结果：%@",resultArray);
    for (id number in resultArray) {
        if ([self.numberTextView.text isEqualToString:@""]) {
            self.numberTextView.text = [number stringValue];
        } else {
            self.numberTextView.text = [NSString stringWithFormat:@"%@,%@",self.numberTextView.text,[number stringValue]];
        }
    }
}

//尾数筛选
- (BOOL)mantissaFiltrate:(id)numberStr {
//    if ([numberStr stringValue].length > 1) {
    
        if([self.numberTextField.text rangeOfString:[[numberStr stringValue] substringFromIndex:[numberStr stringValue].length-1]].location != NSNotFound){
            return NO;
            
        }else {
            return YES;
        }
        
//    }else {
//        return YES;
//    }
}

#pragma mark - keyboard
- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *) notif{
    //    NSDictionary *info = [notif userInfo];
    //    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    //    CGPoint keyboardPoint = [value CGRectValue].origin;
    //    NSLog(@"keyBoard:%f  view.hiegth:%f", keyboardPoint.y,self.view.frame.size.height);  //216
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect=CGRectMake(0.0f,0.0f,self.view.frame.size.width,self.view.frame.size.height);
    self.view.frame=rect;
    [self.view setNeedsLayout];
    [UIView commitAnimations];
}

- (void)keyboardWasHidden:(NSNotification *) notif{
    
    //    NSDictionary *info = [notif userInfo];
    //    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    //    CGSize keyboardSize = [value CGRectValue].size;
    //    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    //    CGPoint keyboardPoint = [value CGRectValue].origin;
    //    NSLog(@"keyBoard:%f", keyboardPoint.y);  //216
    
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect=CGRectMake(0.0f, -130,self.view.frame.size.width,self.view.frame.size.height);
    self.view.frame=rect;
    [self.view setNeedsLayout];
    [UIView commitAnimations];
}

#pragma mark - setAnimal
- (void)setAnimal:(Animal *)animal andName:(NSString *)name andType:(NSString *)type andYearInadex:(int)yearIndex {
    animal.name = name;
    animal.type = type;
    animal.yearIndex = yearIndex;
    
}

- (void)setAnimalNumber:(Animal *)animal andInitialData:(NSInteger)initialData {
    NSInteger number = initialData;
    NSMutableArray * numberArray = [NSMutableArray array];
    for (int i = 1; i < 4 ; i++) {
        if (numberArray.count == 0) {
            numberArray = [NSMutableArray arrayWithObject:@(number)];
        }
        number = number + 12;
        [numberArray addObject:@(number)];
        if (number == 37) {
            number = number + 12;
            [numberArray addObject:@(number)];
        }
    }
    animal.numberArray = numberArray;
}

#pragma mark - action
- (IBAction)segmentedType:(UISegmentedControl *)sender {
    //    sender.selectedSegmentIndex;
    if (sender == self.segmentedSize) {
        //        sender.selectedSegmentIndex
        switch (sender.selectedSegmentIndex) {
            case 1: {
                self.sizeStr = @"大";
            }
                break;
                
            case 2: {
                self.sizeStr = @"小";
            }
                break;
                
            default: {
                self.sizeStr = @"全";
            }
                break;
        }
    }
    if (sender == self.segmentedType) {
        switch (sender.selectedSegmentIndex) {
            case 1: {
                self.typeStr = @"家";
            }
                break;
                
            case 2: {
                self.typeStr = @"野";
            }
                break;
                
            default: {
                self.typeStr = @"全";
            }
                break;
        }
    }
    if (sender == self.segmentedSingleDouble) {
        switch (sender.selectedSegmentIndex) {
            case 1: {
                self.singleDouble = 1;
            }
                break;
                
            case 2: {
                self.singleDouble = 0;
            }
                break;
                
            default: {
                self.singleDouble = 3;
            }
                break;
        }
    }
    
    [self relodeData];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    __block id safeSelf = self;
    self.seleTextField = textField;
    if (self.moneyTextField == textField){
        return YES;
        
    }
    if (self.yearTextField == textField){
        
        return YES;
        
    }
    if (self.numberTextField == textField) {
        [self textFieldResignFirst];
        NSArray * typeAnimalArray;
        switch (self.segmentedSingleDouble.selectedSegmentIndex) {
            case 1: {
                typeAnimalArray = @[@"1",@"3",@"5",@"7",@"9"];
            }
                break;
                
            case 2: {
                typeAnimalArray = @[@"0",@"2",@"4",@"6",@"8"];
            }
                break;
                
            default: {
                typeAnimalArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
            }
                break;
        }
        
        self.dropdown.anchorView = textField;
        self.dropdown.dataSource = typeAnimalArray;
        self.dropdown.selectionAction = ^(NSInteger index,NSString * indexStr){
            [safeSelf setTextFieldStr:textField andDropdownStr:indexStr];
        };
        [self.dropdown show];
        return NO;
    }
    if (self.zodiacTextFild == textField) {
        [self textFieldResignFirst];
        NSArray * typeAnimalArray;
        switch (self.segmentedType.selectedSegmentIndex) {
            case 1: {
                typeAnimalArray = @[@"鸡",@"猪",@"狗",@"牛",@"马",@"羊"];
            }
                break;
                
            case 2: {
                typeAnimalArray = @[@"猴",@"鼠",@"虎",@"兔",@"龙",@"蛇"];
            }
                break;
                
            default: {
                typeAnimalArray = @[@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪"];
            }
                break;
        }
        self.dropdown.anchorView = textField;
        self.dropdown.dataSource = typeAnimalArray;
        self.dropdown.selectionAction = ^(NSInteger index,NSString * indexStr){
            [safeSelf setTextFieldStr:textField andDropdownStr:indexStr];
        };
        [self.dropdown show];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

#pragma mark - textField
- (void)textFieldResignFirst {
    [self.yearTextField resignFirstResponder];
    [self.moneyTextField resignFirstResponder];
    [self.numberTextView resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self textFieldResignFirst];
}

- (void)setTextFieldStr:(UITextField *)textField andDropdownStr:(NSString *)dropdownStr {
    if ([textField.text isEqualToString:@""]) {
        textField.text = dropdownStr;
    } else {
        if ([textField.text containsString:dropdownStr]) {
            return;
        } else {
            NSString * textStr = [NSString stringWithFormat:@"%@,%@",textField.text,dropdownStr];
            textField.text = textStr;
        }
    }
    
    [self relodeData];
    
}

//傻笑
- (IBAction)clearAnimalTextField:(id)sender {
    self.zodiacTextFild.text = @"";
    [self relodeData];
    
}

//清空尾数
- (IBAction)clearMantissa:(id)sender {
    self.numberTextField.text = @"";
    [self relodeData];
}

/**
 
 ami(
 3	猪	家
 2	狗	家
 1	鸡	家
 0	猴	野
 11	羊	家
 10	马	家
 9	蛇	野
 8	龙	野
 7	兔	野
 6	虎	野
 5	牛	家
 4	鼠	野
 )
 */


@end
