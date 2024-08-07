import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tien/data/voucher.dart';

class EditVoucherPage extends StatefulWidget {
  final Discount discount;

  const EditVoucherPage({Key? key, required this.discount}) : super(key: key);

  @override
  _EditVoucherPageState createState() => _EditVoucherPageState();
}

class _EditVoucherPageState extends State<EditVoucherPage> {
  late TextEditingController _codeController;
  late TextEditingController _titleController;
  late TextEditingController _minOrderController;
  late TextEditingController _discountController;
  late TextEditingController _quantityController;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.discount.code);
    _titleController = TextEditingController(text: widget.discount.title);
    _minOrderController = TextEditingController(text: widget.discount.minOrder);
    _discountController = TextEditingController(text: widget.discount.discount);
    _quantityController =
        TextEditingController(text: widget.discount.quantity.toString());
    _startDate = widget.discount.creationTime;
    _endDate = widget.discount.validity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sửa Mã Giảm Giá'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Code'),
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Tiêu đề'),
              ),
              TextFormField(
                controller: _minOrderController,
                decoration: const InputDecoration(labelText: 'Đơn tối thiểu'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _discountController,
                decoration: const InputDecoration(labelText: 'Chiết khấu (%)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Số lượng'),
                keyboardType: TextInputType.number,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: const Text('Chọn ngày bắt đầu'),
                subtitle: Text(_startDate == null
                    ? 'Chưa chọn ngày'
                    : 'Ngày bắt đầu: ${_startDate!.toIso8601String().substring(0, 10)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(context, true),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: const Text('Chọn ngày kết thúc'),
                subtitle: Text(_endDate == null
                    ? 'Chưa chọn ngày'
                    : 'Ngày kết thúc: ${_endDate!.toIso8601String().substring(0, 10)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(context, false),
                ),
              ),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text(
                  'Lưu',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text(
                  'Hủy',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isStart ? _startDate : _endDate) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _saveChanges() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allDiscounts = prefs.getStringList('discounts') ?? [];

    // Cập nhật mã giảm giá hiện tại
    int index = allDiscounts.indexWhere((discount) =>
        Discount.fromJson(jsonDecode(discount)).title == widget.discount.title);
    if (index != -1) {
      Discount updatedDiscount = Discount(
          code: _codeController.text,
          title: _titleController.text,
          minOrder: _minOrderController.text,
          discount: _discountController.text,
          quantity: int.parse(_quantityController.text),
          creationTime: _startDate!,
          validity: _endDate!);

      allDiscounts[index] = jsonEncode(updatedDiscount.toJson());
      await prefs.setStringList('discounts', allDiscounts);
      Navigator.of(context).pop(); // Đóng trang sau khi lưu
    }
  }
}
