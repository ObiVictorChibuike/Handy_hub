import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:esolink/logic/api_services/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../views/widgets/progress_indicator.dart';


post(
    {BuildContext? context,
    @required String? url,
    String? token,
    Map<String, dynamic>? body}) async {
  if (context != null) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    progressIndicator(context);
  }
  var uri = Uri.parse(url!);
  var response;
  var data;

  try {
    response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    }).timeout(HTTP_TIMEOUT);

    data = jsonDecode(response.body);
  } catch (err) {
    switch (err) {
      case SocketException:
        data = "Socket Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      case TimeoutException:
        data = "Timeout Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      case FormatException:
        data = "Format Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      default:
        data = err;
    }
  }

  if (context != null) {
    Navigator.pop(context);
  }
  return {
    "data": data['status'],
    "status_code": response != null ? response.statusCode : 504
  };
}

get({@required url, BuildContext? context, String? token}) async {
  var uri = Uri.parse(url);
  var response;
  var data;

  try {
    response = await http.get(uri,
        headers: {'Authorization': 'Bearer $token'}).timeout(HTTP_TIMEOUT);

    data = json.decode(response.body);
  } catch (e) {
    switch (e) {
      case SocketException:
        data = "Socket Exception";
        break;
      case TimeoutException:
        data = "Timeout Exception";
        break;
      default:
        data = e;
    }
  }
  return {"data": data, "status_code": response.statusCode};
}

makePostrequest(
    {BuildContext? context,
    @required String? url,
    String? token,
    Map<String, String>? body,
    String? images1,
    String? image2}) async {
  if (context != null) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    progressIndicator(context);
  }
  var uri = Uri.parse(url!);

  var responseData;
  var request;
  var a;

  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = http.MultipartRequest('POST', uri);
    response.fields.addAll(body!);
    response.files
        .add(await http.MultipartFile.fromPath("divers_licence", images1!));
    response.files.add(await http.MultipartFile.fromPath(
      "photograph",
      image2!,
    ));
    response.headers.addAll(headers);
    request = await response.send();
    a = await request.stream.bytesToString();
    responseData = jsonDecode(a);
  } catch (err) {
    switch (err) {
      case SocketException:
        responseData = "Socket Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      case TimeoutException:
        responseData = "Timeout Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      default:
        responseData = err;
    }
  }

  if (context != null) {
    Navigator.pop(context);
  }
  return {"responseData": responseData, "status_code": request.statusCode};
}

makeProductRequest(
    {BuildContext? context,
    @required String? url,
    String? token,
    Map<String, String>? body,
    String? productImage}) async {
  if (context != null) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    progressIndicator(context);
  }
  var uri = Uri.parse(url!);
  var response;
  var data;

  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll(body!);
    request.headers.addAll(headers);
    request.files.add(
        await http.MultipartFile.fromPath("product_image[]", productImage!));

    response = await request.send();
    var a = await response.stream.bytesToString();
    data = jsonDecode(a);
  } catch (err) {
    switch (err) {
      case SocketException:
        data = "Socket Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      case TimeoutException:
        data = "Timeout Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      default:
        data = err;
    }
  }

  if (context != null) {
    Navigator.pop(context);
  }
  return {
    "data": data,
    "status_code": response != null ? response.statusCode : 504
  };
}

updateLicenceRequest(
    {BuildContext? context,
    @required String? url,
    String? token,
    Map<String, String>? body,
    String? licence,
    String? photo}) async {
  if (context != null) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    progressIndicator(context);
  }
  var uri = Uri.parse(url!);
  var response;
  var data;

  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll(headers);
    request.fields.addAll(body!);
    request.files
        .add(await http.MultipartFile.fromPath("divers_licence", licence!));
    request.files.add(await http.MultipartFile.fromPath("photograph", photo!));

    response = await request.send();
    var a = await response.stream.bytesToString();
    data = jsonDecode(a);
  } catch (err) {
    switch (err) {
      case SocketException:
        data = "Socket Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      case TimeoutException:
        data = "Timeout Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      default:
        data = err;
    }
  }

  if (context != null) {
    Navigator.pop(context);
  }
  return {
    "data": data,
    "status_code": response != null ? response.statusCode : 504
  };
}

deliveredRequest(
    {BuildContext? context,
    @required String? url,
    String? token,
    Map<String, String>? body,
    String? image1,
    String? image2}) async {
  if (context != null) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    progressIndicator(context);
  }
  var uri = Uri.parse(url!);
  var response;
  var data;

  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll(headers);
    request.fields.addAll(body!);
    request.files.add(await http.MultipartFile.fromPath("proof[]", image1!));
    request.files.add(await http.MultipartFile.fromPath("proof[]", image2!));

    response = await request.send();
    var a = await response.stream.bytesToString();
    data = jsonDecode(a);
  } catch (err) {
    switch (err) {
      case SocketException:
        data = "Socket Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      case TimeoutException:
        data = "Timeout Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      default:
        data = err;
    }
  }

  if (context != null) {
    Navigator.pop(context);
  }
  return {
    "data": data,
    "status_code": response != null ? response.statusCode : 504
  };
}

updateProfileRequest({
  BuildContext? context,
  @required String? url,
  String? token,
  Map<String, String>? body,
  String? image1,
}) async {
  if (context != null) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    progressIndicator(context);
  }
  var uri = Uri.parse(url!);
  var response;
  var data;

  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll(headers);
    request.fields.addAll(body!);
    request.files.add(await http.MultipartFile.fromPath("image", image1!));

    response = await request.send();
    var a = await response.stream.bytesToString();
    data = jsonDecode(a);
  } catch (err) {
    switch (err) {
      case SocketException:
        data = "Socket Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      case TimeoutException:
        data = "Timeout Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      default:
        data = err;
    }
  }

  if (context != null) {
    Navigator.pop(context);
  }
  return {
    "data": data,
    "status_code": response != null ? response.statusCode : 504
  };
}

deleteRequest(
    {BuildContext? context,
    @required String? url,
    String? token,
    Map<String, String>? body,
    String? image1,
    String? image2}) async {
  if (context != null) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    progressIndicator(context);
  }
  var uri = Uri.parse(url!);
  var response;
  var data;

  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll(headers);
    request.fields.addAll(body!);

    response = await request.send();
    var a = await response.stream.bytesToString();
    data = jsonDecode(a);
  } catch (err) {
    switch (err) {
      case SocketException:
        data = "Socket Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      case TimeoutException:
        data = "Timeout Exception";
        if (context != null) {
          Navigator.pop(context);
        }
        break;
      default:
        data = err;
    }
  }

  if (context != null) {
    Navigator.pop(context);
  }
  return {
    "data": data,
    "status_code": response != null ? response.statusCode : 504
  };
}
