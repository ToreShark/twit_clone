import {forwardRef, Module} from '@nestjs/common';
import {HashingService} from './hashing/hashing.service';
import {BcryptService} from './hashing/bcrypt.service';
import {AuthenticationController} from './authentication/authentication.controller';
import {AuthenticationService} from './authentication/authentication.service';
import {UserModule} from "../user/user.module";
import jwtConfig from "./config/jwt.config";
import {JwtModule} from "@nestjs/jwt";
import {ConfigModule} from "@nestjs/config";
import {AccessTokenGuard} from "./guards/acces-token";
import {APP_GUARD} from "@nestjs/core";
import {AuthenticationGuard} from "./guards/authentication.guard";

@Module({
    imports: [
        forwardRef(() => UserModule), // Импортируем UserModule здесь с forwardRef
        JwtModule.registerAsync(jwtConfig.asProvider()),
        ConfigModule.forFeature(jwtConfig)
    ],
    providers: [{
        provide: HashingService,
        useClass: BcryptService,
    },
        {
            provide: APP_GUARD,
            useClass: AuthenticationGuard,
        },
        AccessTokenGuard,
        AuthenticationService],
    controllers: [AuthenticationController],
    exports: [HashingService]
})
export class IamModule {
}
