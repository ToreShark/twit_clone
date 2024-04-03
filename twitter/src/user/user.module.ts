import {forwardRef, Module} from '@nestjs/common';
import {User, UserSchema} from "./schema/user";
import {UserController} from "./user.controller";
import {UserService} from "./user.service";
import {MongooseModule} from "@nestjs/mongoose";
import {IamModule} from "../iam/iam.module";
import {MulterModule} from "@nestjs/platform-express";

@Module({
    imports: [
        MongooseModule.forFeature([{ name: 'User', schema: UserSchema }]),
        forwardRef(() => IamModule),
    ],
    controllers: [UserController],
    providers: [UserService],
    exports: [UserService, MongooseModule.forFeature([{ name: User.name, schema: UserSchema }])]
})
export class UserModule {}
