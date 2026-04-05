import 'package:carousel_slider/carousel_controller.dart';
import 'package:clean_architecture_test/core/presentation/widgets/carousel_slider.dart';
import 'package:clean_architecture_test/core/presentation/widgets/full_screen_image.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_bloc.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:clean_architecture_test/features/products/presentation/widgets/carousel_slider_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/products_state.dart';
import '../widgets/related_by_id_list.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id});

  final String id;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final controller = CarouselSliderController();

  @override
  void initState() {
    context.read<ProductsBloc>().add(ProductFetched(widget.id));
    context.read<ProductsBloc>().add(RelatedByIdFetched(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return state.isProductLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.0,
                    children: [
                      CarouselSliderWidget(
                        itemCount: state.product?.images.length ?? 0,
                        initialPage: 0,
                        itemBuilder: (context, index, x) {
                          final image = state.product?.images[index];
                          return GestureDetector(
                            onTap: () {
                              FullScreenImage.show(context, imageUrl: image!);
                            },
                            child: CarouselSliderItem(
                              image: image,
                              current: index,
                              total: state.product?.images.length,
                            ),
                          );
                        },
                        controller: controller,
                      ),
                      Text(
                        '\$${state.product?.price}',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${state.product?.title}',
                        style: textTheme.bodyLarge,
                      ),
                      Text(
                        '${state.product?.description}',
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        '${'updatedAt'.tr()} ${DateFormat('dd MMM, yyyy', context.locale.languageCode).format(state.product?.updatedAt ?? DateTime.now())}',
                        style: textTheme.bodySmall,
                      ),
                      if (state.relatedById.isNotEmpty) ...[
                        const SizedBox(height: 32.0),
                        Text(
                          'productScreen.relatedProducts'.tr(),
                          style: textTheme.bodyLarge,
                        ),
                        RelatedByIdList(),
                      ],
                    ],
                  ),
                ),
              );
      },
    );
  }
}
