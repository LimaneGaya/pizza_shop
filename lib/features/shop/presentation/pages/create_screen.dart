import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/widgets/my_text_field.dart';
import 'package:food_delivery/features/shop/domain/entities/pizza.dart';
import 'package:food_delivery/features/shop/presentation/widgets/macro.dart';
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
  String imageUrl = '';
  PizzaSpicy pizzaSpicy = PizzaSpicy.bland;
  late bool isVeg = widget.pizza?.isVeg ?? false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* return BlocListener<ShopBloc, CreatePizzaState>(
      listener: (context, state) {
        if(state is CreatePizzaSuccess) {
					setState(() {
					  creationRequired = false;
            context.go('/');
					});
          context.go('/');
				} else if(state is CreatePizzaLoading) {
					setState(() {
					  creationRequired = true;
					});
				} 
      },
      child: Scaffold( */
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  if (image != null) setState(() => imageUrl = image.path);
                },
                child: imageUrl.startsWith(('http'))
                    ? Container(
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover)))
                    : Ink(
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:  Theme.of(context).colorScheme.primaryContainer,
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
                          width: 400,
                          child: MyTextField(
                              controller: nameController,
                              hintText: 'Name',
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                }
                                return null;
                              })),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: 400,
                          child: MyTextField(
                              controller: descriptionController,
                              hintText: 'Description',
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                }
                                return null;
                              })),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        child: Row(
                          children: [
                            Expanded(
                                child: MyTextField(
                                    controller: priceController,
                                    hintText: 'Price',
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    errorMsg: _errorMsg,
                                    validator: (val) {
                                      if (val!.isEmpty) {
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
                                      if (val!.isEmpty) {
                                        return 'Please fill in this field';
                                      }
                                      return null;
                                    })),
                          ],
                        ),
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
                                  onTap: () => setState(() => pizzaSpicy = e),
                                  child: Ink(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          strokeAlign: BorderSide.strokeAlignCenter,
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
                      SizedBox(
                        width: 400,
                        child: Row(
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
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 400,
                height: 40,
                child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        /* setState(() {
                                  pizza!.name = nameController.text;
                                  pizza!.description = descriptionController.text;
                                  pizza!.price = int.parse(priceController.text);
                                  pizza!.discount = int.parse(discountController.text);
                                  pizza!.macros.calories = int.parse(calorieController.text);
                                  pizza!.macros.proteins = int.parse(proteinController.text);
                                  pizza!.macros.fat = int.parse(fatController.text);
                                  pizza!.macros.carbs = int.parse(carbsController.text);
                                });
                                print(pizza.toString());
                                context.read<ShopBloc>().add(CreatePizza(pizza)); */
                      }
                    },
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60))),
                    child:  Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(
                        'Create Pizza',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:  Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
