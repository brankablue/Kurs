//
//  TaskTableViewCell.m
//  ToDo
//
//  Created by Kurs on 3/3/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (void)setTask:(DBTask *)task {
    _task = task;
    
    self.titleLabel.text = task.title;
    self.descriptionLabel.text = task.desc;
    self.groupView.backgroundColor = [task groupColor];
}

@end
