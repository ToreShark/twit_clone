import { Module } from '@nestjs/common';
import {MongooseModule} from "@nestjs/mongoose";
import {Tweet, TweetSchema} from "./schema/tweet";
import {TweetController} from "./tweet.controller";
import {TweetService} from "./tweet.service";

@Module({
    imports: [
        MongooseModule.forFeature([{ name: Tweet.name, schema: TweetSchema }])
    ],
    controllers: [TweetController],
    providers: [TweetService],
})
export class TweetModule {}
