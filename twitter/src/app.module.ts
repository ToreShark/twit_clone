import {Module} from '@nestjs/common';
import {AppController} from './app.controller';
import {AppService} from './app.service';
import {MongooseModule} from "@nestjs/mongoose";
import {ConfigModule, ConfigService} from "@nestjs/config";
import { TweetService } from './tweet/tweet.service';
import { TweetController } from './tweet/tweet.controller';
import { TweetModule } from './tweet/tweet.module';
import { UserService } from './user/user.service';
import { UserController } from './user/user.controller';
import { UserModule } from './user/user.module';
import {JwtModule} from "@nestjs/jwt";
import { IamModule } from './iam/iam.module';

@Module({
    imports: [
        ConfigModule.forRoot({
            isGlobal: true,
        }),
        MongooseModule.forRootAsync({
            imports: [ConfigModule],
            useFactory: async (configService: ConfigService) => ({
                uri: configService.get<string>('DB_DATABASE'),
            }),
            inject: [ConfigService],
        }),
        TweetModule,
        UserModule,
        IamModule],
    controllers: [],
    providers: [],
})
export class AppModule {
}
