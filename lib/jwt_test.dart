import 'package:jose/jose.dart';

main() async {
  // create a builder
  var builder = new JsonWebSignatureBuilder();

  // set the content
  builder.stringContent = "It is me";

  // set some protected header
  builder.setProtectedHeader("createdAt", new DateTime.now().toIso8601String());

  // add a key to sign, you can add multiple keys for different recipients
  builder.addRecipient(
      new JsonWebKey.fromJson({
        "kty": "oct",
        "k":
        "AyM1SysPpbyDfgZld3umj1qzKObwVMkoqQ-EstJQLr_T-1qS0gZH75aKtMN3Yj0iPS4hcgUuTwjAzZr1Z9CAow"
      }),
      algorithm: "HS256");

  // build the jws
  var jws = builder.build();

  // output the compact serialization
  print("jws compact serialization: ${jws.toCompactSerialization()}");

  // output the json serialization
  print("jws json serialization: ${jws.toJson()}");
}