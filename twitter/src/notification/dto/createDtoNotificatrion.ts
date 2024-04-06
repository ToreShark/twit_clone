import { IsNotEmpty, IsString } from "class-validator";
import { Types } from "mongoose";

export class CreateNotificationDto {
    @IsString()
    @IsNotEmpty()
    username: string;

    @IsNotEmpty()
    notSenderId: Types.ObjectId;

    @IsNotEmpty()
    notReceiverId: Types.ObjectId;

    @IsString()
    @IsNotEmpty()
    notificationType: string;

    @IsString()
    @IsNotEmpty()
    postText: string;
}