import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ collection: 'Notifications', timestamps: true })
export class Notification extends Document {
    @Prop({ required: true })
    username: string;

    @Prop({ type: Types.ObjectId, required: true, ref: 'User' })
    notSenderId: Types.ObjectId;

    @Prop({ type: Types.ObjectId, required: true, ref: 'User' })
    notReceiverId: Types.ObjectId;

    @Prop({ required: true })
    notificationType: string;

    @Prop({ required: true })
    postText: string;
}

export const NotificationSchema = SchemaFactory.createForClass(Notification);