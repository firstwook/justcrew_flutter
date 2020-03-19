class Session {
  final int id; // 세션아이디
  final int crewId; // 크루아이디
  final String status; // 상태 [open | ready | closed]
  final String name; // 세션명
  final String description; // 세션설명
  final String type; // 세션 타입 [0 : 정기 세션 | 1 : 번개 세션]
  final String date; // 세션일시
  final String gatheringPlace; // 집결장소명
  final geometryPoint gatheringGeoPoint; // 집결장소 경위도
  final String venue; // 세션진행장소
  final int maximumOccupancy; // 최대허용인원
  final String allowableType; // 허용타입 [0 : 멤버 온리 | 1: 오픈 세션]
  final String createdAt; // 생성일
  final String updatedAt; // 수정일
  final String logoImageUrl; // 크루 로고 이미지

  Session.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        crewId = jsonMap['crewId'],
        status = jsonMap['status'],
        name = jsonMap['name'],
        description = jsonMap['description'],
        type = jsonMap['type'],
        date = jsonMap['date'],
        gatheringPlace = jsonMap['gatheringPlace'],
        gatheringGeoPoint = jsonMap['gatheringGeoPoint'],
        venue = jsonMap['venue'],
        maximumOccupancy = jsonMap['maximumOccupancy'],
        allowableType = jsonMap['allowableType'],
        createdAt = jsonMap['createdAt'],
        updatedAt = jsonMap['updatedAt'],
        logoImageUrl = jsonMap['logoImageUrl'];
}

class geometryPoint {

  final double lat;
  final double long;

  geometryPoint(this.lat, this.long);

}