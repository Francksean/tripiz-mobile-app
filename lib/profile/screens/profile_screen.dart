import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_sizes.dart';
import 'package:tripiz_app/profile/components/avatar_modifier.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SvgPicture.asset("assets/images/profil_head_fig.svg"),
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 15),
              padding: const EdgeInsets.symmetric(vertical: 20),
              height: 300,
              // color: AppColors.altPink,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AvatarModifier(),
                    Text(
                      "Franck DJISSOU",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizes.lowerLarge,
                      ),
                    ),
                    Text("seandjissou@gmail.com"),
                    Text("+237 675 32 18 36"),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          // color: Colors.amber,
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileItemTile(
                // route: SetProfileInfosRoute(),
                label: "Modifier les informations du profil",
                icon: Icons.newspaper_outlined,
                subLabel:
                    "Changer de numéro, de mot de passe, d’e-mail, d’avatar",
              ),
              ProfileItemTile(
                // route: NotificationsRoute(),
                label: "Notifications",
                icon: Icons.notifications_outlined,
                subLabel: "Activer ou non les notifications",
              ),
              // ProfileItemTile(
              //     route: "",
              //     label: "Suivis",
              //     icon: Icons.person_pin_outlined,
              //     subLabel: "Les farotis que vous suivez de près"),
              // ProfileItemTile(
              //   // route: PageRouteInfo(""),
              //   label: "Farotis",
              //   icon: Icons.volunteer_activism_outlined,
              //   subLabel: "Consulter et manager vos campagnes",
              // ),
              // ProfileItemTile(
              //     route: "",
              //     label: "Wallet et contibutions",
              //     icon: Icons.paid_outlined,
              //     subLabel: "Consulter votre compte et effectuer des retraits"),
              // ProfileItemTile(
              //     route: "",
              //     label: "Langues",
              //     icon: Icons.language_outlined,
              //     subLabel: "Changer la langue de l’application"),
              ProfileItemTile(
                // route: PageRouteInfo(""),
                label: "Reporting",
                icon: Icons.flag_outlined,
                subLabel: "Faites nous part de vos difficultés",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileItemTile extends StatelessWidget {
  const ProfileItemTile({
    required this.label,
    required this.icon,
    required this.subLabel,
    // required this.route,
    super.key,
  });

  final IconData icon;
  final String label;
  final String subLabel;
  // final PageRouteInfo route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AutoRouter.of(context).push(route);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: FontSizes.lowerLarge,
                  ),
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: 280,
                  child: Text(
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    subLabel,
                    style: TextStyle(color: AppColors.black, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
