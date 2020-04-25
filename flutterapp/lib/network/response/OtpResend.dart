import 'dart:convert';

OtpResend otpResendFromJson(String str) => OtpResend.fromJson(json.decode(str));

String otpResendToJson(OtpResend data) => json.encode(data.toJson());

class OtpResend {
    String message;
    int status;

    OtpResend({
        this.message,
        this.status,
    });

    factory OtpResend.fromJson(Map<String, dynamic> json) => OtpResend(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
