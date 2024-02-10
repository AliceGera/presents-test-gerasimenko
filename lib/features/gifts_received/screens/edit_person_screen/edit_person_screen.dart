import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/app_colors.dart';
import 'package:flutter_template/features/common/domain/data/person/person_data.dart';
import 'package:flutter_template/features/common/widgets/person_bottom_sheet_widget.dart';
import 'package:flutter_template/features/gifts_received/screens/edit_person_screen/edit_person_screen_widget_model.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';

/// GiftsGiven screens.
@RoutePage(
  name: AppRouteNames.editPersonScreen,
)
class EditPersonScreen extends ElementaryWidget<IEditPersonScreenWidgetModel> {
  /// Create an instance [EditPersonScreen].
  const EditPersonScreen({
    required this.loadAgain,
    required this.person,
    Key? key,
    WidgetModelFactory wmFactory = editPersonScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final VoidCallback loadAgain;
  final Person person;

  @override
  Widget build(IEditPersonScreenWidgetModel wm) {
    return BottomSheet(
      loadAgain: loadAgain,
      wm: wm,
      initWidgetModel: () {
        wm.initBottomSheetWidgetModel(person);
      },
    );
  }
}

class BottomSheet extends StatefulWidget {
  final IEditPersonScreenWidgetModel wm;
  final VoidCallback loadAgain;
  final VoidCallback initWidgetModel;

  const BottomSheet({
    super.key,
    required this.wm,
    required this.loadAgain,
    required this.initWidgetModel,
  });

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  void initState() {
    widget.initWidgetModel.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ColoredBox(
        color: AppColors.backgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: ValueListenableBuilder<Uint8List>(
              builder: (context, photo, child) {
                return PersonBottomSheetWidget(

                  isEdit: true,
                  addOrEditPerson: widget.wm.editPerson,
                  loadAgain: widget.loadAgain,
                  savePhoto: widget.wm.savePhoto,
                  closeScreen: widget.wm.closeScreen,
                  firstNameController: widget.wm.firstNameController,
                  commentController: widget.wm.commentController,
                  lastNameController: widget.wm.lastNameController,
                  photo: photo,
                );
              },
              valueListenable: widget.wm.photoState,
            ),
          ),
        ),
      ),
    );
  }
}
