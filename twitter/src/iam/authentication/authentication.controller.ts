import {Body, Controller, HttpCode, HttpStatus, Post} from '@nestjs/common';
import {AuthenticationService} from "./authentication.service";
import {SignUpDto} from "./dto/sign-up.dto/sign-up.dto";
import {SignInDto} from "./dto/sign-in.dto/sign-in.dto";
import {Auth} from "./decorator/auth.decorator";
import {AuthType} from "./enum/auth-type.enum";

@Auth(AuthType.None)
@Controller('authentication')
export class AuthenticationController {
    constructor(private readonly authService: AuthenticationService) {}

    @Post('sign-up')
    signUp(@Body() signUpDto: SignUpDto) {
        return this.authService.signUp(signUpDto);
    }

    @HttpCode(HttpStatus.OK) // by default @Post does 201, we wanted 200 - hence using @HttpCode(HttpStatus.OK)
    @Post('sign-in')
    signIn(@Body() signInDto: SignInDto) {
        return this.authService.signIn(signInDto);
    }
}
