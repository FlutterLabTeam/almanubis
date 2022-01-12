abstract class Failure {}

class RegisterEmailFailure extends Failure {}

class RegisterUserDbFailure extends Failure {}

class GetUserDbFailure extends Failure {}

class LoginEmailFailure extends Failure {}

class ValidateUserLoggedFailure extends Failure {}