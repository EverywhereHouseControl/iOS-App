//
//  CamViewController.m
//  ehc
//
//  Created by Víctor Vicente on 21/05/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import "CamViewController.h"
#import "IonIcons.h"

@interface CamViewController (){
    UILabel *labelDescription;
    UIButton *buttonSave;
    UIButton *buttonClose;
    UIImageView * image;
    UIImage *imageToSave;
}

@end

@implementation CamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configureWebView{
    NSString *fullURL = [NSString stringWithFormat:@"http://192.168.2.117:8080/stream320.html"];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.cameraWebView loadRequest:requestObj];
}

-(void)configureView{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 320, 30)];
    [label setText:[NSString stringWithFormat:@"%@ House",appDelegate.nameHouse]];
    [label setFont:MY_FONT_WORDS_34];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:MY_COLOR_APP_DARK];
    [self.view addSubview:label];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.973 alpha:1.000]];
    
    labelDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, self.cameraWebView.center.y + self.cameraWebView.frame.size.height/2 + 5, 320, 30)];
    [labelDescription setText:@"You can take a picture. Touch a camera button on the top"];
    [labelDescription setFont:MY_FONT_WORDS];
    [labelDescription setTextAlignment:NSTextAlignmentCenter];
    [labelDescription setTextColor:MY_COLOR_APP_DARK];
    [self.view addSubview:labelDescription];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, self.cameraWebView.center.y + self.cameraWebView.frame.size.height/2 + 40, 50, 50)];
//    [button setImage:[IonIcons imageWithIcon:icon_camera size:30 color:MY_COLOR_APP_DARK] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    buttonSave = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 70, 25)];
    [buttonSave setImage:[IonIcons imageWithIcon:icon_archive size:15 color:MY_COLOR_APP_DARK] forState:UIControlStateNormal];
    [buttonSave setTitle:@"Save" forState:UIControlStateNormal];
    [buttonSave setTitleColor:MY_COLOR_APP_DARK forState:UIControlStateNormal];
    [buttonSave addTarget:self action:@selector(saveGLScreenshotToPhotosAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSave];
    
    buttonClose = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 108, 0, 80, 25)];
    [buttonClose setImage:[IonIcons imageWithIcon:icon_close size:15 color:MY_COLOR_APP_DARK] forState:UIControlStateNormal];
    [buttonClose setTitle:@"Cancel" forState:UIControlStateNormal];
    [buttonClose setTitleColor:MY_COLOR_APP_DARK forState:UIControlStateNormal];
    [buttonClose addTarget:self action:@selector(cancelSave:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonClose];
    
    [buttonClose setHidden:YES];
    [buttonSave setHidden:YES];
    
    image = [[UIImageView alloc] init];
    [image setHidden:YES];
    [self.view addSubview:image];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[IonIcons imageWithIcon:icon_camera size:30 color:[UIColor whiteColor]] style:UIBarButtonItemStyleDone target:self action:@selector(touchButton:)]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"Camera"];
    
    self.cameraWebView = [[UIWebView alloc] initWithFrame:CGRectMake(-10, 0, 340, 320)];
    [self.cameraWebView setCenter:CGPointMake(self.cameraWebView.center.x, self.view.frame.size.height/2)];
    [self.view addSubview:self.cameraWebView];
    [self.cameraWebView setBackgroundColor:[UIColor blackColor]];
    [self configureWebView];
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchButton:(id)sender{
    imageToSave = [self getGLScreenshot];
    [image setImage:imageToSave];
    [image setFrame:CGRectMake(0, 0, 100, 150)];
    //UIView* viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    //[viewBack setBackgroundColor:MY_COLOR_APP_DARK];
    [image setCenter:CGPointMake(self.view.frame.size.width/2, self.cameraWebView.center.y + self.cameraWebView.frame.size.height/2 + (image.frame.size.height/2) + 15)];
    //[viewBack setCenter:CGPointMake(image.center.x, image.center.y)];
    //[self.view addSubview:viewBack];
    [image setHidden:NO];
    
    [buttonClose setCenter:CGPointMake(buttonClose.center.x, image.center.y - 35)];
    [buttonSave setCenter:CGPointMake(buttonSave.center.x, image.center.y - 35)];
    [buttonClose setHidden:NO];
    [buttonSave setHidden:NO];
    
    [labelDescription setHidden:YES];
    
}

- (UIImage*) getGLScreenshot {
    UIGraphicsBeginImageContext(appDelegate.window.bounds.size);
    [self.cameraWebView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imag = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //NSData * data = UIImagePNGRepresentation(image);
    return imag;
    //[data writeToFile:@"foo.png" atomically:YES];
}

- (void)saveGLScreenshotToPhotosAlbum {
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your screen capture is already save" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)cancelSave:(id)sender{
    [image setHidden:YES];
    [buttonSave setHidden:YES];
    [buttonClose setHidden:YES];
    [labelDescription setHidden:NO];
}

@end
