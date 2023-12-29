import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_tester/features/social_media_accounts/presentation/bloc/social_media_accounts_bloc.dart';
import 'package:login_tester/features/social_media_accounts/presentation/widgets/social_media_button.dart';
import 'package:login_tester/success_screen.dart';

class SocialMediaAccounts extends StatelessWidget {
  const SocialMediaAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: BlocConsumer<SocialMediaAccountsBloc, SocialMediaAccountsState>(
        listener: (context, state) {
          if (state is SocialMediaAccountsSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SuccessScreen(
                  userType: 'Social Media Account',
                  onLogOut: () async {
                    await context.read<SocialMediaAccountsBloc>().signOut();
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
              ),
            );
          } else if (state is SocialMediaAccountsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(
                  seconds: 3,
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SocialMediaAccountsInitial) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                ),
                SocialMediaButton(
                  imagePath: 'assets/google_icon.png',
                  buttonText: 'Sign in with Google',
                  onTap: () {
                    context.read<SocialMediaAccountsBloc>().add(
                          LoginWithGooglePressed(),
                        );
                  },
                ),
                SocialMediaButton(
                  imagePath: 'assets/facebook_icon.png',
                  buttonText: 'Sign in with Facebook',
                  onTap: () {
                    context.read<SocialMediaAccountsBloc>().add(
                          LoginWithFacebookPressed(),
                        );
                  },
                ),
                SocialMediaButton(
                  imagePath: 'assets/twitter_icon.webp',
                  buttonText: 'Sign in with Twitter',
                  onTap: () {
                    context.read<SocialMediaAccountsBloc>().add(
                          LoginWithTwitterPressed(),
                        );
                  },
                ),
              ],
            );
          } else if (state is SocialMediaAccountsLoading) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                ),
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
