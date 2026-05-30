import 'dart:io';

import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../model/business_card_model.dart';

class BusinessCardService {
  final TextRecognizer _recognizer = TextRecognizer();

  final EntityExtractor _extractor = EntityExtractor(
    language: EntityExtractorLanguage.english,
  );

  // ================= MAIN =================

  Future<BusinessCardModel> scanCard(File imageFile) async {
    final rawText = await _extractText(imageFile);

    return _parse(rawText);
  }

  // ================= OCR =================

  Future<String> _extractText(File imageFile) async {
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

  // ================= PARSER =================
  Future<BusinessCardModel> _parse(String raw) async {
    final lines = raw
        .split(RegExp(r'\r?\n'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final data = await _extractAllEntities(raw);

    final emails = data['emails'] as List<String>;
    final phones = data['phones'] as List<String>;

    final websitesList = data['websites'] as List<String>;

    // লিস্ট খালি না থাকলে প্রথমটি নিবে, খালি হলে null বা খালি স্ট্রিং দিবে
    String? website = websitesList.isNotEmpty ? websitesList.first : null;
    final address = data['address'] as String?;

    final name = extractBestName(lines, phones, emails);
    final company = _extractCompany(lines);
    final department = extractDepartment(lines);

    final position = _extractPosition(lines, name);

    return BusinessCardModel(
      firstName: name,
      position: position,
      companyName: company,
      emails: emails,
      phones: phones,
      websites: website,
      street: address,
      department: department,
    );
  }

  Future<Map<String, dynamic>> _extractAllEntities(String raw) async {
    final annotations = await _extractor.annotateText(raw);

    final Set<String> emails = {};
    final Set<String> phones = {};
    final Set<String> websites = {};
    String? address;

    for (final annotation in annotations) {
      for (final entity in annotation.entities) {
        switch (entity.type) {
          case EntityType.email:
            emails.add(annotation.text.toLowerCase().trim());
            break;
          case EntityType.phone:
            phones.add(annotation.text.trim());
            break;
          case EntityType.url:
            websites.add(annotation.text.toLowerCase().trim());
            break;
          case EntityType.address:
            address ??= annotation.text.replaceAll('\n', ' ').trim();
            break;
          default:
            break;
        }
      }
    }

    return {
      'emails': emails.toList(),
      'phones': phones.toList(),
      'websites': websites.toList(),
      'address': address,
    };
  }

  String? extractBestName(
    List<String> lines,
    List<String> phones,
    List<String> emails,
  ) {
    String? bestName;
    int bestScore = 0;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      final lower = line.toLowerCase();

      int score = 0;

      // ❌ skip invalid lines
      if (line.isEmpty) continue;
      if (emails.any((e) => line.contains(e))) continue;
      if (phones.any((p) => line.contains(p))) continue;
      if (lower.contains('www') || lower.contains('http')) continue;

      final words = lower.split(RegExp(r'\s+'));

      // ❌ skip company words
      if (words.any((w) => bangladeshiCompanyKeywords.contains(w))) {
        continue;
      }

      // ❌ skip job titles
      if (words.any((w) => positionKeywords.contains(w))) {
        continue;
      }

      // ================= SCORE SYSTEM =================

      // 1️⃣ Good name length
      if (words.length >= 2 && words.length <= 4) {
        score += 3;
      }

      // 2️⃣ Contains Bangladeshi first name
      if (words.any((w) => bangladeshiNames.contains(w))) {
        score += 4;
      }

      // 3️⃣ Contains surname
      if (words.any((w) => bangladeshiNames.contains(w))) {
        score += 4;
      }

      // 4️⃣ Only letters (very important)
      if (RegExp(r'^[A-Za-z.\s]+$').hasMatch(line)) {
        score += 2;
      }

      // 5️⃣ Capital name pattern (Md Rahim style)
      if (RegExp(r'^([A-Z][a-z]+)').hasMatch(line)) {
        score += 2;
      }

      // 6️⃣ No numbers
      if (!RegExp(r'\d').hasMatch(line)) {
        score += 2;
      }

      // 7️⃣ Early lines priority
      if (i < 3) {
        score += 1;
      }

      // ================= BEST MATCH =================
      if (score > bestScore) {
        bestScore = score;
        bestName = line;
      }
    }

    // minimum confidence
    return bestScore >= 6 ? bestName : null;
  }

  String? _extractPosition(List<String> lines, String? name) {
    if (name == null) return null;

    final index = lines.indexOf(name);

    if (index == -1 || index + 1 >= lines.length) {
      return null;
    }

    return lines[index + 1];
  }

  // ================= DEPARTMENT EXTRACTION =================
// ================= DEPARTMENT EXTRACTION =================
  String? extractDepartment(List<String> lines) {
    String? best;
    int bestScore = 0;

    for (final line in lines) {
      final lower = line.toLowerCase().trim();

      // CRITICAL: If it has "Ltd", "Ltd.", "Group", it's a company, NOT a department
      if (companySuffixes.any((suffix) => lower.split(' ').contains(suffix))) {
        continue;
      }

      // Skip email/phone/url
      if (RegExp(r'@').hasMatch(line)) continue;
      if (RegExp(r'\+?\d[\d\s\-]{6,}').hasMatch(line)) continue;
      if (lower.contains('www') || lower.contains('http')) continue;

      int score = 0;

      // RULE 1: KEYWORD MATCH
      for (final key in departmentKeywords) {
        if (lower.contains(key)) {
          score += 5;
        }
      }

      // RULE 2: STRUCTURE (Allows words, spaces, & and /)
      if (RegExp(r'^[A-Za-z &/]+$').hasMatch(line)) {
        score += 2;
      }

      // RULE 3: LENGTH
      final words = line.split(RegExp(r'\s+'));
      if (words.isNotEmpty && words.length <= 5) {
        score += 2;
      }

      // Avoid overly long lines
      if (words.length > 6) continue;

      // BEST MATCH DETERMINATION
      if (score > bestScore) {
        bestScore = score;
        best = line;
      }
    }

    return bestScore >= 5 ? best : null;
  }

  /*
  String? extractDepartment(List<String> lines) {
    String? best;
    int bestScore = 0;

    for (final line in lines) {
      final lower = line.toLowerCase().trim();

      if (line.isEmpty) continue;

      int score = 0;

      // ❌ skip email/phone/url
      if (RegExp(r'@').hasMatch(line)) continue;
      if (RegExp(r'\+?\d[\d\s\-]{6,}').hasMatch(line)) continue;
      if (lower.contains('www') || lower.contains('http')) continue;

      // ================= RULE 1: KEYWORD MATCH =================
      for (final key in departmentKeywords) {
        if (lower.contains(key)) {
          score += 5;
        }
      }

      // ================= RULE 2: STRUCTURE =================
      if (RegExp(r'^[A-Za-z &/]+$').hasMatch(line)) {
        score += 2;
      }

      // ================= RULE 3: LENGTH =================
      final words = line.split(' ');
      if (words.isNotEmpty && words.length <= 5) {
        score += 2;
      }

      // avoid company-like lines
      if (words.length > 6) continue;

      // ================= BEST MATCH =================
      if (score > bestScore) {
        bestScore = score;
        best = line;
      }
    }

    return bestScore >= 5 ? best : null;
  }


   */
  // ================= COMPANY =================

  // ================= COMPANY EXTRACTION =================
  String? _extractCompany(List<String> lines) {
    // প্রথম ধাপ: আপনার দেওয়া companySuffixes চেক করা (সর্বোচ্চ অগ্রাধিকার)
    for (final line in lines) {
      final lower = line.toLowerCase().trim();
      // ডট (.), কমা (,), অ্যান্ড (&) ইত্যাদি বাদ দিয়ে শব্দে ভাগ করা
      final words = lower.split(RegExp(r'[\s.,&/]+')).where((w) => w.isNotEmpty).toList();

      // যদি 'ltd', 'limited', 'group' ইত্যাদি শব্দের সাথে হুবহু মিলে যায়
      if (companySuffixes.any((suffix) => words.contains(suffix.replaceAll('.', '')))) {
        return line; // এটিই নিশ্চিতভাবে কোম্পানি!
      }
    }

    // দ্বিতীয় ধাপ: যদি প্রথম ধাপে না পাওয়া যায়, তবে সাধারণ কিওয়ার্ড চেক করবে
    for (final line in lines) {
      final lower = line.toLowerCase().trim();
      final words = lower.split(RegExp(r'[\s.,&/]+')).where((w) => w.isNotEmpty).toList();

      if (bangladeshiCompanyKeywords.any((keyword) => words.contains(keyword))) {
        return line;
      }
    }

    return null;
  }

  /*
  String? _extractCompany(List<String> lines) {
    for (final line in lines) {
      final lower = line.toLowerCase();

      if (bangladeshiCompanyKeywords.any(lower.contains)) {
        return line;
      }
    }

    return null;
  }


 */
  // ================= DISPOSE =================

  void dispose() {
    _recognizer.close();
    _extractor.close();
  }
}

/*
  String? _extractPosition(List<String> lines, String? name) {
    if (name == null) return null;

    final index = lines.indexOf(name);

    if (index == -1 || index + 1 >= lines.length) {
      return null;
    }

    return lines[index + 1];
  }


   */

final positionKeywords = [
  // General IT / Tech
  'developer',
  'software engineer',
  'engineer',
  'web developer',
  'app developer',
  'flutter developer',
  'android developer',
  'ios developer',
  'programmer',
  'managing'
      'chairman',
  'managing director',
  'md',
  'proprietor',
  'owner',
  'partner',
  'president',
  'vice president',

  // Management
  'manager',
  'assistant manager',
  'senior manager',
  'director',
  'executive',
  'officer',
  'coordinator',
  'supervisor',

  // Business / Corporate
  'ceo',
  'cto',
  'cfo',
  'founder',
  'co-founder',
  'owner',
  'proprietor',
  'partner',

  // Sales & Marketing
  'sales',
  'marketing',
  'sales executive',
  'marketing executive',
  'business development',
  'bde',
  'bdm',

  // Design
  'designer',
  'ui designer',
  'ux designer',
  'graphic designer',

  // Education
  'teacher',
  'lecturer',
  'professor',
  'trainer',

  // Medical
  'doctor',
  'physician',
  'nurse',

  // Finance
  'accountant',
  'accounts officer',
  'finance manager',

  // HR
  'hr',
  'human resource',
  'hr manager',
];

final List<String> departmentKeywords = [
  'department',
  'dept',
  'division',
  'section',
  'unit',
  'cell',
  'branch',
  'team',

  // common departments
  'it',
  'information technology',
  'software',
  'hardware',
  'engineering',
  'hr',
  'human resources',
  'sales',
  'marketing',
  'finance',
  'accounts',
  'admin',
  'operations',
  'support',
  'customer service',
  'research',
  'development',
  'marketing'
      'department',
  'dept',
  'division',
  'section',
  'unit',
  'cell',
  'branch',
  'team',
  'it',
  'information technology',
  'software',
  'hardware',
  'engineering',
  'hr',
  'human resources',
  'sales',
  'marketing',
  'finance',
  'accounts',
  'admin',
  'operations',
  'support',
  'customer service',
  'research',
  'development',
];
const bangladeshiCompanyKeywords = [
  // Core business
  'ltd.',
  'ltd',
  'limited',
  'co',
  'co.',
  'company',
  'corporation',
  'corp',
  'inc',
  'incorporated',

  // Tech & IT
  'technology',
  'technologies',
  'tech',
  'software',
  'solutions',
  'systems',
  'system',
  'it',
  'network',
  'networks',
  'digital',
  'web',
  'mobile',
  'app',
  'studio',

  // Business & services
  'group',
  'enterprises',
  'enterprise',
  'industries',
  'industry',
  'trading',
  'traders',
  'commerce',
  'business',
  'services',
  'service',
  'consulting',
  'consultancy',
  'agency',
  'associates',
  'association',

  // Education
  'university',
  'college',
  'school',
  'institute',
  'academy',
  'training',
  'center',
  'centre',

  // Medical
  'hospital',
  'clinic',
  'diagnostic',
  'pharma',
  'pharmaceutical',
  'pharmacy',

  // Banking / Finance
  'bank',
  'insurance',
  'finance',
  'financial',
  'investment',

  // Retail / Shop
  'store',
  'shop',
  'mart',
  'supermarket',
  'bazaar',
  'market',

  // Construction / Engineering
  'engineering',
  'engineers',
  'builders',
  'construction',
  'realestate',
  'real estate',

  // Others
  'foundation',
  'ngo',
  'trust',
  'organization',
  'organisation',
  'org',

  'technology',
  'technologies',
  'tech',
  'solutions',
  'systems',
  'system',
  'network',
  'networks',
  'digital',
  'web',
  'mobile',
  'app',
  'studio',
  'enterprises',
  'enterprise',
  'industries',
  'industry',
  'trading',
  'traders',
  'commerce',
  'business',
  'services',
  'service',
  'consulting',
  'consultancy',
  'agency',
  'associates',
  'association',
  'university',
  'college',
  'school',
  'institute',
  'academy',
  'training',
  'center',
  'centre',
  'hospital',
  'clinic',
  'diagnostic',
  'pharma',
  'pharmaceutical',
  'pharmacy',
  'bank',
  'insurance',
  'financial',
  'investment',
  'store',
  'shop',
  'mart',
  'supermarket',
  'bazaar',
  'market',
  'builders',
  'construction',
  'realestate',
  'real estate',
  'foundation',
  'ngo',
  'trust',
  'organization',
  'organisation',
  'org',
];
const List<String> companySuffixes = [
  'ltd.',
  'ltd',
  'limited',
  'co',
  'co.',
  'company',
  'corporation',
  'corp',
  'inc',
  'incorporated',
  'group',
];
final bangladeshiNames = {
  // Islamic/Common
  'md',
  'mohammad',
  'muhammad',
  'abdul',
  'abdur',
  'abu',
  'syed',
  'sheikh',

  // Male
  'rahim',
  'karim',
  'hasan',
  'hassan',
  'hossain',
  'islam',
  'rahman',
  'rakib',
  'sakib',
  'tamim',
  'naim',
  'fahim',
  'sojib',
  'jahid',
  'mahmud',
  'mahmood',
  'shawon',
  'emon',
  'imon',
  'riyad',
  'riad',
  'faisal',
  'rasel',
  'russel',
  'parvez',
  'shuvo',
  'ashik',
  'anik',
  'arif',
  'shakil',
  'farhan',
  'mehedi',
  'mehadi',
  'sabbir',
  'nayeem',
  'rubel',
  'liton',
  'sumon',
  'masum',
  'mamun',
  'kamrul',
  'kamal',
  'jamal',
  'belal',
  'selim',
  'delwar',
  'helal',
  'jewel',
  'rajib',
  'kabir',
  'rony',
  'roni',
  'tanvir',
  'tanmoy',
  'shamim',
  'nazmul',
  'milon',
  'monir',
  'momin',
  'yasin',
  'ashraful',
  'saiful',
  'sharif',
  'tareq',
  'tariq',
  'zahid',
  'zaman',
  'jubayer',
  'touhid',
  'towhid',
  'faruk',
  'farooq',
  'habib',
  'babul',
  'jahangir',
  'anis',
  'anwar',
  'rafiq',
  'rafique',
  'mizan',
  'morshed',
  'khaled',
  'nazim',
  'shafiq',
  'mokbul',
  'iqbal',
  'akash',
  'shihab',
  'adnan',
  'sifat',
  'sajid',
  'rafsan',
  'ovi',
  'oviya',
  'prince',
  'mahin',
  'rahat',
  'nadim',
  'nadeem',
  'fuad',
  'labib',
  'siyam',
  'siam',
  'rifat',
  'ridoy',
  'hridoy',
  'sourav',
  'sourob',
  'niloy',
  'opu',
  'apon',
  'sagor',
  'sagar',
  'raju',
  'bappy',
  'pavel',
  'shanto',

  // Female
  'nusrat',
  'sumaiya',
  'sadia',
  'sanjida',
  'jannat',
  'mim',
  'tania',
  'farzana',
  'shabnur',
  'sabina',
  'selina',
  'samira',
  'sumi',
  'ritu',
  'riya',
  'priya',
  'maria',
  'marzia',
  'sultana',
  'rabeya',
  'rabia',
  'fatema',
  'fatima',
  'jamila',
  'shirin',
  'mousumi',
  'mou',
  'jui',
  'maliha',
  'maisha',
  'lamia',
  'israt',
  'sabrina',
  'naima',
  'naomi',
  'fariha',
  'tasnim',
  'tasnia',
  'tahmina',
  'shaila',
  'shila',
  'afrin',
  'arifa',
  'mahmuda',
  'raisa',
  'rima',
  'rupa',
  'shathi',
  'sonia',
  'soniya',
  'muna',
  'munni',
  'bristy',
  'brishti',
  'jerin',
  'nabila',
  'nafisa',
  'muntaha',
  'muntaka',
  'orni',
  'oni',
  'mehnaz',
  'adiba',
  'aditi',
  'eva',
  'sneha',
  'tanjina',
  'tanjila',
  'arpita',
  'payel',
  'puja',
  'popy',
  'happy',

  // Very Common Muslim Surnames
  'ahmed',
  'uddin',
  'alam',
  'haque',
  'huq',
  'ali',
  'ekram'
      'reza',
  'khan',
  'chowdhury',
  'bhuiyan',
  'talukder',
  'sarker',
  'sarkar',
  'mollah',
  'miah',
  'mia',

  'jaman',

  'rashid',
  'rashed',
  'majumder',
  'mazumder',
  'munshi',
  'bhuiya',
  'biswas',
  'hawlader',
  'howlader',
  'bepari',
  'gazali',
  'gazi',
  'fakir',
  'mirza',
  'matubber',
  'mirdha',
  'sikder',
  'siddique',
  'siddiqui',
  'quader',
  'qader',
  'jabbar',
  'bashar',
  'bari',

  'naeem',

  'jalil',
  'halim',
  'hakim',
  'basher',
  'basar',
  'rahimullah',
  'nur',
  'noor',
  'nurul',
  'nuruzzaman',

  // Hindu Common Surnames
  'roy',
  'das',
  'dasgupta',
  'dey',
  'deb',
  'saha',
  'paul',
  'pal',
  'ghosh',
  'bose',
  'bosu',
  'sen',
  'gupta',
  'chakraborty',
  'banerjee',
  'chatterjee',
  'mukherjee',
  'bhattacharya',
  'sanyal',
  'dutta',
  'sutradhar',
  'malakar',
  'barua',
  'nath',
  'adhikari',
  'sutradhor',

  // Buddhist / Tribal / Others
  'chakma',
  'marma',
  'tripura',
  'tanchangya',
  'khisa',
  'mong',
  'bom',
  'murmu',
  'soren',
  'hembrom',
};
