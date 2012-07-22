//
//  TableViewController.m
//
//  Created by Marco Pizzichemi on 30/06/12.
//  Copyright (c) 2012 -. All rights reserved.
//

#import "TableViewController.h"
//#import "DetailsViewController.h"

@implementation TableViewController

@synthesize  people, tableView;

- (void)viewDidLoad 
{
	[[UIBarButtonItem appearance] setTintColor:[UIColor greenColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    
    NSURL *url =[NSURL URLWithString:@"https://api.twitter.com/1/users/suggestions/twitter.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; 
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        NSDictionary *dataObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        //NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        //self.people = [NSArray arrayWithObjects:@"hi", @"wow", @"pop", @"hot", nil];
        
        self.people = [dataObject objectForKey:@"users"];
        
        [self.tableView reloadData];
        
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.people count];
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellAccessoryDetailDisclosureButton;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    //NSString *person = [self.people objectAtIndex:indexPath.row];
    // Set up the cell...
    NSDictionary *person = [self.people objectAtIndex:indexPath.row];
    cell.textLabel.text = [person objectForKey:@"name"];
    
    NSURL *imageURL = [NSURL URLWithString:[person objectForKey:@"profile_image_url"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        UIImage *image = [UIImage imageWithData:data];
        
        UITableViewCell *aCell = [self.tableView cellForRowAtIndexPath:indexPath];
        aCell.imageView.image = image;
        
        [aCell setNeedsLayout];
    }];
    
    
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"didSelectRowAtIndexPath\n");
    
	DetailsViewController *detailController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
	[self.navigationController pushViewController:detailController animated:YES];
    
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic -- create and push a new view controller
	//Keep track of the row selected.
	//selectedIndexPath = indexPath;
	
	if(detailController == nil) 
		detailController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
	
	/*Object being edited.
	
	NSDictionary *dictionary = [appDelegate.listOfItems objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"distanza"];
	//NSString *cellValue = [array objectAtIndex:indexPath.row];
	//cell.text = cellValue;
	
	//CELLA PERSONALIZZATA
	//Evento *eventoObj = [appDelegate.festeVicineArray objectAtIndex:indexPath.row];
	Evento *eventoObj = [array objectAtIndex:indexPath.row];
	NSLog(@"indice immagine prima: %@", eventoObj.eventoImmagine);
	[eventoObj hydrateDetailViewData];
	//NSLog(@"indice immagine dopo: %@", eventoObj.eventoImmagine);
	
	dettagli.eventoDettaglioObj = eventoObj;
	*/
	
	[self.navigationController pushViewController:detailController animated:YES];
	
}


@end
