import 'package:flutter/material.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/components/custom_network_image.dart';
import 'package:casa/features/product_details/provider/product_details_provider.dart';
import 'package:provider/provider.dart';

import '../../../app/core/utils/dimensions.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../components/custom_app_bar.dart';
import '../../../components/custom_button.dart';
import '../../../components/empty_widget.dart';
import '../widgets/product_details_widget.dart';

class ProductDetails extends StatefulWidget {
  final int id;

  const ProductDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<ProductDetailsProvider>(context, listen: false).model = null;
      Provider.of<ProductDetailsProvider>(context, listen: false)
          .geDetails(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Consumer<ProductDetailsProvider>(
            builder: (context, provider, child) {
          return provider.isLoading
              ? SizedBox()
              : provider.model != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            const CustomAppBar(),
                            CustomNetworkImage.containerNewWorkImage(
                                image: provider.model?.image ?? "",
                                width: context.width,
                                fit: BoxFit.fitWidth,
                                height: 300.h,
                                radius: 0),
                          ],
                        ),
                        Expanded(
                          child: ProductDetailsWidget(
                            placeItem: provider.model!,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          child: CustomButton(
                            text: "حجز موعد",
                            svgIcon: SvgImages.arrowLeftIcon,
                            iconColor: Styles.WHITE_COLOR,
                            onTap: () {},
                          ),
                        ),
                      ],
                    )
                  : const EmptyState(
                      emptyHeight: 200,
                      imgHeight: 110,
                    );
        }),
      ),
    );
  }
}
