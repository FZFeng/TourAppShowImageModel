#import "ViewControllerImageBrowse.h"

@interface ViewControllerImageBrowse ()<UIScrollViewDelegate>{
    
    //变量
    BOOL _bDidLayoutSubviews;
    NSInteger _imageListScrolWidth;
    NSInteger _imageListScrolHeight;

    //UIView
    IBOutlet UIScrollView *_imageListScroll;
    IBOutlet UIPageControl *_imageListPage;
    IBOutlet UILabel *_imageListPageIndexLabel;

}

@end

@implementation ViewControllerImageBrowse

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 代码构建UI
- (void)setupUI{
    _imageListScroll.bounces=NO;
    _imageListScroll.delegate=self;
    _imageListScroll.scrollEnabled=YES;
    _imageListScroll.pagingEnabled=YES;
    _imageListScroll.showsHorizontalScrollIndicator=NO;
    _imageListScroll.showsVerticalScrollIndicator=NO;
    _imageListPage.numberOfPages=self.imageNameArray.count;
    
    _imageListPageIndexLabel.text=[NSString stringWithFormat:@"1/%d",self.imageNameArray.count];
    
    //添加关闭窗体button
    UIButton *btnClose=[UIButton buttonWithType:UIButtonTypeCustom];
    btnClose.frame=self.view.frame;
    [btnClose addTarget:self action:@selector(didBtnCloseView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClose];
}

-(void)viewDidLayoutSubviews{
    if (!_bDidLayoutSubviews) {
        _bDidLayoutSubviews=YES;
        _imageListScrolWidth=CGRectGetWidth(_imageListScroll.frame);
        _imageListScrolHeight=CGRectGetHeight(_imageListScroll.frame);
        _imageListScroll.contentSize=CGSizeMake(self.imageNameArray.count*_imageListScrolWidth, _imageListScrolHeight);
        
        for (int i=0; i<=self.imageNameArray.count-1; i++) {
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(_imageListScrolWidth*i, 0,_imageListScrolWidth, _imageListScrolHeight)];
            NSString *sImagePath=[self.imageNameArray objectAtIndex:i];
            imageView.image=[UIImage imageNamed:sImagePath];
            [_imageListScroll addSubview:imageView];
        }
    }
}

#pragma mark 关闭界面
-(void)didBtnCloseView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIScrollViewDelegate 划动事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    NSInteger curImagePageIndex=scrollView.contentOffset.x/_imageListScrolWidth;
    [_imageListPage setCurrentPage:curImagePageIndex];
    //当前页
    _imageListPageIndexLabel.text=[NSString stringWithFormat:@"%d/%d",curImagePageIndex+1,self.imageNameArray.count];
    
}


@end
