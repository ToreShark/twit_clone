import {Injectable, NotFoundException} from '@nestjs/common';
import {HashingService} from "../iam/hashing/hashing.service";
import {Model} from "mongoose";
import {User} from "../user/schema/user";
import {InjectModel} from "@nestjs/mongoose";
import {Notification} from "./schema/notification.schema";
import {CreateNotificationDto} from "./dto/createDtoNotificatrion";

@Injectable()
export class NotificationService {
    constructor(@InjectModel(Notification.name) private notificationModel: Model<Notification>) {}

    async createNotification(userId: string, createNotificationDto: CreateNotificationDto): Promise<Notification> {
        const newNotification = new this.notificationModel({
            ...createNotificationDto,
            notSenderId: userId, 
        });

        return newNotification.save();
    }
    
    
    // create follow notification with id
    async findNotificationById(id: string): Promise<Notification> {
        const notification = await this.notificationModel.findById(id);
        if (!notification) {
            throw new NotFoundException(`Notification with ID ${id} not found`);
        }
        return notification;
    }
}
