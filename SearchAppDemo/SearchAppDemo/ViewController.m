//
//  ViewController.m
//  SearchAppDemo
//
//  Created by Xudongdong on 16/6/6.
//  Copyright © 2016年 ThirtyOneDay. All rights reserved.
//

#import "ViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import "Friend.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *friendArray;

@end

@implementation ViewController

- (NSMutableArray *)friendArray {
    if (_friendArray == nil) {
        _friendArray = [[NSMutableArray alloc] init];
    }
    return _friendArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupTableView];
    
    [self setupData];
    
    [self saveFriend];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor redColor];
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
}

- (void)setupData {
    Friend *mfriend = [[Friend alloc] init];
    mfriend.name = @"张三";
    mfriend.image = [UIImage imageNamed:@"img1"];
    mfriend.f_id = @"1";
    mfriend.webUrl = @"www.baidu.com";
    [self.friendArray addObject:mfriend];
    
    Friend *nfriend = [[Friend alloc] init];
    nfriend.name = @"李四";
    nfriend.image =[UIImage imageNamed:@"img2"];;
    nfriend.f_id = @"2";
    nfriend.webUrl = @"www.baidu.com";
    [self.friendArray addObject:nfriend];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 传递Frame模型
    Friend *friend = [self.friendArray objectAtIndex:indexPath.row];
    cell.imageView.image = friend.image;
    cell.textLabel.text = friend.name;
    
    return cell;
}

- (void)saveFriend {
    NSMutableArray <CSSearchableItem *> *searchableItems = [NSMutableArray array];
    // 将Friend里的每个属性绑定到CSSearchableItemAttributeSet中
    for (Friend *friend in self.friendArray) {
        CSSearchableItemAttributeSet *attribute = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"image"];
        attribute.title = friend.name;
        attribute.contentDescription = friend.webUrl;
        attribute.thumbnailData = UIImagePNGRepresentation(friend.image);
    
        CSSearchableItem *item = [[CSSearchableItem alloc]initWithUniqueIdentifier:friend.f_id domainIdentifier:@"hahahaha" attributeSet:attribute];
        
        [searchableItems addObject:item];
    }
    
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:searchableItems completionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"%@",error);
        } else {
            NSLog(@"被点击了");
        }
    }];
}

- (void)loadImage:(NSString *)f_id {
    
    Friend *someFriend = nil;
    for (Friend *item in self.friendArray) {
        if ([item.f_id isEqualToString:f_id]) {
            someFriend = item;
        }
    }
    if (someFriend) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        imgView.image = someFriend.image;
        [self.view addSubview:imgView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
