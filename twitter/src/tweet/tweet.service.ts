import { Injectable } from '@nestjs/common';
import {InjectModel} from "@nestjs/mongoose";
import {Tweet} from "./schema/tweet";
import {Model} from "mongoose";

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
}
