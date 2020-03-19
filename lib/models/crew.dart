class Crew {
  final int id;
  final String name;
  final String catchPhrase;
  final String contact;
  final String logoImageUrl;
  final String bgImageUrl;
  final String description;
  final String birthday;
  final int sportsId;
  final int sessionCount;
  final int noticeCount;
  final int memberCount;

  Crew.fromJSON(Map<String, dynamic> jsonMap) :
        id = jsonMap['id'],
        name = jsonMap['name'],
        catchPhrase = jsonMap['catchPhrase'],
        contact = jsonMap['contact'],
        logoImageUrl = jsonMap['logoImageUrl'],
        bgImageUrl = jsonMap['bgImageUrl'],
        description = jsonMap['description'],
        birthday = jsonMap['birthday'],
        sportsId = jsonMap['sportsId'],
        sessionCount = jsonMap['sessionCount'],
        noticeCount = jsonMap['noticeCount'],
        memberCount = jsonMap['memberCount'];
}