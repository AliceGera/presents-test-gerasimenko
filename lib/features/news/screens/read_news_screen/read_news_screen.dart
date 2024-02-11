import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/news/screens/read_news_screen/read_news_screen_widget_model.dart';

/// News screen.
@RoutePage(
  name: AppRouteNames.readNewsScreen,
)
class ReadNewsScreen extends ElementaryWidget<IReadNewsScreenWidgetModel> {
  /// Create an instance [ReadNewsScreen].
  const ReadNewsScreen({
    Key? key,
    WidgetModelFactory wmFactory = readNewsScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IReadNewsScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            InkWell(highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.backArrow)),
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: Text(
                'News',
                style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.darkBlue,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Art of Gift Giving: How to Choose the Perfect Present',
                style: AppTextStyle.bold19.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 12),
              Text(
                'Gift-giving is a timeless tradition that has been practised for centuries. It can be challenging, but with the right tips and tricks, you can easily choose the perfect present for any occasion.',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Why Gift-Giving Matters',
                  style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white),
                ),
              ),
              Text(
                'Gift-giving has been a part of human history for thousands of years. Ancient civilizations exchanged gifts as a symbol of respect and '
                'gratitude. Today, gift-giving is more than just exchanging presents; it is an opportunity to express your feelings and emotions. A '
                'thoughtful gift can convey your love, appreciation, and gratitude towards the recipient. It can also help strengthen relationships and '
                'create lasting memories.Gift-giving is particularly important during the holiday season. In fact, many people consider gift-giving to be '
                'the highlight of the holiday season. It is a time when people come together to share their love and appreciation for one another. In addition, gift-giving can help relieve stress and anxiety. It feels good to give a gift that is appreciated and loved.',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const Image(
                    image: AssetImage('assets/images/presents.png'),
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Text(
                'Understanding the Recipient',
                style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'One of the most important aspects of gift-giving is understanding the recipient. Consider their personality, interests, and hobbies. Think about what they might need or what they have been talking about lately. By understanding the recipient, you can choose a gift that is meaningful and personalized.It is important to consider the recipient is personality when selecting a gift. If they are outgoing and enjoy socializing, consider giving '
                'them an experience gift such as concert tickets or a gift certificate to their favourite restaurant. If they are more introverted, consider a '
                'gift that allows them to relax and unwind, such as a spa day or a good book.When choosing a gift, consider the recipients interests and '
                'hobbies. Consider a fitness tracker or a gym membership if they are into fitness. If they love cooking, consider a cooking class or a '
                'gourmet food basket.It is also important to consider the occasion when selecting a gift. A birthday gift may be different from an anniversary gift, for example. Takethe time to think about the recipient and the occasion to ensure that you choose the perfect gift.',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const Image(
                    image: AssetImage('assets/images/children.png'),
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Text(
                'Choosing the Right Type of Gift',
                style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Once you have an understanding of the recipient, it is time to choose the right type of gift. There are several types of gifts, including '
                'practical gifts, sentimental gifts, and experiential gifts. Consider the occasion and the recipients preferences when choosing the type of gift.Practical gifts are gifts that the recipient can use in their daily life. They are often functional and can make the recipients life easier. Some examples of practical gifts include a new phone case, a new laptop, or a kitchen gadget.Sentimental gifts are gifts that have a special meaning or memory attached to them. These gifts can be significant for special occasions such as weddings or anniversaries. Some examples of sentimental gifts include a photo album or a customized piece of jewellery.Experiential gifts are gifts that provide an experience or activity for the recipient. They can be particularly meaningful for individuals whovalue experiences over material possessions. Some examples of experiential gifts include concert tickets, a cooking class, or a hot air balloon ride.',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 12),
              Text(
                'Finding the Perfect Gift',
                style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Once you have an understanding of the recipient, it is time to choose the right type of gift. There are several types of gifts, including '
                'practical gifts, sentimental gifts, and experiential gifts. Consider the occasion and the recipients preferences when choosing the type of gift.Practical gifts are gifts that the recipient can use in their daily life. They are often functional and can make the recipients life easier. Some examples of practical gifts include a new phone case, a new laptop, or a kitchen gadget.Sentimental gifts are gifts that have a special meaning or memory attached to them. These gifts can be significant for special occasions such as weddings or anniversaries. Some examples of sentimental gifts include a photo album or a customized piece of jewellery.Experiential gifts are gifts that provide an experience or activity for the recipient. They can be particularly meaningful for individuals whovalue experiences over material possessions. Some examples of experiential gifts include concert tickets, a cooking class, or a hot air balloon ride.',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 28),
              Text(
                'Wrapping and Presentation',
                style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'inally, dont forget about the wrapping and presentation of the gift. A beautifully wrapped gift can make a big difference and show therecipient that you care. Consider using personalized wrapping paper or adding a handwritten note to make the gift even more special.',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 16),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const Image(
                    image: AssetImage('assets/images/present.png'),
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'The Dos and Donts of Gift-giving',
                style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'While gift-giving can be a fun and rewarding experience, there are some dos and donts to keep in mind. Here are some guidelines to followwhen '
                'choosing and giving gifts:',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 28),
              Text(
                'Dos:',
                style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Do consider the recipients personality, interests, and hobbies \nDo consider the occasion and the recipients preferences when selecting a gift\nDo think outside the box and consider unique and unexpected gifts\nDo consider personalized or handmade gifts for an extra special touch\nDo consider the presentation of the gift, including wrapping and packaging',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 12),
              Text(
                'Donts:',
                style: AppTextStyle.semiBold17.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Dont give generic or thoughtless gifts\nDont overspend on a gift to impress the recipient\nDont give a gift that is inappropriate or offensive\nDont give a gift that is too personal or intimate for the relationship\nDont give a gift that is a burden or inconvenience for the recipient',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 12),
              Text(
                'Gift-giving is a meaningful and important tradition that can help strengthen relationships and create lasting memories. By understanding the recipient, choosing the right type of gift, and putting thought and effort into the presentation, you can find the perfect gift for any occasion. Remember to keep in mind the dos and donts of gift-giving and dont be afraid to think outside the box. With these tips and tricks, youll be a gift-giving pro in no time!',
                style: AppTextStyle.regular16.value.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
    // return Column();
  }
}
