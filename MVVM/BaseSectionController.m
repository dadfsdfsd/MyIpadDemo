//
//  AnonymousSectionController.m
//  MyIpadDemo
//
//  Created by yangfan on 2018/1/8.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "BaseSectionController.h"
#import "BaseCollectionViewCell.h"

@interface IGListBindingSectionController()<IGListSupplementaryViewSource>

@property (nonatomic, strong, readwrite) NSArray<id<IGListDiffable>> *viewModels;

@property (nonatomic, strong) id object;

@end

@implementation BaseSectionController

- (instancetype)initWithCellModelToCell:(NSDictionary<NSString *, Class> *)dictionary selectionDelegate:(id<IGListBindingSectionControllerSelectionDelegate>)delegate {
    if (self = [super init]) {
        _cellModel2Cell = dictionary;
        self.dataSource = self;
        self.supplementaryViewSource = self;
        self.selectionDelegate = delegate;
    }
    return self;
}

- (nonnull UICollectionViewCell<IGListBindable> *)sectionController:(nonnull IGListBindingSectionController *)sectionController cellForViewModel:(nonnull id)viewModel atIndex:(NSInteger)index {
    BaseCellModel *cellModel = (BaseCellModel *)viewModel;
    BaseCollectionViewCell *collectionViewCell = [self.collectionContext dequeueReusableCellOfClass:_cellModel2Cell[[cellModel.class cellIdentifier]] forSectionController:self atIndex:index];
    collectionViewCell.delegate = self;
    return collectionViewCell;
}

- (CGSize)sectionController:(nonnull IGListBindingSectionController *)sectionController sizeForViewModel:(nonnull id)viewModel atIndex:(NSInteger)index {
    BaseCellModel *cellModel = (BaseCellModel *)viewModel;
    return [cellModel expectedSizeForContainerSize:self.collectionContext.containerSize];
}

- (nonnull NSArray<id<IGListDiffable>> *)sectionController:(nonnull IGListBindingSectionController *)sectionController viewModelsForObject:(nonnull id)object {
    if ([object isKindOfClass:[BaseSectionModel class]]) {
        BaseSectionModel *sectionModel = (BaseSectionModel *) object;
        return sectionModel.cellModels;
    }
    return [NSArray<id<IGListDiffable>> new];
}

- (void)didUpdateToObject:(id)object {
    id oldObject = self.object;
    self.object = object;
    
    if (oldObject == nil) {
        self.viewModels = [self.dataSource sectionController:self viewModelsForObject:object];
    } else {
        [self updateAnimated:YES completion:nil];
    }
    if ([object isKindOfClass:[BaseSectionModel class]]) {
        BaseSectionModel *sectionModel = (BaseSectionModel *)object;
        self.inset = sectionModel.inset;
        self.minimumInteritemSpacing = sectionModel.minimumInteritemSpacing;
        self.minimumLineSpacing = sectionModel.minimumLineSpacing;
    }
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
    if ([self.object isKindOfClass:[BaseSectionModel class]]) {
        BaseSectionModel *sectionModel = (BaseSectionModel *)self.object;
        if (elementKind == UICollectionElementKindSectionHeader && sectionModel.headerCell != nil) {
            BaseCellModel *headerCell = sectionModel.headerCell;
            return [headerCell expectedSizeForContainerSize:self.collectionContext.containerSize];
        }
        else if (elementKind == UICollectionElementKindSectionFooter && sectionModel.footerCell != nil) {
            BaseCellModel *footerCell = sectionModel.footerCell;
            return [footerCell expectedSizeForContainerSize:self.collectionContext.containerSize];
        }
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
    if ([self.object isKindOfClass:[BaseSectionModel class]]) {
        BaseSectionModel *sectionModel = (BaseSectionModel *)self.object;
        if (elementKind == UICollectionElementKindSectionHeader && sectionModel.headerCell != nil) {
            BaseCollectionViewCell *cell = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:_cellModel2Cell[[sectionModel.headerCell.class cellIdentifier]] atIndex:index];
            [cell bindCellModel:sectionModel.headerCell];
            return cell;
        }
        else if (elementKind == UICollectionElementKindSectionFooter && sectionModel.footerCell != nil) {
            BaseCollectionViewCell *cell = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:_cellModel2Cell[[sectionModel.footerCell.class cellIdentifier]] atIndex:index];
            [cell bindCellModel:sectionModel.footerCell];
            return cell;
        }
    }
    return nil;
}

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionHeader, UICollectionElementKindSectionFooter];
}


@end
