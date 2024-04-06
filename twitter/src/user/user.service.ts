import {ConflictException, Injectable, NotFoundException} from '@nestjs/common';
import {InjectModel} from "@nestjs/mongoose";
import {User} from "./schema/user";
import {Model, Types} from "mongoose";
import {HashingService} from "../iam/hashing/hashing.service";
import * as sharp from 'sharp';

@Injectable()
export class UserService {
    constructor(@InjectModel(User.name) private userModel: Model<User>,
                private hashingService: HashingService
                ) {}

    async createUser(createUserDto: any): Promise<User> {
        const existingUser = await this.userModel.findOne({
            $or: [
                { email: createUserDto.email },
                { username: createUserDto.username }
            ]
        });

        if (existingUser) {
            throw new ConflictException('User with this email or username already exists');
        }

        const hashedPassword = await this.hashingService.hash(createUserDto.password);
        const newUser = new this.userModel({
            ...createUserDto,
            password: hashedPassword
        });

        return newUser.save();
    }
    async getAllUsers(): Promise<User[]> {
        const users = await this.userModel.find().exec();
        return users.map(user => {
            const userObject = user.toObject();
            delete userObject.password; 
            return userObject;
        });
    } 
    // create delete user
    async deleteUser(userId: string): Promise<User> {
        const id = new Types.ObjectId(userId);
        const deletedUser = await this.userModel.findByIdAndDelete(id).exec();

        if (!deletedUser) {
            throw new NotFoundException(`User with ID ${userId} not found`);
        }

        return deletedUser;
    }
    // create get user by id
    async getUserById(userId: string): Promise<User> {
        const id = new Types.ObjectId(userId);
        const user = await this.userModel.findById(id).exec();

        if (!user) {
            throw new NotFoundException(`User with ID ${userId} not found`);
        }

        const userObject = user.toObject();
        delete userObject.password;
        
        return userObject;
    }

    async updateAvatar(userId: string, fileBuffer: Buffer): Promise<User> {
        const user = await this.userModel.findById(userId);

        if (!user) {
            throw new NotFoundException(`User with ID ${userId} not found`);
        }
        if (!fileBuffer || fileBuffer.length === 0) {
            throw new Error('File buffer is empty or invalid');
        }

        const resizedBuffer = await sharp(fileBuffer)
            .rotate()
            .resize({ width: 250, height: 250 })
            .png()
            .toBuffer();

        user.avatar = resizedBuffer;
        user.avatarExists = true;

        await user.save();

        return user;
    }
    // create a method to get user by avatar from id user
    async getAvatar(userId: string): Promise<Buffer> {
        const user = await this.userModel.findById(userId);

        if (!user || !user.avatar) {
            throw new NotFoundException(`User with ID ${userId} not found or avatar not exists`);
        }

        return user.avatar;
    }
    async followUser(reqUserId: string, targetUserId: string): Promise<{ status: number, message: string }> {
        if (reqUserId === targetUserId) {
            return { status: 403, message: "You can't follow yourself" };
        }

        const targetUser = await this.userModel.findById(targetUserId);
        if (!targetUser) {
            return { status: 404, message: "Target user not found" };
        }

        const requesterUser = await this.userModel.findById(reqUserId);
        if (!requesterUser) {
            return { status: 404, message: "Requester user not found" };
        }

        const reqUserIdObj = new Types.ObjectId(reqUserId); // Преобразование строки в ObjectId

        if (targetUser.followers && targetUser.followers.includes(reqUserIdObj)) {
            return { status: 403, message: "You already follow this user" };
        }

        await this.userModel.updateOne({ _id: targetUserId }, { $push: { followers: reqUserIdObj } });
        await this.userModel.updateOne({ _id: reqUserId }, { $push: { followings: targetUserId } });

        return { status: 200, message: "User has been followed" };
    }
    async unfollowUser(reqUserId: string, targetUserId: string): Promise<{ status: number, message: string }> {
        if (reqUserId === targetUserId) {
            return { status: 403, message: "You can't unfollow yourself" };
        }

        const targetUser = await this.userModel.findById(targetUserId);
        if (!targetUser) {
            return { status: 404, message: "Target user not found" };
        }

        const requesterUser = await this.userModel.findById(reqUserId);
        if (!requesterUser) {
            return { status: 404, message: "Requester user not found" };
        }

        const reqUserIdObj = new Types.ObjectId(reqUserId);

        if (!targetUser.followers || !targetUser.followers.includes(reqUserIdObj)) {
            return { status: 403, message: "You don't follow this user" };
        }

        await this.userModel.updateOne({ _id: targetUserId }, { $pull: { followers: reqUserIdObj } });
        await this.userModel.updateOne({ _id: reqUserId }, { $pull: { followings: targetUserId } });

        return { status: 200, message: "User has been unfollowed" };
    }
    async updateUser(userId: string, updateData: Partial<User>): Promise<User> {
        const user = await this.userModel.findById(userId);
        if (!user) {
            throw new NotFoundException(`User with ID ${userId} not found`);
        }

        // Check for email uniqueness if it's updated
        if (updateData.email && updateData.email !== user.email) {
            const existingUserByEmail = await this.userModel.findOne({ email: updateData.email });
            if (existingUserByEmail) {
                throw new ConflictException('Email is already in use');
            }
            user.email = updateData.email;
        }

        // Check for username uniqueness if it's updated
        if (updateData.username && updateData.username !== user.username) {
            const existingUserByUsername = await this.userModel.findOne({ username: updateData.username });
            if (existingUserByUsername) {
                throw new ConflictException('Username is already in use');
            }
            user.username = updateData.username;
        }

        if (updateData.name) user.name = updateData.name;
        if (updateData.password) {
            const hashedPassword = await this.hashingService.hash(updateData.password);
            user.password = hashedPassword;
        }
        if (updateData.bio) user.bio = updateData.bio;
        if (updateData.website) user.website = updateData.website;
        if (updateData.location) user.location = updateData.location;

        await user.save();
        return user;
    }
}
