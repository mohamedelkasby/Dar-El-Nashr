class UsersAccount {
  String? profileImg;
  final String userName;
  final String eMail;
  final double phoneNumber;
  final String passWord;

  UsersAccount({
    this.profileImg = null,
    required this.userName,
    required this.eMail,
    required this.phoneNumber,
    required this.passWord,
  });
}

UsersAccount user1 = UsersAccount(
  profileImg: null,
  userName: "mohamed",
  eMail: "mohamed23@gmail.com",
  phoneNumber: 01002344578,
  passWord: "123456789",
);
UsersAccount user2 = UsersAccount(
  profileImg: null,
  userName: "ahmed",
  eMail: "ahmed23@yahoo.com",
  phoneNumber: 01002344588,
  passWord: "123456789",
);
UsersAccount user3 = UsersAccount(
  profileImg: null,
  userName: "zain",
  eMail: "zain123@hotmail.com",
  phoneNumber: 01002344598,
  passWord: "123456789",
);

List<UsersAccount> users = [
  user1,
  user2,
  user3,
];
