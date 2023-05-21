import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/ui/helpers/debouncer.dart';
import '../../../core/ui/helpers/loader.dart';
import '../../../core/ui/helpers/messages.dart';
import '../../../core/ui/widgets/base_header.dart';
import '../../home/widgets/product_item.dart';
import 'products_controller.dart';

class ProductsPage extends StatefulWidget {

  const ProductsPage({ super.key });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with Loader, Messages{

  final controller = Modular.get<ProductsController>();
  late final ReactionDisposer statusDisposer;
  final debouncer = Debouncer(millisecounds: 500);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      statusDisposer = reaction((_) => controller.status, (status) async {
        switch(status) {
          case ProductStateStatus.initial:
            controller.loadProducts();
            break;
          case ProductStateStatus.loading:
            showLoader();
            break;
          case ProductStateStatus.loaded:
            hideLoader();
            break;
          case ProductStateStatus.error:
          hideLoader();
           showError('Erro ao carregar produtos');
           break;
          case ProductStateStatus.addOrUpdateProduct:
          hideLoader();
          final productSelected = controller.productSelected;
          var uri = '/products/detail';
          if(productSelected != null) {
            uri += '?id=${productSelected.id}';
          }
          await Modular.to.pushNamed(uri);
          controller.loadProducts();
          break;
          default:
          await Modular.to.pushNamed('/products/detail');
          controller.loadProducts();
          break;
        }
      } );
      controller.loadProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {
       return Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: const BorderRadius.only(topRight: Radius.circular(10)),

        ),
        padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
        child: Column(
          children: [
            BaseHeader(
              title: 'ADMINISTRAR PRODUTOS', 
              buttonLabel: 'ADICIONAR PRODUTO',
              onPressed: controller.addProduct,
              onChanged: (_){
                debouncer.call(() {
                  controller.filterByName(_);
                });                
              },              
            ),
            const SizedBox(
               height: 50,
            ),
            Expanded(
              child: Observer(
                  builder: (_) {
                      return GridView.builder(
                              itemCount: controller.products.length,
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisExtent: 280,
                                mainAxisSpacing: 20,
                                maxCrossAxisExtent: 280,
                                crossAxisSpacing: 20,
                                ), 
                              itemBuilder: (context, index) {
                                return ProductItem(
                                  product: controller.products[index],
                                );
                              },
                    );
                  },
              ),
              ),
          ],
        ),
       );
  }
}