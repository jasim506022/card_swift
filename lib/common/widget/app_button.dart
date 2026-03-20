import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/app_colors.dart';
import '../style/app_text_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.bgColor,
    this.textColor,
    required this.onTap,
    this.borderColor,
    this.width,
    this.height,
  });

  final String title;
  final Color? bgColor;
  final Color? textColor;
  final VoidCallback onTap;
  final Color? borderColor;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        // Size of the button
        minimumSize: Size(width == null ? 0 : width!, height ?? 50.h),

        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
        // Colors
        backgroundColor: bgColor ?? AppColors.black,
        foregroundColor: textColor ?? AppColors.white,

        side: BorderSide(
          color: borderColor == null
              ? (bgColor ?? AppColors.black)
              : borderColor!,
          width: 2.w,
        ),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),

        textStyle: AppTextStyle.button,
      ),

      child: Text(title, textAlign: TextAlign.center),
    );
  }
}

/*



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppString.profile"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined, size: 25),
          ),
        ],
      ),
      body: Column(
        children: [
          const ProifleHeaderWidget(),
          Expanded(
            child: ListView(
              children: [
                Divider(
                  height: 10,
                  color: Theme.of(context).hintColor,
                  thickness: 2,
                ),
                _buildProfileMenuItems(context),
                _buildThemeSwitch(context),
                _buildSignOutTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dynamically build list of profile menu items
  Widget _buildProfileMenuItems(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": Icons.info_outline,
        "title": "AppString.about",
        "route": "RoutesName.editProfilePage",
      },
      {
        "icon": Icons.home_outlined,
        "title": "AppString.home",
        "route": "RoutesName.mainPage",
        "argument": 0,
      },
      {
        "icon": Icons.reorder,
        "title": "AppString.myOrder",
        "route": "RoutesName.orderSummaryPage",
      },
      {
        "icon": Icons.access_time,
        "title": "AppString.history",
        "route": "RoutesName.orderHistoryPage",
      },
      {
        "icon": Icons.search,
        "title": "AppString.search",
        "route": "RoutesName.mainPage",
        "argument": 2,
      },
    ];

    return Column(
      children: menuItems.map((item) {
        return CustomListTile(
          icon: item['icon'],
          title: item['title'],
          onTap: () async {
            /*
            NetworkUtils.executeWithInternetCheck(action: () {
              if (item['argument'] is int) {
                // Get.offAndToNamed(item['route'], arguments: item['argument']);
              } else {
                // Get.toNamed(item['route']);
              }
            });


             */

            /*
            if (!(await NetworkUtili.verifyInternetStatus())) {
              if (item['argument'] is int) {
                Get.offAndToNamed(item['route'], arguments: item['argument']);
              } else {
                Get.toNamed(item['route']);
              }
            }
*/
          },
        );
      }).toList(),
    );
  }

  // Build theme switcher widget
  Widget _buildThemeSwitch(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(
        // themeProvider.isDarkTheme ? Icons.dark_mode :
        Icons.light_mode,

        color:
            // themeProvider.isDarkTheme
            //    ? AppColors.white
            //    :
            Theme.of(context).primaryColor,
        size: 25,
      ),
      title: Text(
        "Dark",
        // themeProvider.isDarkTheme ? AppString.dark : AppString.light,
        // style: AppsTextStyle.largeBoldText,
      ),
      activeColor: Colors.white,
      onChanged: (bool value) {
        // themeProvider.updateThemeMode(value);    // = value;
      },
      value: true, //themeProvider.isDarkTheme,
    );
  }

  Widget _buildSignOutTile() {
    return CustomListTile(
      icon: Icons.exit_to_app,
      title: "Out", //AppString.signOut,
      iconColor: Colors.red,
      onTap: () async {
        /*
        NetworkUtils.executeWithInternetCheck(
          action: () {
            Get.dialog(
              CustomAlertDialog(
                icon: Icons.delete,
                title: AppString.signOut,
                content: AppString.doYouWantSignount,
                onConfirmPressed: () async => await profileController.signOut(),
              ),
            );
          },
        );


         */

        /*
        if (!(await NetworkUtili.verifyInternetStatus())) {

          Get.dialog(ShowAlertDialogWidget(
            icon: Icons.delete,
            title: AppString.signOut,
            content: AppString.doYouWantSignount,
            onYesPressed: () async => await profileController.signOut(),
          ));

        }

        */
      },
    );
  }
}

class ProifleHeaderWidget extends StatelessWidget {
  const ProifleHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            const CircleImageWidget(),
            // AppsFunction.horizontalSpacing(30),
            SizedBox(width: 18),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: _buildProfileDetails(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("data"),

        //
        // Text(
        //     AppConstant.sharedPreferences!
        //         .getString(AppString.nameSharedPreference)!,
        //     maxLines: 1,
        //     style: AppsTextStyle.titleTextStyle),
        //
        //
        // Text(
        //     AppConstant.sharedPreferences!
        //         .getString(AppString.emailSharedPreference)!,
        //     style: AppsTextStyle.subtitleTextStyle),
        Text("data One"),
        SizedBox(height: 8),

        // AppsFunction.verticalSpacing(8),
        CustomRoundActionButton(
          title: "Edit Profile", //AppString.editProfile,
          onTap: () async {
            String text = await OCRService().pickAndConvert();
            print("ছবি থেকে পাওয়া লেখা: $text");
            // এই টেক্সটটি এখন আপনি আপনার অ্যাপের স্ক্রিনে দেখাতে পারবেন

            // NetworkUtils.executeWithInternetCheck(action: () {
            //   Get.toNamed(RoutesName.editProfilePage, arguments: true);
            // });
            /*
            if (!(await NetworkUtili.verifyInternetStatus())) {
              Get.toNamed(AppRoutesName.editProfilePage, arguments: true);
            }
            */
          },
        ),
      ],
    );
  }

  // Container _buildProfileImage() {
  //   return ;
  // }
}

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 3),
      ),
      child: ClipOval(
        child: Image(
          image: NetworkImage(
            "https://scontent.fdac207-1.fna.fbcdn.net/v/t39.30808-6/634943180_943122718285707_2586458581799496460_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=100&ccb=1-7&_nc_sid=1d70fc&_nc_ohc=MrZqR47WjOsQ7kNvwHqUp3o&_nc_oc=Adk94yePfEy9Wzsf9TQi0rJxPTUrILkc9MoCiIL16fEgtpaliekhwooP4g3hcIz8Vr5dmrIXGpvl8QXJT4MuuERv&_nc_zt=23&_nc_ht=scontent.fdac207-1.fna&_nc_gid=Xb24oHB54X9eUYG2c4Wxrg&_nc_ss=8&oh=00_AfssYtuA49dp4r4wnYhHvVhgGDwvZWDgIad7yO9gunrVdg&oe=69AA3B98",
          ),
        ),

        /*
        FancyShimmerImage(
          imageUrl:

          AppConstant.sharedPreferences!.getString(
            AppString.imageSharedPreference,
          )!,
          errorWidget: const Icon(Icons.error),
        ),


             */
      ),
    );
  }
}

class CustomRoundActionButton extends StatelessWidget {
  const CustomRoundActionButton({
    super.key,
    required this.title,
    required this.onTap,
    this.horizontal,
  });

  final String title;
  final VoidCallback onTap;
  final double? horizontal;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: horizontal ?? 40, vertical: 12),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
        // style: AppsTextStyle.buttonTextStyle,
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Theme.of(context).primaryColor,
        size: 25,
      ),
      trailing: IconButton(
        onPressed: onTap,
        icon: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ),
      title: Text(
        title,

        // style: AppsTextStyle.largeBoldText
        //     .copyWith(color: iconColor ?? Theme.of(context).primaryColor)
      ),
    );
  }
}

class OCRService {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer();

  Future<String> pickAndConvert() async {
    // ১. ক্যামেরা দিয়ে ছবি তোলা
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) return "কোনো ছবি তোলা হয়নি";

    // ২. ইমেজ ফাইলটিকে ML Kit এর উপযোগী করা
    final inputImage = InputImage.fromFilePath(image.path);

    // ৩. টেক্সট এক্সট্রাক্ট করা
    final RecognizedText recognizedText = await _textRecognizer.processImage(
      inputImage,
    );

    // ৪. সব টেক্সট একসাথে করা
    String resultText = recognizedText.text;

    // ব্যবহারের পর মেমোরি খালি করা
    // _textRecognizer.close();

    return resultText;
  }
}

 */
