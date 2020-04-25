import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
    String message;
    int status;
    User user;

    SignUp({
        this.message,
        this.status,
        this.user,
    });

    factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
        message: json["message"],
        status: json["status"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "user": user.toJson(),
    };
}

class User {
    int id;
    String email;
    String firstName;
    String lastName;
    int phoneNo;
    int otp;
    bool otpVerified;
    int stepNo;
    BillingAddress billingAddress;
    String token;
    int temporaryPetsCount;

    User({
        this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.phoneNo,
        this.otp,
        this.otpVerified,
        this.stepNo,
        this.billingAddress,
        this.token,
        this.temporaryPetsCount,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNo: json["phone_no"],
        otp: json["otp"],
        otpVerified: json["otp_verified"],
        stepNo: json["step_no"],
        billingAddress: BillingAddress.fromJson(json["billing_address"]),
        token: json["token"],
        temporaryPetsCount: json["temporary_pets_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_no": phoneNo,
        "otp": otp,
        "otp_verified": otpVerified,
        "step_no": stepNo,
        "billing_address": billingAddress.toJson(),
        "token": token,
        "temporary_pets_count": temporaryPetsCount,
    };
}

class BillingAddress {
    dynamic city;
    dynamic state;
    dynamic country;
    dynamic street1;
    dynamic street2;
    dynamic zipcode;

    BillingAddress({
        this.city,
        this.state,
        this.country,
        this.street1,
        this.street2,
        this.zipcode,
    });

    factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        city: json["city"],
        state: json["state"],
        country: json["country"],
        street1: json["street1"],
        street2: json["street2"],
        zipcode: json["zipcode"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
        "street1": street1,
        "street2": street2,
        "zipcode": zipcode,
    };
}
