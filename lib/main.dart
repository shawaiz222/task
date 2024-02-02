import 'package:flutter/material.dart';
import 'package:invoder_app/data/private_route.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'utils/colors.dart';
import 'utils/translations.dart';
import 'package:get_storage/get_storage.dart';

// screens
import 'views/home_screen.dart';
import 'views/transactions_screen.dart';
import 'views/sales_screen.dart';
import 'views/more_screen.dart';
import 'views/expense/expenses_screen.dart';
import 'views/expense/add_expense.dart';
import 'views/customer/customers_screen.dart';
import 'views/customer/add_customer.dart';
import 'views/team/add_role.dart';
import 'views/team/roles_screen.dart';
import 'views/team/add_member.dart';
import 'views/team/members_screen.dart';
// item screens
import 'views/item/products_screen.dart';
import 'views/item/categories_screen.dart';
import 'views/item/add_product.dart';
import 'views/item/add_category.dart';
import 'views/item/attributes_screen.dart';
import 'views/item/add_attribute.dart';
import 'views/item/units_screen.dart';
import 'views/item/add_unit.dart';
// auth screens
import 'views/auth/start_screen.dart';
import 'views/auth/welcome_auth.dart';
import 'views/auth/signup_screen.dart';
import 'views/auth/business_detail_screen.dart';
import 'views/auth/login_screen.dart';
import 'views/auth/forgot_password_screen.dart';
import 'views/auth/authenticate_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  // error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) {
      // In production mode, just show a dialog.

      // show error dialog
      // await reportError(details);
    } else {
      // In development mode, simply print to console.
      // await reportError(details);
    }
  };

  runApp(InvoderApp());
}

class InvoderApp extends StatelessWidget {
  final box = GetStorage();
  InvoderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Invoder',
      theme: ThemeData(
        primarySwatch: primaryColor,
        colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor, background: Colors.white),
        brightness: Brightness.light,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor.shade900,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          displayLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          displaySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          labelSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          labelMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor.shade900,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      translations: Messages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: box.read('new_user') == false
          ? box.read('token') != null
              ? '/authenticate'
              : '/login'
          : '/start',
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '404',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: primaryColor.shade900,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  'Page not found',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: primaryColor.shade900,
                      ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  child: Text(
                    'Go to home',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          middlewares: [PrivateRouteMiddleware()],
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/start',
          page: () => const StartScreen(),
        ),
        GetPage(
          name: '/welcome',
          page: () => const WelcomeAuthScreen(),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignupScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/business-detail',
          page: () => const BusinessDetailScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/forgot-password',
          page: () => const ForgotPasswordScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/authenticate',
          page: () => const AuthenticateScreen(),
        ),
        GetPage(
          name: '/transactions',
          page: () => const TransactionsScreen(),
          middlewares: [PrivateRouteMiddleware()],
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/sales',
          page: () => const SalesScreen(),
          middlewares: [PrivateRouteMiddleware()],
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/more',
          page: () => const MoreScreen(),
          middlewares: [PrivateRouteMiddleware()],
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/products',
          page: () => const ProductsScreen(),
          middlewares: [PrivateRouteMiddleware()],
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/categories',
          page: () => const CategoriesScreen(),
          middlewares: [PrivateRouteMiddleware()],
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/add-product',
          page: () => const AddProductScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/add-category',
          page: () => const AddCategoryScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/attributes',
          page: () => const AttributesScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/add-attribute',
          page: () => const AddAttributeScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/units',
          page: () => const UnitsScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/add-unit',
          page: () => const AddUnitScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/expenses',
          page: () => const ExpensesScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/add-expense',
          page: () => const AddExpenseScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/customers',
          page: () => const CustomersScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/add-customer',
          page: () => const AddCustomerScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/roles',
          page: () => const RolesScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/add-role',
          page: () => const AddRoleScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/members',
          page: () => const MembersScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
        GetPage(
          name: '/add-member',
          page: () => const AddMemberScreen(),
          middlewares: [PrivateRouteMiddleware()],
        ),
      ],
    );
  }
}
