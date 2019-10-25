import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart'as path;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:custom_multi_image_picker/asset.dart';
import 'package:custom_multi_image_picker/custom_multi_image_picker.dart';
import 'package:path/path.dart';
import '../ClassShowImage/asset_view.dart';

Future<List> uploadingImages(List<Asset> mySelectedImages) async {

  List imageNameFromServer=[];
  debugPrint("><><><><><>><><><><><><>:"+mySelectedImages.length.toString());

  for(int i=0;i<mySelectedImages.length;i++){
    File imageFile = new File(mySelectedImages[i].filePath);

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("http://uni-social.tk/esn/apiMob/up");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path),
        contentType: new MediaType('image', 'png'));

    request.fields["typefile"] = "post";
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      imageNameFromServer.insert(i,json.decode(value)["file"]);
    });

  }
  await Future.delayed(const Duration(milliseconds: 1000), () {
    debugPrint("><><><><><>><><><><><><>:"+imageNameFromServer.length.toString());
  });
  return imageNameFromServer;
}
