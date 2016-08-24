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
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedType;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedSingleDouble;

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
    
    int year = 1988;
    
    self.yearIndex = year % 12;
    //    NSLog(@"%d",self.yearIndex);
    
    [self setAnimal:self.monkey andName:@"猴" andType:@"野" andYearInadex:0];
    [self setAnimal:self.chicken andName:@"鸡" andType:@"家" andYearInadex:1];
    [self setAnimal:self.dog andName:@"狗" andType:@"家" andYearInadex:2];
    [self setAnimal:self.pig andName:@"猪" andType:@"家" andYearInadex:3];
    [self setAnimal:self.mouse andName:@"鼠" andType:@"野" andYearInadex:4];
    [self setAnimal:self.cow andName:@"牛" andType:@"家" andYearInadex:5];
    [self setAnimal:self.tiger andName:@"虎" andType:@"野" andYearInadex:6];
    [self setAnimal:self.rabbit andName:@"兔" andType:@"家" andYearInadex:7];
    [self setAnimal:self.dragon andName:@"龙" andType:@"野" andYearInadex:8];
    [self setAnimal:self.snake andName:@"蛇" andType:@"野" andYearInadex:9];
    [self setAnimal:self.horse andName:@"马" andType:@"家" andYearInadex:10];
    [self setAnimal:self.sheep andName:@"羊" andType:@"家" andYearInadex:11];
    
    
    self.animalArray = [[NSArray alloc]initWithObjects:self.monkey, self.chicken, self.dog, self.pig, self.mouse, self.cow, self.tiger, self.rabbit, self.dragon, self.snake, self.horse, self.sheep, nil];
    
    NSInteger twelve = 12;
    NSMutableArray * numberArray = [[NSMutableArray alloc]init];
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
    NSArray * animalNamearray = [[NSArray alloc]initWithObjects:@"monkey", @"chicken", @"dog", @"pig", @"mouse", @"cow", @"tiger", @"rabbit", @"dragon", @"snake", @"horse", @"sheep", nil];
    //    删选
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:self.animalArray forKey:animalNamearray];
    
    for (NSArray * animalArray in [dictionary allValues]) {
        
        //拿到所选动物
        for (Animal * animal in animalArray) {
            
            //删选家野
            
            if (self.typeStr?[self.typeStr isEqualToString:animal.type]:YES) {
                
                //杀肖
                if (![animal.name containsString:@"鸡"]) {
//                    NSLog(@"animal name:%@ type:%@ number:%@",animal.name,animal.type,animal.numberArray);
                    
                    //快速遍历所选生肖号码
                    for (id numberStr in animal.numberArray) {
//                        NSLog(@"number:%@",numberStr);
                        
                        //杀尾
                        if (![[numberStr stringValue] hasSuffix:@"1"]) {
                            NSLog(@"numberStr :%@ 单双:%d",numberStr,[numberStr intValue] % 2);
                            
                            //单双
                            if (([numberStr intValue] % 2) == 0) {
                                
                                //大小
                                if ([numberStr intValue] > 25) {
                                    [numberArray addObject:numberStr];
                                    if ([self.numberTextView.text isEqualToString:@""]) {
                                        self.numberTextView.text = [numberStr stringValue];
                                    } else {
                                        NSString * textStr = [NSString stringWithFormat:@"%@,%@",self.numberTextView.text,[numberStr stringValue]];
                                        self.numberTextView.text = textStr;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    NSLog(@"numberArray:%@",numberArray);
}

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
- (IBAction)segmentedSizeAction:(id)sender {
    
}

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
                self.singleDouble = 2;
            }
                break;
                
            default: {
                
            }
                break;
        }
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    __block id safeSelf = self;
//    if (self.moneyTextField == textField){
////        self.seleTextfield = textField;
//        return YES;
//        
//    }
//    if (self.yearTextField == textField){
////        self.seleTextfield = textField;
//        return YES;
//        
//    }
    if (self.numberTextField == textField) {
        [self textFieldResignFirst];
        self.dropdown.anchorView = textField;
        self.dropdown.dataSource = @[@"1",@"3",@"4",@"5",@"155",@"2"];
        self.dropdown.selectionAction = ^(NSInteger index,NSString * indexStr){
            [safeSelf setTextFieldStr:textField andDropdownStr:indexStr];
        };
        [self.dropdown show];
        return NO;
    }
    if (self.zodiacTextFild == textField) {
        [self textFieldResignFirst];
        self.dropdown.anchorView = textField;
        self.dropdown.dataSource = @[@"喵",@"喵1",@"喵4",@"喵5",@"喵155",@"喵2"];
        self.dropdown.selectionAction = ^(NSInteger index,NSString * indexStr){
            [safeSelf setTextFieldStr:textField andDropdownStr:indexStr];
        };
        [self.dropdown show];
        return NO;
    }
    
    
    return YES;
}

#pragma mark - textFieldResignFirst
- (void)textFieldResignFirst {
    [self.yearTextField resignFirstResponder];
    [self.moneyTextField resignFirstResponder];
//    [self.]
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
