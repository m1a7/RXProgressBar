# RXProgressBar

[![CI Status](http://img.shields.io/travis/m1a7/RXProgressBar.svg?style=flat)](https://travis-ci.org/m1a7/RXProgressBar)
[![Version](https://img.shields.io/cocoapods/v/RXProgressBar.svg?style=flat)](http://cocoapods.org/pods/RXProgressBar)
[![License](https://img.shields.io/cocoapods/l/RXProgressBar.svg?style=flat)](http://cocoapods.org/pods/RXProgressBar)
[![Platform](https://img.shields.io/cocoapods/p/RXProgressBar.svg?style=flat)](http://cocoapods.org/pods/RXProgressBar)

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
    ios 8 or higher
    
## Installation

RXProgressBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RXProgressBar'
```

## RXProgressBar
This is the library can build in your uitableview  complex ProgressBar step by step (like in web).
In a few lines of code, you can easily integrate the RXProgressBar into your project.
In one cell you can insert a field with text and from zero to five photos. 


[iPhone Demo](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/iphone-demo.gif) | [iPad Demo](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/ipad-demo.gif)
------------ | -------------
![alt text](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/iphone-demo.gif) | ![alt text](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/ipad-demo.gif)

# Features
- [x] 🏎️ Quick integration into your table 
- [x] ✳️ Ability to insert multiple instruction into a single uitableview at the same time
- [x] 🗑 Easy to remove cells or entire instructions
- [x] 📊 5 standard UI styles + ability to create your own
- [x] 🎮 Unlimited UI customization options
- [x] 🎚 Dynamic calculations of the height of the cell relative to the text and images
- [x] ⚙️ Automatic frame layout of all photos in a grid
- [x] 🎞 Support for GIF images in the instructions
- [x] 🖼 Ability to open a photo in full screen mode
- [x] 📄 Ability to add up to three text descriptions to a photo
- [x] ⬆️ ⬇️ Supports all orientations (Horizontal / Vertical)
- [x] 📈 Optimized table operation
- [x] 🌋 Fast work on older devices starting from ios 8
- [x] 📋 Examples of implementation on MVC and MVVM.
- [x] 📖 Full documentation


Also choose from five ui styles, or create your own.

| RXProgressBarStyle1 | RXProgressBarStyle2  | RXProgressBarStyle3 |
| ------------|  ------------|  ------------|
|![alt text](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/RXProgressBarStyle1.png)| ![alt text](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/RXProgressBarStyle2.png)| ![alt text](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/RXProgressBarStyle3.png)|
| RXProgressBarStyle4 | RXProgressBarStyle5  | RXProgressBarCustomStyle |
|![alt text](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/RXProgressBarStyle4.png)| ![alt text](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/RXProgressBarStyle5.png)| ![alt text](https://raw.githubusercontent.com/m1a7/RXProgressBar/master/Screens/RXProgressBarCustomStyle.png)|



<br>


## Introduction 🏗

### Step 1. <br>
Import next files in your ViewController

```objectivec
// Cell's ViewModels from RXProgressBar
#import <RXProgressBar/RXBaseViewModelCell.h>
#import <RXProgressBar/RXBeginViewModelCell.h>
#import <RXProgressBar/RXMiddleViewModelCell.h>
#import <RXProgressBar/RXEndViewModelCell.h>

// Cell from RXProgressBar
#import <RXProgressBar/RXBaseCell.h>
#import <RXProgressBar/RXBeginCell.h>
#import <RXProgressBar/RXMiddleCell.h>
#import <RXProgressBar/RXEndCell.h>

// RXProgressBar's main core files
#import <RXProgressBar/RXCollectionPB.h>
#import <RXProgressBar/RXProgressBar.h>
#import <RXProgressBar/RXUIConfig.h>
#import <RXProgressBar/RXIndexPath.h>
```
<br><br>

### Step 2. <br>
Implement the following properties.

```objectivec
@interface TableViewControllerMVC ()
...
@property (nonatomic, strong)  NSMutableArray* dataTableView; // Here store RXProgressBar's viewmodels and own models
@property (nonatomic, strong)  RXCollectionPB* pbCollection;  // Here store the progressbars aka instruction
@property (nonatomic, strong)  NSCache* imageCache;           // Here store cache images from all progressBar
...
@end
```
<br><br>

### Step 3. <br>
Initialize them in a convenient place for you (for example: - init or-viewDidLoad)

```objectivec
    ...
    self.dataTableView = [NSMutableArray array];
    self.pbCollection  = [RXCollectionPB new];
    self.imageCache    = [[NSCache alloc] init];
    ...
```
<br><br>

### Step 4. <br>
Override the -didReceiveMemoryWarning method.  In case of a call, it will clear the cache with photos.

```objectivec
-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.imageCache removeAllObjects];
}
```
<br><br>

### Step 5. <br>

RXProgressBar is an account manager with cells. You can transfer the data models which confrom  "RXInstructionModelProtocol" protocol to the RXProgressBar after that, it will do all the work for you.
Object which conform this protocol, must have next properties:

```json
    {
        "instruction" : "Wash the pumpkin",
            "images" : [
                        {
                        "url"     : "https:///site.com/1.jpg",
                        "title"   : "Pumplin ",
                        "summary" : "it should be bright",
                        "credit"  : "Wash and wipe the pumpkin dry"
                        },

                        {
                        "url"     : "https:///site.com/2.jpg",
                        "title"   : "Pumplin ",
                        "summary" : "it should be bright",
                        "credit"  : "Wash and wipe the pumpkin dry"
                        }
                     ]
        }
```
<br><br>

Create model object which confrom this protocol and implement next properties:

```objectivec
#import "RXInstructionModelProtocol.h"

@interface RXInstructionModel : NSObject <RXInstructionModelProtocol>

@property (nonatomic, strong) NSString* instruction;
@property (nonatomic, strong) NSArray<id<RXInstructionImgModelProtocol >>* imagesURL;

- (instancetype)initWithInstruction:(NSString*) instruction
                        withImgsURL:(NSArray<id<RXInstructionImgModelProtocol>>*)imgArr;

- (instancetype)initWithInstruction:(NSString*) instruction
                     withMixArrImgs:(NSArray*)imgArr;

@end
```
<br><br>

### Step 6. <br>

Create and call a method that contains the following strings

* Create array with model which conform with protocol "RXInstructionModelProtocol"
* Create RXProgressBar object
* Create UIConfig      object
* Call -createVMfromModelsArray method and get ViewModel from your array with protocol objects
* Save these objects (viewmodels) in your ViewController or (if you use MVVM pattern, then in your ViewModel)
* Add RXProgressBar to self.pbCollection

```objectivec
{
...

// Get array with object which conform with protocol "RXInstructionModelProtocol"
NSArray<id<RXInstructionModelProtocol>>* dataForFirstInstruction = [DataBuilder createPumkinInstruction];

// Create first RXProgressBar(aka."Instruction") with reference on RXCollectionPB (aka. "super collection")
RXProgressBar* firstInstruction = [[RXProgressBar alloc] initWithCollectionPB:  self.pbCollection addAdditionalBeginAndEndCells: YES];

// Select ui style for our RXProgressBar
firstInstruction.configUI       = [[RXUIConfig alloc]    initConfigWithStyle: RXProgressBarStyle3];

// Transform (object which conform with protocol "RXInstructionModelProtocol") to -> RXProgressBar's private viewmodel's cells
NSArray* arrVMFromFirstBar      = [firstInstruction createVMfromModelsArray: dataForFirstInstruction withRefOnImgCache:self.imageCache];

// Add these viewmodels to tableview datasource array
[self.dataTableView addObjectsFromArray: arrVMFromFirstBar];
[self.pbCollection addPB: firstInstruction];

...
}
```
<br><br>

### Step 7. <br>

Implement or modify the following methods

#### -heightForRowAtIndexPath
```objectivec
 
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 40.f;
    // Get viewmodel from our datasource array
    id vm = [self.dataTableView objectAtIndex:indexPath.row];
    
    // depending on what kind of viewModel, will calculate the unique height
    if ([vm isKindOfClass:[RXBaseViewModelCell class]])
    {
        Class classOfCell = [RXBaseCell class];
        RXBaseViewModelCell* convetVM = (RXBaseViewModelCell*)vm;
        
        if ([convetVM isMemberOfClass:[RXBeginViewModelCell  class]]) classOfCell = [RXBeginCell  class];
        if ([convetVM isMemberOfClass:[RXMiddleViewModelCell class]]) classOfCell = [RXMiddleCell class];
        if ([convetVM isMemberOfClass:[RXEndViewModelCell    class]]) classOfCell = [RXEndCell    class];
        
        height = [classOfCell calculateHeightByUIConfig:convetVM.progressBar.configUI
                                                 withVM:vm
                                     withSuperViewWidth:CGRectGetWidth(self.tableView.frame)];
    }
    return roundf(height);
}
```

#### -cellForRowAtIndexPath

```objectivec
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell;
    NSString* identifier = [self getClassNameByViewModelCell:[self.dataTableView objectAtIndex:indexPath.row]];
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[NSClassFromString(identifier) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
```

#### -getClassNameByViewModelCell

```objectivec
- (NSString*) getClassNameByViewModelCell:(id) viewmodel
{
    NSString* identifier;
    if ([viewmodel isKindOfClass:[RXBeginViewModelCell  class]])  identifier = NSStringFromClass([RXBeginCell  class]);
    if ([viewmodel isKindOfClass:[RXMiddleViewModelCell class]])  identifier = NSStringFromClass([RXMiddleCell class]);
    if ([viewmodel isKindOfClass:[RXEndViewModelCell    class]])  identifier = NSStringFromClass([RXEndCell    class]);
    
    if (!identifier)
        identifier = NSStringFromClass([viewmodel class]);
    return identifier;
}
```

#### -willDisplayCell
```objectivec
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
       [self configureCell:cell atIndexPath:indexPath];
}
```
 <br> <br>

### Step 8. <br>
Implement this method -configureCell or add its code to your similar method.

```objectivec
- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath
{  
    if ([cell isMemberOfClass:[RXBeginCell class]])
    {
        RXBeginCell* convertCell = (RXBeginCell*)cell;
        if (![convertCell.vm_cell isEqual:[self.dataTableView objectAtIndex:indexPath.row]]){
              convertCell.vm_cell = [self.dataTableView objectAtIndex:indexPath.row];
        }
    }

    if ([cell isMemberOfClass:[RXMiddleCell class]])
    {
        RXMiddleCell* convertCell = (RXMiddleCell*)cell;
        
                if (![convertCell.vm_cell isEqual:[self.dataTableView objectAtIndex:indexPath.row]]){
                
                    convertCell.vm_cell.actualCalculationsForWidth = 0;
                    convertCell.vm_cell.actualCalculationsForHeight = 0;
                    
                    for (NSURLSessionDownloadTask* task in convertCell.vm_cell.arrConnection) {
                        [task cancel];
                    }
                    [convertCell.vm_cell.arrConnection removeAllObjects];
                    [convertCell cancelAllRequest];
                    convertCell.vm_cell   =  [self.dataTableView objectAtIndex:indexPath.row];
                }
                [convertCell.vm_cell.imageOperationQueue setSuspended:NO];
    }

    if ([cell isMemberOfClass:[RXEndCell class]])
    {
        RXEndCell* convertCell = (RXEndCell*)cell;
        if (![convertCell.vm_cell isEqual:[self.dataTableView objectAtIndex:indexPath.row]]){
             convertCell.vm_cell   =      [self.dataTableView objectAtIndex:indexPath.row];
        }
        [convertCell setupColors:convertCell.vm_cell andFrameSuperView:convertCell.contentView.frame andIndexInArray:0];
    }
}
```
<br>

### Step 9. ✨✨✨
You're done ! Now you can start and see how it works. 
If you encounter errors, open the test project and copy the code from there


<br><br>


## Things to do in future releases
- On older devices work with FLAnimatedImage doesn't look impressive. 
  Idea for next version is to replace the FLAnimatedImage or to another library or to own. 
- To make a class diagram.
- Write wiki




## Author 👨‍💻 🏊 ✋

m1a7, thisismymail03@gmail.com

## License

RXProgressBar is available under the MIT license. See the LICENSE file for more info.
