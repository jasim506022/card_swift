import 'dart:convert';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;

class OcrService {
  final TextRecognizer _recognizer = TextRecognizer();

  /// Extract full raw text from image
  Future<String> extractRawText(File imageFile) async {
    final input = InputImage.fromFile(imageFile);
    final result = await _recognizer.processImage(input);
    final buffer = StringBuffer();
    for (final block in result.blocks) {
      for (final line in block.lines) {
        buffer.writeln(line.text);
      }
    }
    return buffer.toString();
  }

  /// Parse OCR raw text to structured fields
  Map<String, dynamic> parseFields(String raw) {
    final lines = raw
        .split(RegExp(r'\r?\n'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // Regex patterns
    final emailRegex = RegExp(
      r'[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}',
      caseSensitive: false,
    );
    final phoneRegex = RegExp(r'(\+?\d[\d\s\-]{6,}\d)');
    final websiteRegex = RegExp(
      r'(https?:\/\/[^\s]+|www\.[^\s]+)',
      caseSensitive: false,
    );

    // Extract multiple phones & emails & websites
    final phones = phoneRegex.allMatches(raw).map((m) => m.group(0)!).toList();
    final emails = emailRegex.allMatches(raw).map((m) => m.group(0)!).toList();
    final websites = websiteRegex
        .allMatches(raw)
        .map((m) => m.group(0)!)
        .toList();

    // Guess name: first line without email/phone/number
    String? name;



    final nameIgnoreKeywords = [
      'mobile',
      'mob',
      'phone',
      'tel',
      'email',
      'e-mail',
      'mail',
      'www',
      'http',
      'road',
      'street',
      'house',
      'dhaka',
      'bangladesh',
      'ltd',
      'limited',
      'company',
    ];

    bool looksLikeName(String line) {
      final lower = line.toLowerCase();

      // ❌ Ignore unwanted lines
      if (nameIgnoreKeywords.any((k) => lower.contains(k))) return false;

      // ❌ Ignore email / website / phone
      if (emailRegex.hasMatch(line)) return false;
      if (websiteRegex.hasMatch(line)) return false;
      if (phoneRegex.hasMatch(line)) return false;

      // ❌ Too short or too long
      if (line.length < 3 || line.length > 40) return false;

      // ❌ Too many numbers
      if (RegExp(r'\d{2,}').hasMatch(line)) return false;

      // ✅ Must contain letters
      if (!RegExp(r'[A-Za-z]').hasMatch(line)) return false;

      // ✅ Good name pattern (supports dot like "Z.")
      final words = line.split(' ');
      if (words.length >= 2 && words.length <= 4) {
        return true;
      }

      return false;
    }

    /// 🔥 Find best name
    for (final line in lines) {
      if (looksLikeName(line)) {
        name = line;
        break;
      }
    }

    /*
    for (final line in lines) {
      if (emails.any((e) => line.contains(e))) continue;
      if (phones.any((p) => line.contains(p))) continue;
      if (RegExp(r'\d').hasMatch(line)) continue;
      if (line.toLowerCase().contains('phone') ||
          line.toLowerCase().contains('email'))
        continue;
      name = line;
      break;
    }


     */


    // Guess position
    String? position;
    if (name != null) {
      final nameIndex = lines.indexOf(name);
      if (nameIndex + 1 < lines.length) {
        final candidate = lines[nameIndex + 1];
        if (!emails.any((e) => candidate.contains(e)) &&
            !phones.any((p) => candidate.contains(p)) &&
            !websiteRegex.hasMatch(candidate)) {
          position = candidate;
        }
      }
    }

    // 🚀 Detect single company name while avoiding location/address lines
    String? company;
    final companyKeywords = [
      'ltd',
      'limited',
      'inc',
      'corp',
      'co.',
      'company',
      'technologies',
      'technology',
      'tech',
      'solutions',
      'system',
      'systems',
      'software',
      'it',
      'computer',
      'computers',
      'network',
      'networks',
      'enterprise',
      'enterprises',
      'industries',
      'industry',
      'group',
      'engineering',
      'engineers',
      'bd',
      'center',
      'centre',
      'mart',
      'electronics',
      'electricals',
      'services',
      'traders',
      'trading',
      'bazaar',
      'shop',
      'store',
      'communications',
      'consultancy',
      'agency',
      'association',
      'institute',
      'foundation',
      'organization',
      'org',
      'hospital',
      'clinic',
      'school',
      'college',
      'university',
      'academy',
    ];

    for (final line in lines) {
      final lower = line.toLowerCase();

      if (companyKeywords.any((k) => lower.contains(k))) {
        company = line;
        break;
      }
    }

    final locationKeywords = [
      'road',
      'street',
      'st.',
      'st ',
      'avenue',
      'ave',
      'block',
      'house',
      'level',
      'floor',
      'building',
      'market',
      'tower',
      'centre',
      'center',
      'plaza',
      'complex',
      'mall',
      'bangladesh',
      'dhaka',
      'chittagong',
      'khulna',
      'rajshahi',
      'barisal',
      'sylhet',
      'rangpur',
      'ctg',
      'bd',
      'po',
      'zip',
    ];

    bool isLocation(String line) {
      final lower = line.toLowerCase();
      return locationKeywords.any((k) => lower.contains(k));
    }




    // Guess address
    final addressKeywords = [
      'street',
      'st.',
      'road',
      'rd.',
      'ave',
      'avenue',
      'lane',
      'blvd',
      'building',
      'floor',
      'city',
      'zip',
      'postcode',
      'country',
    ];
    final addressLines = lines.where((line) {
      return addressKeywords.any((kw) => line.toLowerCase().contains(kw));
    }).toList();
    final address = addressLines.isNotEmpty ? addressLines.join(', ') : null;

    return {
      'name': name,
      'position': position,
      'company': company,
      'phones': phones,
      'emails': emails,
      'websites': websites,
      'address': address,
      'department': "address",
    };
  }

  void dispose() {
    _recognizer.close();
  }
}



/*

class GeminiService {
  final String apiKey = "AIzaSyCdaT-NClGJn8T1As9tDKprfJgGbw7ai0E";


  Future<Map<String, dynamic>> parseCard(String rawText) async {
    final url =
        "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey";
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text":
                    """
Extract business card info and return ONLY JSON.

No explanation. Only JSON.

{
  "firstName": "",
  "lastName": "",
  "jobTitle": "",
  "companyName": "",
  "mobileNumber": "",
  "phoneNumber": "",
  "email": "",
  "website": "",
  "city": "",
  "country": ""
}

Text:
$rawText
""",
              },
            ],
          },
        ],
      }),
    );

    print("🔍 FULL RESPONSE:");
    print(response.body);

    final data = jsonDecode(response.body);

    /// ❗ Check API error
    if (data['candidates'] == null) {
      throw Exception("❌ API Error: ${data['error']}");
    }

    final text = data['candidates'][0]['content']['parts'][0]['text'];

    print("🤖 RAW TEXT:");
    print(text);

    /// ❗ Extract JSON safely
    final cleanJson = extractJson(text);

    if (cleanJson == null) {
      throw Exception("❌ No valid JSON found from AI");
    }

    print("🧹 CLEAN JSON:");
    print(cleanJson);

    try {
      return jsonDecode(cleanJson);
    } catch (e) {
      throw Exception("❌ JSON Parse Failed: $e");
    }
  }

  String _cleanJson(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    return text.substring(start, end + 1);
  }

  String? extractJson(String text) {
    try {
      final start = text.indexOf('{');
      final end = text.lastIndexOf('}');

      if (start == -1 || end == -1) return null;

      return text.substring(start, end + 1);
    } catch (e) {
      return null;
    }
  }
}


 */