
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiLanguageConverter extends StatefulWidget  {
  const AiLanguageConverter({Key? key}) : super(key: key);

  @override
  State<AiLanguageConverter> createState() => _AiLanguageConverterState();
}

String apiKey = const String.fromEnvironment('API_KEY');
final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
final content = [Content.text('Write a story about a magic backpack.')];


class _AiLanguageConverterState extends State<AiLanguageConverter> {
  @override
  Widget build(BuildContext context) {
    return Text(apiKey == null ? 'No \$API_KEY environment variable' : exit(1));
  }

  Future<GenerateContentResponse> createGeminiModel() async {
final response = await model.generateContent(content);
print("here the response ${response.text}");
return response;
}
}
