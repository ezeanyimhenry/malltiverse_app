import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import 'successful_screen.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formattedText += ' ';
      }
      formattedText += newText[i];
    }
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class CardNumberInputValidator extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (newText.length > 19) {
      newText = newText.substring(0, 19);
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('/', '');
    if (newText.length > 2) {
      newText = newText.substring(0, 2) + '/' + newText.substring(2);
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ExpiryDateInputValidator extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (newText.length > 5) {
      newText = newText.substring(0, 5);
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  bool _isValidExpiryDate(String date) {
    if (date.length != 5) return false;
    final month = int.tryParse(date.substring(0, 2));
    final year = int.tryParse(date.substring(3, 5));
    if (month == null || year == null) return false;
    if (month < 1 || month > 12) return false;
    // Optionally add more validation to check if the date is in the future
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              width: 200.0,
              child: Image.asset(
                'assets/images/arrow-left.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        title: Text(
          'Payment',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w600,
              height: 1.22,
              color: Color(0xFF2A2A2A),
            ),
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // Content area
          Positioned.fill(
            bottom: MediaQuery.of(context).padding.bottom +
                kBottomNavigationBarHeight,
            child: Consumer<CartProvider>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  color: Colors
                                      .white, // Set the background color of the container to white
                                  child: Image.asset(
                                    'assets/images/Card.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 20,
                                  child: Text(
                                    _cardNumberController.text,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  top: 155,
                                  left: 20,
                                  child: Text(
                                    'Card holder name',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 175,
                                  left: 20,
                                  child: Text(
                                    _cardHolderNameController.text.isEmpty
                                        ? 'John Doe'
                                        : _cardHolderNameController.text,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  top: 155,
                                  right: 138,
                                  child: Text(
                                    'Expiry date',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 175,
                                  right: 169,
                                  child: Text(
                                    _expiryDateController.text.isEmpty
                                        ? '03/24'
                                        : _expiryDateController.text,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Card Number',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                height: 1.22,
                                color: Color(0xFF2A2A2A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _cardNumberController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            inputFormatters: [
                              CardNumberInputFormatter(),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9 ]')),
                              LengthLimitingTextInputFormatter(19),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              hintText: '0000 0000 0000 0000',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your card number';
                              }
                              if (value.replaceAll(' ', '').length != 16) {
                                return 'Card number must be 16 digits';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Card Holder Name',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                height: 1.22,
                                color: Color(0xFF2A2A2A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _cardHolderNameController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              hintText: 'Card Holder Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the card holder name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Expiry Date',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          height: 1.22,
                                          color: Color(0xFF2A2A2A),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _expiryDateController,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      inputFormatters: [
                                        ExpiryDateInputFormatter(),
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9/]')),
                                        LengthLimitingTextInputFormatter(5),
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        hintText: 'MM/YY',
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter the expiry date';
                                        }
                                        if (!_isValidExpiryDate(value)) {
                                          return 'Invalid expiry date';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CVV',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          height: 1.22,
                                          color: Color(0xFF2A2A2A),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _cvvController,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        hintText: '123',
                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter the CVV';
                                        }
                                        if (value.length != 3) {
                                          return 'CVV must be 3 digits';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 63),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF7F7D),
                              foregroundColor: const Color(0xFF2A2A2A),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SuccessfulScreen()),
                                );
                              }
                            },
                            child: Text(
                              'Make Payment',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  height: 1.22,
                                  color: Color(0xFF2A2A2A),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const CustomBottomNavigationBar(
            selectedIndex: 2,
          )
        ],
      ),
    );
  }
}
