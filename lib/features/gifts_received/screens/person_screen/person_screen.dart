import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/assets/res/resources.dart';
import 'package:flutter_template/assets/text/text_style.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/common/widgets/app_button_widget.dart';
import 'package:flutter_template/features/common/widgets/app_iteams_list_widget.dart';
import 'package:flutter_template/features/common/widgets/choose_edit_or_delete_dialog_widget.dart';
import 'package:flutter_template/features/common/widgets/delete_dialog_widget.dart';
import 'package:flutter_template/features/common/widgets/person_bottom_sheet_widget.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_person_screen/edit_person_screen_export.dart';
import 'package:flutter_template/features/gifts_received/screens/person_screen/person_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:union_state/union_state.dart';

/// Main widget for GiftsReceivedScreen feature.
@RoutePage(
  name: AppRouteNames.personScreen,
)
class PersonScreen extends ElementaryWidget<IPersonScreenWidgetModel> {
  /// Create an instance [PersonScreen].
  const PersonScreen({
    Key? key,
    WidgetModelFactory wmFactory = personScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPersonScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            InkWell(highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: wm.closeScreen, child: SvgPicture.asset(SvgIcons.backArrow)),
            Padding(
              padding: const EdgeInsets.only(left: 36),
              child: Text('Who gave it ', style: AppTextStyle.bold19.value.copyWith(color: AppColors.white)),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _Body(wm: wm),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final IPersonScreenWidgetModel wm;

  _Body({required this.wm});

  @override
  Widget build(BuildContext context) {
    return UnionStateListenableBuilder<List<Person>>(
      unionStateListenable: wm.personsState,
      builder: (_, persons) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppItemListWidget<Person>(
                mainNames: persons.map((e) => e.firstName).toList(),
                secondText: persons.map((e) => e.comment).toList(),
                photoList: persons.map((e) => e.photo).toList(),
                values: persons,
                onTapThreeDots: (person) {
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => ChooseEditOrDeleteDialogWidget(
                      icon: SvgIcons.checkChooseDialog,
                      firstText: 'Choose',
                      editGiftsScreen: () {
                        Navigator.pop(ctx);
                        showModalBottomSheet<void>(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          backgroundColor: AppColors.darkBlue,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return EditPersonScreen(
                              loadAgain: wm.loadAgain,
                              person: person,
                            );
                          },
                        );
                      },
                      deleteGift: () {
                        Navigator.pop(ctx);
                        showDialog<void>(
                          context: context,
                          builder: (ctx) => DeleteDialogWidget(
                            deleteGift: () async {
                              await wm.deletePersonOnTap.call(person);
                            },
                          ),
                        );
                      },
                      chooseItem: () {
                        Navigator.pop(ctx);
                        wm.choosePersonOnTap(person);
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AppButtonWidget(
                  title: 'Add a person +',
                  onPressed: () {
                    showModalBottomSheet<void>(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                      backgroundColor: AppColors.darkBlue,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: SingleChildScrollView(
                            child: PersonBottomSheetWidget(
                              addOrEditPerson: wm.addPersonOnTap,
                              loadAgain: wm.loadAgain,
                              savePhoto: wm.savePhotoOnTap,
                              cleanBottomSheetForAddPersonOnTap: wm.cleanBottomSheetForAddPersonOnTap,
                              closeScreen: wm.closeScreen,
                              firstNameController: wm.firstNameController,
                              commentController: wm.commentController,
                              lastNameController: wm.lastNameController,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      loadingBuilder: (_, hotel) => const SizedBox(),
      failureBuilder: (_, exception, hotel) => const SizedBox(),
    );
  }
}
