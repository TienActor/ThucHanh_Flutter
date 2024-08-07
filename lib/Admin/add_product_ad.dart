import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Config/api_urls.dart';
import '../data/category.dart';
import '../data/product.dart';

class AddProductScreen extends StatefulWidget {
  final String token;
  final String accountID;

  const AddProductScreen(
      {Key? key, required this.token, required this.accountID})
      : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final fetchedCategories =
          await APIRepository().getCategory(widget.accountID, widget.token);
      setState(() {
        categories = fetchedCategories;
        isLoading = false;
      });
       if (!mounted) return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading categories: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> addProduct() async {
    if (_formKey.currentState!.validate()) {
      ProductModel newProduct = ProductModel(
        id: 0,
        name: _nameController.text,
        description: _descriptionController.text,
        imageURL: _imageURLController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        categoryID: selectedCategory?.id ?? 0,
        categoryName: selectedCategory?.name ?? '',
        quantity: 1,
      );

      try {
        bool success =
            await APIRepository().addProduct(newProduct, widget.token);
            
        if (success) {
          
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Thêm sản phẩm thành công')));
          Navigator.pop(context, true); // Return true to indicate success
        } else {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text('Thêm sản phẩm thất bại')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error adding product: $e')));
        return false;
      }
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageURLController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Thêm sản phẩm mới'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Product Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên sản phẩm',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.text_fields),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên sản phẩm';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Product Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Mô tả sản phẩm',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Product Price Field
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Giá sản phẩm',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập giá sản phẩm';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Product Image URL Field
              TextFormField(
                controller: _imageURLController,
                decoration: const InputDecoration(
                  labelText: 'Hình sản phẩm',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image),
                ),
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập hình ảnh';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<CategoryModel>(
                      decoration: const InputDecoration(
                        labelText: 'Hãng',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.list_sharp),
                      ),
                      value: selectedCategory,
                      items: categories.map((category) {
                        return DropdownMenuItem<CategoryModel>(
                          value: category,
                          child: Text(category.name ?? ''),
                        );
                      }).toList(),
                      onChanged: (CategoryModel? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Vui lòng chọn hãng';
                        }
                        return null;
                      },
                    ),
              const SizedBox(height: 20),

              // Add Product Button
              ElevatedButton(
                onPressed: () async {
                  bool success = await addProduct();
                   if (!mounted) return;
                  if (success) {
                     if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Thêm sản phẩm thành công')));
                        
                    Navigator.pop(context);
                  } else {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('Thêm sản phẩm thất bại')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blue, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Thêm sản phẩm'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<CategoryModel?>(
        'selectedCategory', selectedCategory));
  }
}
