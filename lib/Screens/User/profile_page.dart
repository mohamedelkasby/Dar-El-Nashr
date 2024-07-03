import 'package:dar_nashr_gameat_el_malek_soad/liberary.dart';

class ProfilePage extends StatelessWidget {
  final UsersAccount userData;

  const ProfilePage({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    int? accountIndex;
    // void acountIndex() {
    for (var i = 0; i < users.length; i++) {
      if (userData.eMail == users[i].eMail) {
        accountIndex = i;
        break;
      } else {
        accountIndex = null;
      }
    }
    // }

    return Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Stack(
                              children: [
                                // AppCubit.get(context).imageFile != null
                                //     ? Image.file(
                                //         AppCubit.get(context).imageFile!,
                                //         fit: BoxFit.cover,
                                //       )
                                //     :
                                Image.asset(
                                  userData.profileImg == null
                                      ? "assets/img/profilePicture.jpg"
                                      : userData.profileImg!,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                  child: InkWell(
                                    onTap: () {
                                      AppCubit.get(context)
                                          .pickerImage(userIndex: accountIndex);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      color: AppCubit.get(context).themeMode ==
                                              ThemeMode.light
                                          ? backgroundColor.withOpacity(.9)
                                          : secondryColorDark.withOpacity(.9),
                                      child: Center(
                                        child: Text(
                                          "Change Image",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child:
                        // AppCubit.get(context).imageFile != null
                        //     ? Image.file(
                        //         AppCubit.get(context).imageFile!,
                        //         fit: BoxFit.cover,
                        //       )
                        //     :
                        Image.asset(
                      userData.profileImg == null
                          ? "assets/img/profilePicture.jpg"
                          : userData.profileImg!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(userData.userName),
          shadowColor: Colors.grey,
        ),
        body: Column(
          children: [
            ListTile(
              onTap: () {
                // for (var element in users) {
                //   print(element.userName);
                //   print(element.profileImg);
                //   print("...........");
                // }
                // print(userData.profileImg);
              },
              subtitleTextStyle: TextStyle(color: Colors.grey),
              leading: Icon(Icons.key),
              title: Text("Account"),
              subtitle: Text(
                userData.eMail,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            ListTile(
              subtitleTextStyle: TextStyle(color: Colors.grey),
              leading: Icon(Icons.language),
              title: Text("App Language"),
              subtitle: Text(
                AppCubit.get(context).lang == "en" ? "English" : "عربى",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ));
  }
}
