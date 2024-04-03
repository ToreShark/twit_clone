import {Body, Controller, Get, Post, Req} from '@nestjs/common';
import {TweetService} from "./tweet.service";
import {CreateTweetDto} from "./dto/createTweetDto";
import {REQUEST_USER_KEY} from "../iam/iam.constants";

@Controller('tweet')
export class TweetController {
    constructor(private readonly tweetService: TweetService) {}
    @Post()
    async createTweet(@Body() createTweetDto: CreateTweetDto, @Req() req: any) {
        const userPayload = req[REQUEST_USER_KEY];
        if (!userPayload) {
            return { status: 403, message: "User data not found in request" };
        }
        const userId = userPayload.sub;

        return this.tweetService.createTweet(createTweetDto.text, userId, createTweetDto.username);
    }
    // create fetch all tweets method
    @Get('all')
    async fetchAllTweets() {
        return this.tweetService.fetchAllTweets();
    }
}
