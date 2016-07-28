#import "ViewController.h"

#define KTabSelectedFontColor [UIColor orangeColor]
#define KTabSelectedFontSize [UIFont systemFontOfSize:14];
#define KTabUnSelectedFontSize [UIFont systemFontOfSize:16];
#define KViewTop 20

#define KTabViewButtonBeginTag 100
#define KTabViewLabelBeginTag  200

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{

    //变量
    NSArray *_tabItemArray;      //tab的集合数组(景点,美食,酒店,交通,购物,娱乐)
    NSInteger _driverViewHeight; //设备view的高度
    NSInteger _driverViewWidth;  //设备ivew的宽度
    NSInteger _tabViewHeight;    //tab集合的高度
    NSInteger _tabItemLabelHeight; //tab选中label的高度
    NSInteger _tabItemLableGapToView;  //tab选中label离view的边距
    NSMutableArray *_imageListArray;    //获取的图片数据
    
    //view
    UITableView *_imageTableView;//显示图片的tableView
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    [self setupUI];
}

#pragma mark 初始化数据
- (void)setupData{
    _tabItemArray=@[@"景点",@"美食",@"酒店",@"交通",@"购物",@"娱乐"];
    _imageListArray=[[NSMutableArray alloc] init];
    
    [ViewModelsBase getImageWithTagItemString:[_tabItemArray firstObject] returnBlock:^(NSArray *imageArray) {
        _imageListArray=[imageArray mutableCopy];
    }];
}

#pragma mark 代码构建UI
- (void)setupUI{
    
    _driverViewHeight=CGRectGetHeight(self.view.frame);
    _driverViewWidth=CGRectGetWidth(self.view.frame);
    _tabViewHeight=45;
    _tabItemLabelHeight=1;
    _tabItemLableGapToView=10;
    
    [self setupTabItemUI];
    [self setupTableViewUI];

}

//构建tabItem内容
- (void)setupTabItemUI{
    
    if (_tabItemArray.count>0) {
        
        UIView *tabView=[[UIView alloc] initWithFrame:CGRectMake(0,KViewTop, _driverViewWidth, _tabViewHeight)];
        [self.view addSubview:tabView];
        
        //计算每个tab的宽度
        NSInteger tabItemWidth=_driverViewWidth/_tabItemArray.count;
        //构造tab 每个tab 是一个view 包含 button 和选中的label 默认选中第一项
        NSInteger curTabItemOriginX=0;//当前tabItem的x 位置
        
        for (int i=0; i<=_tabItemArray.count-1; i++) {
            //view
             UIView *tabItemView=[[UIView alloc] initWithFrame:CGRectMake(curTabItemOriginX, 0, tabItemWidth, _tabViewHeight)];
            //button
            UIButton *tabItemButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(tabItemView.frame),CGRectGetHeight(tabItemView.frame))];
            tabItemButton.tag=KTabViewButtonBeginTag+i;
            
            if (i==0) {
                tabItemButton.titleLabel.font=KTabSelectedFontSize;
                [tabItemButton setTitleColor:KTabSelectedFontColor forState:UIControlStateNormal];
            }else{
                tabItemButton.titleLabel.font=KTabUnSelectedFontSize;
                [tabItemButton setTitleColor:KDefaultFontColor forState:UIControlStateNormal];
            }
            [tabItemButton setTitle:[_tabItemArray objectAtIndex:i] forState:UIControlStateNormal];
            [tabItemButton addTarget:self action:@selector(didBtnSelectKanBan:) forControlEvents:UIControlEventTouchUpInside];
            [tabItemView addSubview:tabItemButton];

            //label
            UILabel *tabItemLabel=[[UILabel alloc] initWithFrame:CGRectMake(_tabItemLableGapToView,CGRectGetHeight(tabItemView.frame)-_tabItemLabelHeight,CGRectGetWidth(tabItemView.frame)-_tabItemLableGapToView*2, _tabItemLabelHeight)];
            tabItemLabel.textAlignment=NSTextAlignmentCenter;
            tabItemLabel.tag=KTabViewLabelBeginTag+i;
            if (i==0) {
                tabItemLabel.backgroundColor=KTabSelectedFontColor;
            }else{
                tabItemLabel.backgroundColor=[UIColor clearColor];
            }
            [tabItemView addSubview:tabItemLabel];

            
            curTabItemOriginX=curTabItemOriginX+tabItemWidth;
            [tabView addSubview:tabItemView];
        }
    }
}

//构建tableview
- (void)setupTableViewUI{

    _imageTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, KViewTop+_tabViewHeight, _driverViewWidth, _driverViewHeight-_tabViewHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:_imageTableView];
    
    if (_imageListArray &&_imageListArray.count>0) {
        _imageTableView.delegate=self;
        _imageTableView.dataSource=self;
        
        //注册 tableCell
        UINib *imageMutLineNib = [UINib nibWithNibName:@"imageMutLineTableViewCell" bundle:nil];
        [_imageTableView registerNib:imageMutLineNib forCellReuseIdentifier:@"imageMutLineTableViewCell"];
        
        UINib *imageSingleLineNib = [UINib nibWithNibName:@"imageSingleLineTableViewCell" bundle:nil];
        [_imageTableView registerNib:imageSingleLineNib forCellReuseIdentifier:@"imageSingleLineTableViewCell"];
    }
}

#pragma mark 选中某一tabItem 显示图片
- (void)didBtnSelectKanBan:(id)sender{
    
    NSInteger iTag=((UIButton*)sender).tag-KTabViewButtonBeginTag;
    NSString *tagItemString=((UIButton*)[self.view viewWithTag:KTabViewButtonBeginTag+iTag]).titleLabel.text;
    
    for (int i=0; i<=_tabItemArray.count-1; i++) {
        //button
        ((UIButton*)[self.view viewWithTag:KTabViewButtonBeginTag+i]).titleLabel.font=KTabUnSelectedFontSize;
        [((UIButton*)[self.view viewWithTag:KTabViewButtonBeginTag+i ]) setTitleColor:KDefaultFontColor forState:UIControlStateNormal];
        
        //label
        ((UILabel*)[self.view viewWithTag:KTabViewLabelBeginTag+i ]).backgroundColor=[UIColor clearColor];
    }
    //选中
    
    //button
    ((UIButton*)[self.view viewWithTag:KTabViewButtonBeginTag+iTag]).titleLabel.font=KTabSelectedFontSize;
    [((UIButton*)[self.view viewWithTag:KTabViewButtonBeginTag+iTag ]) setTitleColor:KTabSelectedFontColor forState:UIControlStateNormal];
    //label
    ((UILabel*)[self.view viewWithTag:KTabViewLabelBeginTag+iTag ]).backgroundColor=KTabSelectedFontColor;


    //显示对应tab下的图片
    [ViewModelsBase getImageWithTagItemString:tagItemString returnBlock:^(NSArray *imageArray) {
        [_imageListArray removeAllObjects];
        _imageListArray=[imageArray mutableCopy];
        [_imageTableView reloadData];
    }];
    
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {;
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _imageListArray.count;
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView.tag==KLogTableViewTag) {
//        ClassLog *cLogObject=[_logDataArray objectAtIndex:indexPath.row];
//        
//        TbCellLog*logCell;
//        
//        if (!logCell) {
//            logCell=[tableView dequeueReusableCellWithIdentifier:@"TbCellLog"];
//        }
//        //TbCellLog*logCell=[tableView dequeueReusableCellWithIdentifier:@"TbCellLog"];
//        logCell.cLogObject=cLogObject;
//        logCell.btnEdit.tag=indexPath.row;
//        [logCell.btnEdit addTarget:self action:@selector(didBtnEdit:) forControlEvents:UIControlEventTouchUpInside];
//        [logCell initData];
//        logCell.delegate=self;
//        [logCell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        return logCell;
//    }else{
//        //任务数据列表
//        TbCellLogReceiveTask*taskCell=[tableView dequeueReusableCellWithIdentifier:@"TbCellLogReceiveTask"];
//        //taskCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//        ClassLog *cLogObject=[_taskDataArray objectAtIndex:indexPath.row];
//        
//        //判断任务是否已过期(超过一天)
//        NSString *sTaskEndDate=cLogObject.sEndDate;
//        NSTimeInterval timeBetween;
//        if (cLogObject.isOntime) {
//            NSDate *dTaskEndDate=[PublicFunc dateFromString:sTaskEndDate dateFormatterType:DateFromStringTypeYMD];
//            timeBetween=[dTaskEndDate timeIntervalSinceNow];
//        }
//        timeBetween=-timeBetween;
//        if (timeBetween>60*60*24) {
//            taskCell.tbCellTaskTitleLabel.textColor=[UIColor redColor];
//        }else{
//            taskCell.tbCellTaskTitleLabel.textColor=[UIColor darkGrayColor];
//        }
//        
//        taskCell.tbCellTaskTitleLabel.text=cLogObject.sPlanName;
//        taskCell.tbCellTaskFinsihDateLabel.text=sTaskEndDate;
//        taskCell.tbCellTaskPersentLabel.text=[NSString stringWithFormat:@"进度:%@",cLogObject.sProgress];
//        return taskCell;
//    }
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (tableView.tag==KLogTableViewTag) {
//        NSInteger cellRowHeight=0;
//        NSInteger detailControlHeight=30;
//        NSInteger lineHeight=2;
//        NSInteger logTbCellDetailViewWidth;
//        
//        ClassLog *cLogObject=[_logDataArray objectAtIndex:indexPath.row];
//        //只创建一个cell用作测量高度
//        static TbCellLog *logCell = nil;
//        if (!logCell)
//            logCell = [_logTableView dequeueReusableCellWithIdentifier:@"TbCellLog"];
//        logTbCellDetailViewWidth=CGRectGetWidth(logCell.logTbCellDetailView.frame);
//        
//        if (cLogObject.isLogExist || [cLogObject.sLogState integerValue]==LogStateTypeFinished) {
//            //日志内容
//            if (cLogObject.sLogContent) {
//                //标题高度
//                cellRowHeight=cellRowHeight+detailControlHeight;
//                //分隔线
//                cellRowHeight=cellRowHeight+lineHeight;
//                //内容高度
//                NSString *sLogContent=[cLogObject.sLogContent stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
//                cellRowHeight=cellRowHeight+[PublicFunc heightForString:sLogContent font:[UIFont systemFontOfSize:15] andWidth:logTbCellDetailViewWidth];
//            }
//            //上传文件内容
//            if (cLogObject.arrayAccessory) {
//                NSMutableArray *arrayAccessory=[[cLogObject.arrayAccessory copy] objectForKey:@"Result"];
//                if (arrayAccessory.count>0){
//                    //标题高度
//                    cellRowHeight=cellRowHeight+detailControlHeight;
//                    //分隔线
//                    cellRowHeight=cellRowHeight+lineHeight;
//                    //内容
//                    cellRowHeight=cellRowHeight+arrayAccessory.count*detailControlHeight;
//                }
//            }
//            //点评内容
//            if (cLogObject.sEvaluationItemInfo && cLogObject.sEvaluationItemInfo.length>0) {
//                //标题高度
//                cellRowHeight=cellRowHeight+detailControlHeight;
//                //分隔线
//                cellRowHeight=cellRowHeight+lineHeight;
//                //内容
//                NSString *sEvaluationItemInfo=[cLogObject.sEvaluationItemInfo stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
//                cellRowHeight=cellRowHeight+[PublicFunc heightForString:sEvaluationItemInfo font:[UIFont systemFontOfSize:15] andWidth:logTbCellDetailViewWidth];
//            }
//            if (cellRowHeight<=CGRectGetHeight(logCell.logTbCellDetailView.frame)) {
//                cellRowHeight=_fLogRowCellH;
//            }else{
//                cellRowHeight=cellRowHeight+(_fLogRowCellH-CGRectGetHeight(logCell.logTbCellDetailView.frame));
//            }
//        }else{
//            cellRowHeight=_fLogRowCellH;
//        }
//        return cellRowHeight;
//    }else{
//        return _fTaskRowCellH;
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
