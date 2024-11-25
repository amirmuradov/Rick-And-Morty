class ApiException implements Exception {
  final dynamic message;

  ApiException({required this.message});

  dynamic get error => message;
  static errorMessage(dynamic error) {
    if (error is ApiException) {
      return error.message;
    } else {
      return error.toString();
    }
  }
}

class BadRequestException extends ApiException {
  BadRequestException({super.message});
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({super.message});

  @override
  dynamic get error => message;
}

class ForbiddenException extends ApiException {
  ForbiddenException({super.message});
}

class NotFoundException extends ApiException {
  NotFoundException({super.message});
}

class ConflictException extends ApiException {
  ConflictException({super.message});
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException({super.message});
}

class BadGatewayException extends ApiException {
  BadGatewayException({super.message});
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException({super.message});
}

class UnavailableException extends ApiException {
  UnavailableException({super.message});
}

class ApiErrorHandler {
  static ApiException handleError(Map error) {
    switch (error['status_code']) {
      case 400:
        return BadRequestException(message: error);
      case 401:
        return UnauthorizedException(message: error);
      case 403:
        return ForbiddenException(message: error);
      case 404:
        return NotFoundException(message: error);
      case 409:
        return ConflictException(message: error);
      case 500:
        return InternalServerErrorException(message: error);
      case 502:
        return BadGatewayException(message: error);
      case 503:
        return ServiceUnavailableException(message: error);
      case 429:
        return UnavailableException(message: error['message']);
      default:
        return ApiException(message: error);
    }
  }
}
