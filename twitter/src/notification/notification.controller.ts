import {Body, Controller, Get, HttpException, HttpStatus, Param, Post, Req} from '@nestjs/common';
import {NotificationService} from "./notification.service";
import {CreateNotificationDto} from "./dto/createDtoNotificatrion";
import {REQUEST_USER_KEY} from "../iam/iam.constants";

@Controller('notification')
export class NotificationController {
    constructor(private readonly notificationService: NotificationService) {}
    @Post()
    async createNotification(@Body() createNotificationDto: CreateNotificationDto, @Req() req: any) {
        const userPayload = req[REQUEST_USER_KEY];
        if (!userPayload) {
            throw new HttpException("User data not found in request", HttpStatus.FORBIDDEN);
        }
        const userId = userPayload.sub; 

        return this.notificationService.createNotification(userId, createNotificationDto);
    }
    @Get(':id')
    async getNotification(@Param('id') id: string) {
        return this.notificationService.findNotificationById(id);
    }
}
