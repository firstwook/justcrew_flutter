class SessionMember {
  final int id;
  final int memberId;
  final String memberName;
  final String memberNickName;
  final String sessionMemberType;
  final int crewRoleId;
  final String registratedDate;
  final int isAttended;
  final String sessionOptionValue;

  SessionMember.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        memberId = jsonMap['memberId'],
        memberName = jsonMap['memberName'],
        memberNickName = jsonMap['memberNickName'],
        sessionMemberType = jsonMap['sessionMemberType'],
        crewRoleId = jsonMap['crewRoleId'],
        registratedDate = jsonMap['registratedDate'],
        isAttended = jsonMap['isAttended'],
        sessionOptionValue = jsonMap['sessionOptionValue'];
}