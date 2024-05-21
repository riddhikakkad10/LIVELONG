
class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Get Burn",
    image: "assets/images/image1.png",
    desc: "Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever",
  ),
  OnboardingContents(
    title: "Eat Well",
    image: "assets/images/image2.png",
    desc:
        "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun.",
  ),
  OnboardingContents(
    title: "Improve Sleep  Quality",
    image: "assets/images/image3.png",
    desc:
        "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning.",
  ),
];
