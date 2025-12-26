import 'package:flutter/material.dart';
import 'package:pricehup/core/utils/size_config.dart';

class ProductItemCard extends StatefulWidget {
  final String name;
  final String code;
  final String? direction;
  final double price;
  final int minQty;
  final Function(int) onQuantityChanged;

  const ProductItemCard({
    super.key,
    required this.name,
    required this.code,
    required this.direction,
    required this.price,
    required this.minQty,
    required this.onQuantityChanged,
  });

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  int _quantity = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = _quantity.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateQuantity(int newQuantity) {
    if (newQuantity < 0) return;

    // Logic:
    // If minQty > 0:
    //   - 0 is allowed (user wants none).
    //   - If newQuantity > 0 and newQuantity < minQty, force to minQty.
    // However, for direct text input, we might want to allow typing "1" then "2" to make "12".
    // So enforcing minQty strictly on every keystroke is bad UX.
    // But for +/- buttons, we should enforce it.

    // For this method, we'll assume it's called by buttons or final submission.
    // But since it's also called by onChanged, we need to be careful.

    // Let's handle button logic in button callbacks, and validation in onChanged or on submit.
    // Actually, the requirement says: "if minQty is 5, cannot write 4".
    // So if they type 4, maybe we shouldn't allow it? Or show error?
    // "cannot write 4" -> implies strict validation.

    // For simplicity and best UX:
    // Buttons will jump: 0 -> minQty -> minQty+1 ...
    // Text input: if value > 0 and value < minQty, maybe auto-correct on focus loss?
    // For now, let's just update state. The parent handles the cart.

    setState(() {
      _quantity = newQuantity;
      _controller.text = _quantity.toString();
    });
    widget.onQuantityChanged(_quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // 1. Direction (Flex 2)
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(1)),
                child: Text(
                  widget.direction ?? '',
                  style: TextStyle(
                    fontSize: SizeConfig.sp(7),
                    color: widget.direction == 'L'
                        ? Colors.blue
                        : widget.direction == 'R'
                        ? Colors.red
                        : Colors.grey[800],
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Vertical Divider
            Container(width: 1, color: Colors.grey[300]),

            // 2. Item Details (Flex 4)
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.w(2),
                  vertical: SizeConfig.h(1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: SizeConfig.sp(5),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                        color: Colors.black87,
                      ),
                      // maxLines: 1, // Removed to allow wrapping
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // Vertical Divider
            Container(width: 1, color: Colors.grey[300]),

            // 3. Price (Flex 2)
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.price.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: SizeConfig.sp(7),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    if (_quantity > 0)
                      Text(
                        'الإجمالي: ${(_quantity * widget.price).toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: SizeConfig.sp(5),
                          color: Colors.green[700],
                          fontFamily: 'Tajawal',
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),

            // Vertical Divider
            Container(width: 1, color: Colors.grey[300]),

            // 4. Quantity (Flex 2)
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.w(2),
                  vertical: SizeConfig.h(1),
                ),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.sp(8),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  onChanged: (value) {
                    final newQty = int.tryParse(value) ?? 0;
                    if (value.isEmpty) {
                      setState(() {
                        _quantity = 0;
                      });
                      widget.onQuantityChanged(0);
                      return;
                    }
                    setState(() {
                      _quantity = newQty;
                    });
                    widget.onQuantityChanged(newQty);
                  },
                  onSubmitted: (value) {
                    final newQty = int.tryParse(value) ?? 0;
                    if (newQty > 0 && newQty < widget.minQty) {
                      _updateQuantity(widget.minQty);
                    } else {
                      _updateQuantity(newQty);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
