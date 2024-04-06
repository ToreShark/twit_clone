import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ collection: 'Users', timestamps: true })
export class User extends Document {
    @Prop({ required: true, trim: true })
    name: string;

    @Prop({ required: true, trim: true, unique: true })
    username: string;

    @Prop({
        required: true,
        trim: true,
        unique: true,
        lowercase: true,
        validate: {
            validator: (value: string) => /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(value),
            message: 'Please fill a valid email address',
        }
    })
    email: string;

    @Prop({ required: true })
    password: string;

    @Prop({ type: Buffer })
    avatar: Buffer;

    @Prop({ default: false })
    avatarExists: boolean;

    @Prop()
    bio: string;

    @Prop()
    website: string;

    @Prop()
    location: string;

    @Prop({ type: [{ type: Types.ObjectId, ref: 'User' }] })
    followers: Types.ObjectId[];

    @Prop({ type: [{ type: String, required: true }] })
    tokens: string[];

    @Prop({ type: [{ type: Types.ObjectId, ref: 'User' }] })
    followings: Types.ObjectId[];
    toJSON() {
        const userObject = this.toObject();
        delete userObject.password;
        delete userObject.tokens;
        return userObject;
    }
}

export const UserSchema = SchemaFactory.createForClass(User);

UserSchema.virtual('tweets', {
    ref: 'Tweet',  
    localField: '_id',  
    foreignField: 'userId',  
});

UserSchema.virtual('notificationsSend', {
    ref: 'Notification',
    localField: '_id',
    foreignField: 'notSenderId',
});

UserSchema.virtual('notificationsReceive', {
    ref: 'Notification',
    localField: '_id',
    foreignField: 'notReceiverId',
});