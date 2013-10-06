//
//  KLViewController.m
//  Klopy
//
//  Created by Cameron Ehrlich on 10/5/13.
//  Copyright (c) 2013 Cameron Ehrlich. All rights reserved.
//

#import "KLViewController.h"
#import "KLModel.h"


@interface KLViewController ()



@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)add:(id)sender;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[[KLModel sharedInstance] api] setDelegate:self];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[KLModel sharedInstance] api] update];
}


#pragma mark -UITableviewDelegate/Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[KLModel sharedInstance] api].clippings.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    [cell.textLabel setText:[[[[KLModel sharedInstance] api].clippings objectAtIndex:indexPath.row] content]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *newString = [[[[KLModel sharedInstance] api].clippings objectAtIndex:indexPath.row] content];
    NSLog(@"%@", newString);
    [[UIPasteboard generalPasteboard] setString:newString];
}


-(void)api:(KLAPI *)api didReceiveUpdate:(NSDictionary *)info{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
