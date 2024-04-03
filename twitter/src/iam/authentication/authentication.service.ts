import {ConflictException, Inject, Injectable, UnauthorizedException} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { HashingService } from '../hashing/hashing.service';
import { SignUpDto } from './dto/sign-up.dto/sign-up.dto';
import { SignInDto } from './dto/sign-in.dto/sign-in.dto';
import { User } from '../../user/schema/user';
import {JwtService} from "@nestjs/jwt";
import jwtConfig from "../config/jwt.config";
import {ConfigType} from "@nestjs/config";

@Injectable()
export class AuthenticationService {
    constructor(
        @InjectModel(User.name) private readonly usersModel: Model<User>,
        private readonly hashingService: HashingService,
        private readonly jwtService: JwtService,
        @Inject(jwtConfig.KEY) // 👈
        private readonly jwtConfiguration: ConfigType<typeof jwtConfig>,
    ) {}

    async signUp(signUpDto: SignUpDto) {
        try {
            const hashedPassword = await this.hashingService.hash(signUpDto.password);
            console.log('Hashed password:', hashedPassword); // Добавим логирование для проверки хешированного пароля

            const user = new this.usersModel({
                email: signUpDto.email,
                password: hashedPassword,
            });

            await user.save();
        } catch (err) {
            if (err.code === 11000) {
                throw new ConflictException('User with this email already exists');
            }
            throw err;
        }
    }
    async signIn(signInDto: SignInDto) {
        const user = await this.usersModel.findOne({ email: signInDto.email });
        if (!user) {
            throw new UnauthorizedException('User does not exist');
        }

        const isEqual = await this.hashingService.compare(signInDto.password, user.password);
        if (!isEqual) {
            throw new UnauthorizedException('Password does not match');
        }

        const accessToken = await this.jwtService.signAsync( // 👈
            {
                sub: user.id,
                email: user.email,
            },
            {
                audience: this.jwtConfiguration.audience,
                issuer: this.jwtConfiguration.issuer,
                secret: this.jwtConfiguration.secret,
                expiresIn: this.jwtConfiguration.accessTokenTtl,
            },
        );
        user.tokens.push(accessToken);
        await user.save();
        return {
            accessToken,
        };
    }
}