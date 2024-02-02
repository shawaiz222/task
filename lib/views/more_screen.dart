import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoder_app/data/models/auth_models.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/empty_app_bar.dart';

final List<Map<String, dynamic>> sidebarItems = [
  {
    'route': '/reports',
    'icon': CustomIcons.resportsIcon,
    'title': 'Reports',
  },
  {
    'icon': CustomIcons.itemsIcon,
    'title': 'Items',
    'subItems': [
      {
        'route': '/products',
        'title': 'Products',
        'icon': CustomIcons.productsIcon,
      },
      {
        'route': '/categories',
        'title': 'Categories',
        'icon': CustomIcons.categoriesIcon,
      },
      {
        'route': '/attributes',
        'title': 'Attributes',
        'icon': CustomIcons.attributesIcon,
      },
      {
        'route': '/units',
        'title': 'Units',
        'icon': CustomIcons.unitsIcon,
      }
    ]
  },
  {
    'route': '/expenses',
    'icon': CustomIcons.expensesIcon,
    'title': 'Expenses',
  },
  {
    'route': '/customers',
    'icon': CustomIcons.usersIcon,
    'title': 'Customers',
  },
  {
    'icon': CustomIcons.usersIcon,
    'title': 'Team',
    'subItems': [
      {
        'route': '/members',
        'title': 'Members',
        'icon': CustomIcons.usersIcon,
      },
      {
        'route': '/roles',
        'title': 'Roles',
        'icon': CustomIcons.rolesIcon,
      },
    ]
  },
  {
    'route': '/settings',
    'icon': CustomIcons.settingsIcon,
    'title': 'Settings',
  },
  {
    'route': '/logs',
    'icon': CustomIcons.logsIcon,
    'title': 'Logs',
  },
  {
    'route': '/logout',
    'icon': CustomIcons.logoutIcon,
    'title': 'Logout',
  },
];

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final box = GetStorage();
  late UserModel user;
  @override
  void initState() {
    super.initState();
    user = box.read('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: primaryColor.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${user.name}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey.shade300,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.company['name'] ?? '',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sidebarItems.length,
              itemBuilder: (context, index) {
                return MenuItem(
                  title: sidebarItems[index]['title'],
                  route: sidebarItems[index]['route'],
                  icon: sidebarItems[index]['icon'],
                  subItems: sidebarItems[index]['subItems'],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
