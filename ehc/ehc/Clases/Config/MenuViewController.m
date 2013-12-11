//
//  MenuViewController.m
//  TriviSeries
//
//  Created by KINKI on 5/14/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"
#import "AppDelegate.h"
#import "MenuHeaderCell.h"
#import "MenuCell.h"
#import "defs.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSArray *menu;
@property (strong, nonatomic) NSArray *section1;
@property (strong, nonatomic) NSArray *section2;
@property (strong, nonatomic) NSArray *section3;
@property (strong, nonatomic) NSArray *section4;

@end

@implementation MenuViewController
@synthesize menu, section1, section2;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //[self.tableView registerNib:[UINib nibWithNibName:@"celdaMenu" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"celdaMenuID"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
   // appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.section1 = [NSArray arrayWithObjects:@"Perfil", @"Ajustes",@"Eventos", @"Historial", @"Ayuda", nil];
    
    self.section2 = [NSArray arrayWithObjects:@"Salir", nil];
    
    self.menu = [NSArray arrayWithObjects:self.section1, self.section2, nil];
    
    [self.slidingViewController setAnchorRightRevealAmount:200.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [self.menu count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (section == 1) {
        
        return [self.section1 count];
        
    } else if (section == 2) {
        
        return [self.section2 count];
        
    }
    
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return @"";
        
    } else if (section == 1) {
        
        return @"Config";
        
    } else if (section == 2) {
        
        return @"Hasta pronto";
        
    }
    return @"Other";
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MenuHeaderCell *v = [[MenuHeaderCell alloc] init];
    if (section == 0) {
        
       v.titleLabel.text = @"";
        
    } else if (section == 1) {
        
       v.titleLabel.text = @"Config";
    } else if (section == 2) {
        
        v.titleLabel.text = @"Other";
    }
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int fila = indexPath.row;
    int section = indexPath.section;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    MenuCell *celda = [[MenuCell alloc] init];
    if (section == 0) {
        
        
        
    } else if (section == 1) {
        
        if (fila == 0) {
            celda.titleLabel.text = @" Perfil";
            celda.icono = @"icoPerfil.png";
        }
        else if (fila == 1){
            celda.titleLabel.text = @" Ajustes";
            celda.icono = @"icoAjustes.png";
        }
        else if (fila == 2){
            celda.titleLabel.text = @" Eventos";
            celda.icono = @"icoMarket.png";
        }
        else if (fila == 3){
            celda.titleLabel.text = @" Historial";
            celda.icono = @"icoRanking.png";
        }
        else{
            celda.titleLabel.text = @" Ayuda";
            celda.icono = @"icoAyuda.png";
        }
        
    } else if (section == 2) {
        
        celda.titleLabel.text = @"Salir";
    }
    
    cell.backgroundView = celda;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    [v setBackgroundColor:[UIColor clearColor]];
    cell.selectedBackgroundView = v;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    UIViewController *newTopViewController;
    
    if (indexPath.section == 1) {
        
        NSString *identifier;
        
        if (appDelegate.window.frame.size.height == 1024){
            
            identifier = [NSString stringWithFormat:@"%@Ipad", [self.section1 objectAtIndex:indexPath.row]];
            
            newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        }
        else if (appDelegate.window.frame.size.height == 568){
            
            identifier = [NSString stringWithFormat:@"%@5", [self.section1 objectAtIndex:indexPath.row]];
            
            newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        }
        else {
            
            identifier = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
            
            newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        }
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = newTopViewController;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
        }];
        
    } else if (indexPath.section == 3) {
        
        NSString *b = @"";
        NSString *c = @"";
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:b,KEY_PWD,c,KEY_USER,nil];
        [dic writeToFile:[self rutaFicheroVar] atomically:YES];
        //[self postLeaveRequest];
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"initViewController"]];
       
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = newTopViewController;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
        }];
    }
    
    

}

-(NSString *)rutaFicheroVar{
    NSArray *rutas =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSLog(@"Directorios: %@",rutas);
    
    NSString *directorio = [rutas objectAtIndex:0];
    
    rutas = nil;
    
    return [directorio stringByAppendingPathComponent:ficheroVar];
}

-(void)llamarAperfil{
    
    UIViewController *newTopViewController;
    
    NSString *identifier;
    
    if (appDelegate.window.frame.size.height == 1024){
        
        identifier = [NSString stringWithFormat:@"PerfilIpad"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else if (appDelegate.window.frame.size.height == 568){
        
        identifier = [NSString stringWithFormat:@"Perfil5"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else {
        
        identifier = [NSString stringWithFormat:@"Perfil"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}

-(void)llamarAajustes{
    
    UIViewController *newTopViewController;
    
    NSString *identifier;
    
    if (appDelegate.window.frame.size.height == 1024){
        
        identifier = [NSString stringWithFormat:@"AjustesIpad"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else if (appDelegate.window.frame.size.height == 568){
        
        identifier = [NSString stringWithFormat:@"Ajustes5"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else {
        
        identifier = [NSString stringWithFormat:@"Ajustes"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}


-(void)llamarAdetallesCuenta{
    
    UIViewController *newTopViewController;
    
    NSString *identifier;
    
    if (appDelegate.window.frame.size.height == 1024){
        
        identifier = [NSString stringWithFormat:@"DetallesCuentaIpad"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else if (appDelegate.window.frame.size.height == 568){
        
        identifier = [NSString stringWithFormat:@"DetallesCuenta5"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else {
        
        identifier = [NSString stringWithFormat:@"DetallesCuenta"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}

-(void)llamarAinicio{
    
    UIViewController *newTopViewController;
    
    NSString *identifier;
    
    if (appDelegate.window.frame.size.height == 1024){
        
        identifier = [NSString stringWithFormat:@"UserIpad"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else if (appDelegate.window.frame.size.height == 568){
        
        identifier = [NSString stringWithFormat:@"User5"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else {
        
        identifier = [NSString stringWithFormat:@"User"];
        
        newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}



@end
