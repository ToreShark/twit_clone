import {
    Body,
    Controller,
    Get,
    NotFoundException,
    Param,
    Post, Put,
    Req,
    Res,
    UploadedFile,
    UseInterceptors
} from '@nestjs/common';
import {TweetService} from "./tweet.service";
import {CreateTweetDto} from "./dto/createTweetDto";
import {REQUEST_USER_KEY} from "../iam/iam.constants";
import * as sharp from 'sharp';
import {FileInterceptor} from "@nestjs/platform-express";
import {Types} from "mongoose";

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
    // create fetch a spicific users tweets method
    @Get('user/:id')
    async fetchUserTweets(@Param('id') userId: string) {
        return this.tweetService.fetchUserTweets(userId);
    }
    @Post(':id/image')
    @UseInterceptors(FileInterceptor('image', { limits: { fileSize: 10000000 } }))
    async addImage(@Param('id') tweetId: string, @UploadedFile() file: Express.Multer.File) {
        return this.tweetService.updateTweetImage(tweetId, file.buffer);
    }
    // fetch tweet image
    @Get(':id/image')
    async fetchImage(@Param('id') tweetId: string, @Res() res: any) {
        try {
            const imageBuffer = await this.tweetService.fetchTweetImage(tweetId);
            if (!imageBuffer) {
                res.status(404).send('Image not found');
            }
            res.set('Content-Type', 'image/png');
            res.send(imageBuffer);
        } catch (e) {
            if (e instanceof NotFoundException) {
                res.status(404).send(e.message);
            } else {
                res.status(500).send('Internal server error');
            }
        }
    }
    @Put(':id/like')
    async likeTweet(@Param('id') tweetId: string, @Req() req: any) {
        const userPayload = req[REQUEST_USER_KEY];
        if (!userPayload) {
            return { status: 403, message: "User data not found in request" };
        }
        const userId = new Types.ObjectId(userPayload.sub);

        return this.tweetService.likeTweet(tweetId, userId);
    }
    // create unlike tweet method
    @Put(':id/unlike')
    async unlikeTweet(@Param('id') tweetId: string, @Req() req: any) {
        const userPayload = req[REQUEST_USER_KEY];
        if (!userPayload) {
            return { status: 403, message: "User data not found in request" };
        }
        const userId = new Types.ObjectId(userPayload.sub);

        return this.tweetService.unlikeTweet(tweetId, userId);
    }
}
