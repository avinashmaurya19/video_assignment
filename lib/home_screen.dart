import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class HomeScreen extends StatefulWidget {
  final String videoId;
  const HomeScreen({super.key, required this.videoId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String hlsLink = '';

  @override
  void initState() {
    super.initState();
    fetchVideoInfo();
  }

  void fetchVideoInfo() async {
    final apiUrl = 'https://api.vimeo.com/videos/${widget.videoId}?fields=play';

    final headers = {
      'Authorization': 'Bearer e76cd91ebcd375276979cbca386d6c4a',
      'Accept': 'application/vnd.vimeo.*+json;version=3.4'
    };

    final uri = Uri.parse(apiUrl);
    final response = await http.get((uri), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final Video videoInfo = Video.fromJson(responseData);
      final hlsLink = videoInfo.play?.hls?.link;

      setState(() {
        this.hlsLink = hlsLink ?? "";
      });
    } else {
      // Handle error
      print('Failed to fetch video information');
      ScaffoldMessenger.of(context).showSnackBar(
          new SnackBar(content: new Text("Failed to fetch video information")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vimeo video player'),
      ),
      body: Center(
        child: hlsLink.isNotEmpty
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(hlsLink)),
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
