import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema({ collection: 'Tweets', timestamps: true })
export class Tweet extends Document {
    @Prop({ required: true })
    text: string;

    @Prop({ type: Types.ObjectId, ref: 'User', required: true })
    userId: Types.ObjectId;

    @Prop({ required: true })
    username: string;

    @Prop({ type: Buffer })
    image: Buffer;

    @Prop({ type: [{ type: Types.ObjectId, ref: 'User' }] })
    likes: Types.ObjectId[];
}

const TweetSchema = SchemaFactory.createForClass(Tweet);

TweetSchema.methods.toJSON = function() {
    const tweet = this;
    const tweetObject = tweet.toObject();
    tweetObject.hasImage = !!tweetObject.image;
    return tweetObject;
};

export { TweetSchema };