# 학식맵스

- [APK]()
- [Backend Repository](https://github.com/cactus-y/madcamp_week3_back)

## 팀원

- 김병훈
- 유석원

## 프로젝트 및 기능 소개

각 학교의 학식메뉴를 확인 할 수 있는 앱 입니다.

### 지도 탭

|대학교 영역 표시|대학 별 식당 위치 표시| 식당 메뉴 확인 |스와이프로 다른 메뉴 보기|
|--|--|--|--|
| ![KakaoTalk_Photo_2023-07-19-15-43-55](https://github.com/cactus-y/madcamp_week3_front/assets/55349972/ec576a3f-f979-43ef-aad3-95b26835a8bd) | ![KakaoTalk_Photo_2023-07-19-15-43-48 001](https://github.com/cactus-y/madcamp_week3_front/assets/55349972/52218e2d-a881-4fdc-92b9-5ffb724c5fe7) | ![KakaoTalk_Photo_2023-07-19-15-43-48 002](https://github.com/cactus-y/madcamp_week3_front/assets/55349972/cf62cd33-a936-4407-8efd-a3b39e4cab94) | ![KakaoTalk_Photo_2023-07-19-15-43-48 003](https://github.com/cactus-y/madcamp_week3_front/assets/55349972/0f6d1b44-f330-4c34-a2c1-81d6abcc5ba7) |

- 지도 상단의 대학 탭을 클릭하면 해당 대학으로 지도가 이동합니다.
  - Google Map을 활용해 만들었습니다.
- 해당 학교의 식당들이 마커로 표시됩니다.
- 마커를 클릭하면 해당 식당의 메뉴 정보가 나옵니다.
  - 하단의 스크롤 뷰를 올리면 메뉴 정보를 볼 수 있습니다.
- 만약 메뉴가 더 있다면 밀어서 다른 메뉴를 볼 수 있습니다.
- 메뉴가 길어 다 나오지 않을 때 클릭하면 Dialog로 상세보기를 할 수 있습니다.
- 모든 메뉴 정보는 웹 크롤링 함수를 통해 가져옵니다. 
  - 처음 조회되는 식당의 경우 메뉴 정보가 DB에 저장되어 있지 않기 때문에 크롤링 함수를 불러와 DB에 저장하고 유저에게 보여줍니다. 이 때 크롤링 함수로 인해 로딩시간이 길어질 수 있습니다.

## 백로그

- 유저 로그인/회원가입 (유저의 대학을 가입할 때 받아서 앱을 구동하면 자신 학교로 지도가 이동하도록)
- 유저가 직접 대학교 주변의 맛집을 추가 하는 기능
- 맛집과 대학교 학식 별점 기능


