import { Module } from '@nestjs/common';
import { NotificationService } from './notification.service';
import { NotificationController } from './notification.controller';
import {User, UserSchema} from "../user/schema/user";
import {Notification, NotificationSchema} from "./schema/notification.schema";
import {MongooseModule} from "@nestjs/mongoose";

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Notification.name, schema: NotificationSchema },
      { name: User.name, schema: UserSchema },
    ]),
  ],
  providers: [NotificationService],
  controllers: [NotificationController]
})
export class NotificationModule {}
