#import "ViewController.h"

#define KTabSelectedFontColor [UIColor orangeColor]
#define KTabSelectedFontSize [UIFont systemFontOfSize:14];
#define KTabUnSelectedFontSize [UIFont systemFontOfSize:16];
#define KViewTop 20
#define KImageCellImageListGap 10
#define KNumberOfImagePerLine  3

#define KTabViewButtonBeginTag 100
#define KTabViewLabelBeginTag  200

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{

    //变量
    NSArray *_tabItemArray;       //tab的集合数组(景点,美食,酒店,交通,购物,娱乐)
    NSInteger _driverViewHeight;  //设备view的高度
    NSInteger _driverViewWidth;   //设备ivew的宽度
    NSInteger _tabViewHeight;     //tab集合的高度
    NSInteger _tabItemLabelHeight; //tab选中label的高度
    NSInteger _tabItemLableGapToView;         //tab选中label离view的边距
    NSInteger _imageCellHeight;               //cell的高度
    NSInteger _imageCellImageListViewHeight;  //cell中imagelistView的高度
    NSInteger _imageCellImageListViewWidth;   //cell中imagelistView的宽度
    NSMutableArray *_imageListArray;          //获取的图片数据
    
    
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
    _imageCellHeight=0;
    _imageCellImageListViewHeight=0;
    _imageCellImageListViewWidth=0;
    
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
        _imageTableView.sectionFooterHeight=5;
        _imageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //注册 tableCell
        UINib *imageMutLineNib = [UINib nibWithNibName:@"imageMutLineTableViewCell" bundle:nil];
        [_imageTableView registerNib:imageMutLineNib forCellReuseIdentifier:@"imageMutLineTableViewCell"];
        
        imageMutLineTableViewCell *imageCell=[_imageTableView dequeueReusableCellWithIdentifier:@"imageMutLineTableViewCell"];
        _imageCellHeight=CGRectGetHeight(imageCell.frame);
        _imageCellImageListViewHeight=CGRectGetHeight(imageCell.imageListView.frame);
        _imageCellImageListViewWidth=CGRectGetWidth(imageCell.imageListView.frame);
        
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
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _imageListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    imageMutLineTableViewCell *imageCell=[tableView dequeueReusableCellWithIdentifier:@"imageMutLineTableViewCell"];
    imageCell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //新除旧内容
    imageCell.titleLabel.text=@"";
    imageCell.numLabel.text=@"";
    
    for (UIView *subView in imageCell.imageListView.subviews) {
        [subView removeFromSuperview];
    }
    
    //标题
    NSString *titleSting=[[_imageListArray objectAtIndex:indexPath.section] objectForKey:@"title"];
    imageCell.titleLabel.text=titleSting;
    //页数
    NSArray *imageArray=[[_imageListArray objectAtIndex:indexPath.section] objectForKey:@"image"];
    imageCell.numLabel.text=[NSString stringWithFormat:@"共%lu页",(unsigned long)imageArray.count];
    //图片
    //计算每个图片的宽度
    NSInteger imageWidth=(_imageCellImageListViewWidth-(KNumberOfImagePerLine-1)*KImageCellImageListGap)/KNumberOfImagePerLine;
    NSInteger curOriginX=0;
    NSInteger curOriginY=0;
    NSString *imageNameString;//图片名称
    
    for (int i=0; i<=imageArray.count-1; i++) {
        curOriginX= i % KNumberOfImagePerLine;
        curOriginY= (i / KNumberOfImagePerLine)%(KNumberOfImagePerLine-1);
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(curOriginX*(imageWidth+KImageCellImageListGap), curOriginY*(_imageCellImageListViewHeight+KImageCellImageListGap), imageWidth, _imageCellImageListViewHeight)];
        imageNameString=[imageArray objectAtIndex:i];
        imageView.image=[UIImage imageNamed:imageNameString];
        [imageCell.imageListView addSubview:imageView];
    }
    
    return imageCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(dispatch_get_main_queue(), ^{
        ViewControllerImageBrowse *imageBrowseViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerImageBrowse"];
        imageBrowseViewController.imageNameArray=[[_imageListArray objectAtIndex:indexPath.section] objectForKey:@"image"];
        [self presentViewController:imageBrowseViewController animated:YES completion:nil];
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *imageArray=[[_imageListArray objectAtIndex:indexPath.section] objectForKey:@"image"];
    
    if (imageArray.count>3) {
        //超过三张图片就换两行
        return _imageCellHeight+_imageCellImageListViewHeight+KImageCellImageListGap;
    }else{
        return _imageCellHeight;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
