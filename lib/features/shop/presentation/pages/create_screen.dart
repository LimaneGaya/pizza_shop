import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/widgets/my_text_field.dart';
import 'package:food_delivery/features/shop/presentation/blocs/admin_bloc/admin_bloc.dart';
import 'package:food_delivery/features/shop/domain/entities/pizza.dart';
import 'package:food_delivery/features/shop/presentation/widgets/macro.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreatePizzaScreen extends StatefulWidget {
  final Pizza? pizza;
  const CreatePizzaScreen({this.pizza, super.key});

  @override
  State<CreatePizzaScreen> createState() => _CreatePizzaScreenState();
}

class _CreatePizzaScreenState extends State<CreatePizzaScreen> {
  late final nameController = TextEditingController(text: widget.pizza?.name);
  late final descriptionController =
      TextEditingController(text: widget.pizza?.description);
  late final priceController =
      TextEditingController(text: widget.pizza?.price.toString());
  late final discountController =
      TextEditingController(text: widget.pizza?.discount.toString());
  late final _formKey = GlobalKey<FormState>();
  late final calorieController =
      TextEditingController(text: widget.pizza?.macros.calories.toString());
  late final proteinController =
      TextEditingController(text: widget.pizza?.macros.proteins.toString());
  late final fatController =
      TextEditingController(text: widget.pizza?.macros.fat.toString());
  late final carbsController =
      TextEditingController(text: widget.pizza?.macros.carbs.toString());
  Uint8List? imageData;
  String imagetype = '';
  PizzaSpicy pizzaSpicy = PizzaSpicy.bland;
  late bool isVeg = widget.pizza?.isVeg ?? false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          constraints: const BoxConstraints(maxWidth: 600),
          child: BlocConsumer<AdminBloc, AdminState>(
            listener: (context, state) {
              if (state is CreatePizzaSuccess) {
                context.go('/');
              } else if (state is CreatePizzaError) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: Text(state.message),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'))
                          ],
                        ));
              }
            },
            builder: (context, state) {
              if (state is AdminLoading || state is CreatePizzaSuccess) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Create a New Pizza !',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 1000,
                        maxWidth: 1000,
                        imageQuality: 25,
                      );
                      if (image == null) return;
                      imagetype = image.mimeType ??
                          "image/${image.name.split('.').last}";
                      final imgBytes = await image.readAsBytes();
                      setState(() => imageData = imgBytes);
                    },
                    child: imageData != null || widget.pizza != null
                        ? Container(
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: imageData != null
                                        ? MemoryImage(imageData!)
                                        : NetworkImage(widget.pizza!.picture),
                                    fit: BoxFit.cover)))
                        : Ink(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.photo,
                                  size: 100,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(height: 10),
                                const Text("Add a Picture here..."),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              child: MyTextField(
                                  controller: nameController,
                                  hintText: 'Name',
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  errorMsg: _errorMsg,
                                  validator: (val) {
                                    if (val!.trim().isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  })),
                          const SizedBox(height: 10),
                          SizedBox(
                              child: MyTextField(
                                  controller: descriptionController,
                                  hintText: 'Description',
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  errorMsg: _errorMsg,
                                  validator: (val) {
                                    if (val!.trim().isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  })),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  child: MyTextField(
                                      controller: priceController,
                                      hintText: 'Price',
                                      obscureText: false,
                                      keyboardType: TextInputType.emailAddress,
                                      errorMsg: _errorMsg,
                                      validator: (val) {
                                        if (val!.trim().isEmpty) {
                                          return 'Please fill in this field';
                                        }
                                        return null;
                                      })),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: MyTextField(
                                      controller: discountController,
                                      hintText: 'Discount',
                                      suffixIcon: const Icon(
                                        CupertinoIcons.percent,
                                        color: Colors.grey,
                                      ),
                                      obscureText: false,
                                      keyboardType: TextInputType.emailAddress,
                                      errorMsg: _errorMsg,
                                      validator: (val) {
                                        if (val!.trim().isEmpty) {
                                          return 'Please fill in this field';
                                        }
                                        return null;
                                      })),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text('Is Vege :'),
                              const SizedBox(width: 10),
                              Checkbox(
                                  value: isVeg,
                                  onChanged: (value) {
                                    setState(() => isVeg = value!);
                                  })
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text('Is Spicy :'),
                              const SizedBox(width: 10),
                              Row(
                                children: PizzaSpicy.values.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () =>
                                          setState(() => pizzaSpicy = e),
                                      child: Ink(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                                width: 4,
                                                color: pizzaSpicy == e
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .surface),
                                            color: e.index == 0
                                                ? Colors.green
                                                : e.index == 1
                                                    ? Colors.yellow
                                                    : Colors.red),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text('Macros:'),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              MyMacroWidgetEdit(
                                title: "Calories",
                                value: 12,
                                icon: FontAwesomeIcons.fire,
                                controller: calorieController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyMacroWidgetEdit(
                                title: "Protein",
                                value: 12,
                                icon: FontAwesomeIcons.dumbbell,
                                controller: proteinController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyMacroWidgetEdit(
                                title: "Fat",
                                value: 12,
                                icon: FontAwesomeIcons.oilWell,
                                controller: fatController,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MyMacroWidgetEdit(
                                title: "Carbs",
                                value: 12,
                                icon: FontAwesomeIcons.breadSlice,
                                controller: carbsController,
                              ),
                            ],
                          )
                        ],
                      )),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AdminBloc>().add(
                                CreatePizza(
                                    imageData: imageData!,
                                    picture: imagetype,
                                    name: nameController.text,
                                    description: descriptionController.text,
                                    price: int.parse(priceController.text),
                                    discount:
                                        int.parse(discountController.text),
                                    isVeg: isVeg,
                                    calories: int.parse(calorieController.text),
                                    proteins: int.parse(proteinController.text),
                                    fat: int.parse(fatController.text),
                                    carbs: int.parse(carbsController.text),
                                    spicy: pizzaSpicy.index),
                              );
                        }
                      },
                      style: TextButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: Text(
                          'Create Pizza',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
