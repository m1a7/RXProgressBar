//
//  RXInstructionModelProtocol.h
//  RXProgressBar
//
//  Created by Uber on 26/02/2018.
//

#import <Foundation/Foundation.h>
#import "RXInstructionImgModelProtocol.h"


// Model of json
/*
{
 instruction : "Wash the pumpkin",
    images : [
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
*/

/*
   Этот протокол - модилирование того что может прийти в RXMiddleCell.
   По факту в ячейки есть label (в json'e это поле instruction).
 
   И массив фотографий (каждая фото объект отвечающий протоколу RXInstructionImgModelProtocol).
   Это протокол нужен для того, что бы была возможность поддержки подписи (title/summary/сredit)
   под фотографией.
   /////
   Данный протокол нужен при создании условий для работы RXProgressBar.
   Точнее RXProgressBar пройдется по массиву который ему передали через метод -createVMfromModelsArray.
   В нем найдет все объекты котрые поддеживают данный проткол и создадим с помощью них ВьюМодели
   RXMiddleViewModelCell.
 
 ========
 The Protocol simulation that may come in RXMiddleCell.
 In fact, there is a label in the cell (in JSON'e this is the instruction field).
 
 And an array of photos (each photo object meets the Protocol RXInstructionImgModelProtocol).
 This Protocol is needed in order to be able to support the signature (title / summary/credit)
 under the photo.
 
 /////
 
 This Protocol is needed to create conditions for RXProgressBar.
 More precisely RXProgressBar pass through the array which he handed through the method -createVMfromModelsArray.
 It will find all the objects that support this Protocol and create them with the help of Models
 RXMiddleViewModelCell.
 
 */

@protocol RXInstructionModelProtocol <NSObject>

@required
@property (nonatomic, strong) NSString* instruction;
@property (nonatomic, strong) NSArray<id< RXInstructionImgModelProtocol >>* imagesURL;

@end
