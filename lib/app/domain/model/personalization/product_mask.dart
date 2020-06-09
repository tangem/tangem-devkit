import 'package:tangem_sdk/model/sdk.dart';

enum Product {
  Note,
  Tag,
  IdCard,
  IdIssuer,
}

extension ProductCodes on Product {
  static const codes = {
    Product.Note: 0x01,
    Product.Tag: 0x02,
    Product.IdCard: 0x04,
    Product.IdIssuer: 0x08,
  };

  int get code => codes[this];
}

class ProductMaskBuilder {
  int productMaskValue = 0;

  add(Product product) {
    productMaskValue = productMaskValue | product.code;
  }

  ProductMaskSdk build() => ProductMaskSdk(productMaskValue);
}
