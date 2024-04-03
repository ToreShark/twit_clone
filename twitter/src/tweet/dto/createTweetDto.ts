import {IsOptional, IsString} from "class-validator";
import {Types} from "mongoose";

export class CreateTweetDto {
    @IsString()
    text: string;

    @IsString()
    @IsOptional()
    username?: string;
    
    @IsString()
    @IsOptional()
    image?: Buffer;
    
    @IsString()
    @IsOptional()
    likes?: Types.ObjectId[];
}