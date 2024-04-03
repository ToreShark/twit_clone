import {
    Body,
    Controller,
    Delete,
    Get,
    Param,
    Patch,
    Post,
    Put,
    Req,
    Res,
    UploadedFile,
    UseInterceptors
} from '@nestjs/common';
import {CreateUserDto} from "./dto/createUserDTO";
import {UserService} from "./user.service";
import {FileInterceptor} from "@nestjs/platform-express";
import * as sharp from 'sharp';
import { Response } from 'express';
import { Request } from 'express';
import {REQUEST_USER_KEY} from "../iam/iam.constants";
import {User} from "./schema/user";
import {AuthType} from "../iam/authentication/enum/auth-type.enum";
import {Auth} from "../iam/authentication/decorator/auth.decorator";

@Controller('user')
export class UserController {
    constructor(private userService: UserService) {}

    @Post()
    @Auth(AuthType.None)
    async createUser(@Body() createUserDto: CreateUserDto) {
        return this.userService.createUser(createUserDto);
    }
    // create a method to get all users
    @Get('all')
    async getAllUsers() {
        return this.userService.getAllUsers();
    }
    // create a method to delete user
    @Delete('delete/:userId')
    async deleteUser(@Param('userId') userId: string) {
        return this.userService.deleteUser(userId);
    }
    // create get user by id
    @Get(':userId')
    async getUserById(@Param('userId') userId: string) {
        return this.userService.getUserById(userId);
    }
    @Post(':id/avatar')
    @UseInterceptors(FileInterceptor('avatar', { limits: { fileSize: 10000000 } }))
    async addAvatar(@Param('id') userId: string, @UploadedFile() file: Express.Multer.File) {
        return this.userService.updateAvatar(userId, file.buffer);
    }
    // create a method to get user avatar
    @Get(':id/avatar')
    async getAvatar(@Param('id') userId: string, @Res() res: Response) {
        try {
            const avatarBuffer = await this.userService.getAvatar(userId);
            if (!avatarBuffer) {
                res.status(404).send('Avatar not found');
                return;
            }

            const resizedAvatar = await sharp(avatarBuffer).resize(200, 200).png().toBuffer();
            res.setHeader('Content-Type', 'image/png');
            res.send(resizedAvatar);
        } catch (error) {
            res.status(404).send(error.message);
        }
    }
    // create a method to follow user from id and put
    @Put('follow/:targetUserId')
    async followUser(@Req() req: Request, @Param('targetUserId') targetUserId: string) {
        const userPayload = req[REQUEST_USER_KEY]; 
        if (!userPayload) {
            return { status: 403, message: "User data not found in request" };
        }
        const reqUserId = userPayload.sub; 
        return this.userService.followUser(reqUserId, targetUserId);
    }
    @Put('unfollow/:targetUserId')
    async unfollowUser(@Req() req: Request, @Param('targetUserId') targetUserId: string) {
        const userPayload = req[REQUEST_USER_KEY];
        if (!userPayload) {
            return { status: 403, message: "User data not found in request" };
        }
        const reqUserId = userPayload.sub; 
        return this.userService.unfollowUser(reqUserId, targetUserId);
    }
    @Patch()
    async updateUser(@Req() req: Request, @Body() updateData: Partial<User>) {
        const userPayload = req[REQUEST_USER_KEY];
        if (!userPayload) {
            return { status: 403, message: "User data not found in request" };
        }
        const userId = userPayload.sub; 

        return this.userService.updateUser(userId, updateData);
    }
}
