import {BadRequestException, Injectable, NotFoundException} from '@nestjs/common';
import {InjectModel} from "@nestjs/mongoose";
import {Tweet} from "./schema/tweet";
import {Model, Types} from "mongoose";
import * as sharp from 'sharp';

@Injectable()
export class TweetService {
    constructor(
        @InjectModel(Tweet.name) private tweetModel: Model<Tweet>
    ) {}
    async createTweet(text: string, userId: string, username?: string): Promise<Tweet> {
        const newTweet = new this.tweetModel({
            text,
            userId,
            username // убедитесь, что поле username присутствует в схеме Tweet
        });

        return newTweet.save();
    }
    // create fetch all tweets method
    async fetchAllTweets(): Promise<Tweet[]> {
        return this.tweetModel.find().exec();
    }
    // create fetch a spicific users tweets method
    async fetchUserTweets(userId: string): Promise<Tweet[]> {
        return this.tweetModel.find({ userId }).exec();
    }
    
    async updateTweetImage(tweetId: string, fileBuffer: Buffer): Promise<Tweet> {
        const tweet = await this.tweetModel.findById(tweetId);

        if (!tweet) {
            throw new NotFoundException(`Tweet with ID ${tweetId} not found`);
        }
        if (!fileBuffer || fileBuffer.length === 0) {
            throw new Error('File buffer is empty or invalid');
        }

        const resizedBuffer = await sharp(fileBuffer)
            .rotate()
            .resize({ width: 350, height: 350 })
            .png()
            .toBuffer();

        tweet.image = resizedBuffer;

        await tweet.save();

        return tweet;
    }
    // create fetch tweet image
    async fetchTweetImage(tweetId: string): Promise<Buffer> {
        const tweet = await this.tweetModel.findById(tweetId);

        if (!tweet) {
            throw new NotFoundException(`Tweet with ID ${tweetId} not found`);
        }

        return tweet.image;
    }
    async likeTweet(tweetId: string, userId: Types.ObjectId): Promise<Tweet> {
        const tweet = await this.tweetModel.findById(tweetId);

        if (!tweet) {
            throw new NotFoundException(`Tweet with ID ${tweetId} not found`);
        }

        const isLiked = tweet.likes.some(id => id.equals(userId));
        if (isLiked) {
            throw new BadRequestException('User has already liked this tweet');
        }

        tweet.likes.push(userId);
        await tweet.save();
        return tweet;
    }
    // create unlike tweet method
    async unlikeTweet(tweetId: string, userId: Types.ObjectId): Promise<Tweet> {
        const tweet = await this.tweetModel.findById(tweetId);

        if (!tweet) {
            throw new NotFoundException(`Tweet with ID ${tweetId} not found`);
        }

        const isLiked = tweet.likes.some(id => id.equals(userId));
        if (!isLiked) {
            throw new BadRequestException('User has not liked this tweet');
        }

        tweet.likes = tweet.likes.filter(id => !id.equals(userId));
        await tweet.save();
        return tweet;
    }
}
