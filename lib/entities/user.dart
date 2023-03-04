import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Authentication class for this sample application.
/// It shuold be self-explanatory.
@Freezed(
  copyWith: false,
  equal: false,
)
class User with _$User {
  const factory User.signedIn({
    required num userId,
    required String refreshToken,
    required String token,
    required num expiresTime,
  }) = SignedIn;

  const factory User.signedOut() = SignedOut;
}
