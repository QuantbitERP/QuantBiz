// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _i29;
import 'package:geolocation/model/add_invoice_model.dart' as _i32;
import 'package:geolocation/model/add_order_model.dart' as _i30;
import 'package:geolocation/model/addquotation_model.dart' as _i31;
import 'package:geolocation/screens/attendence_screen/attendence_view.dart'
    as _i16;
import 'package:geolocation/screens/change_password/change_password_screen.dart'
    as _i22;
import 'package:geolocation/screens/customer_screen/add_customer/add_customer_view.dart'
    as _i27;
import 'package:geolocation/screens/customer_screen/customer_list/customer_list_screen.dart'
    as _i26;
import 'package:geolocation/screens/customer_screen/Update_Customer/update_customer_screen.dart'
    as _i28;
import 'package:geolocation/screens/expense_screen/add_expense/add_expense_view.dart'
    as _i18;
import 'package:geolocation/screens/expense_screen/list_expense/list_expense_view.dart'
    as _i17;
import 'package:geolocation/screens/geolocation/geolocation_view.dart' as _i5;
import 'package:geolocation/screens/holiday_screen/holiday_view.dart' as _i15;
import 'package:geolocation/screens/home_screen/home_page.dart' as _i3;
import 'package:geolocation/screens/lead_screen/add_lead_screen/add_lead_screen.dart'
    as _i10;
import 'package:geolocation/screens/lead_screen/lead_list/lead_screen.dart'
    as _i9;
import 'package:geolocation/screens/lead_screen/update_screen/update_screen.dart'
    as _i11;
import 'package:geolocation/screens/leave_screen/add_leave/add_leave_view.dart'
    as _i20;
import 'package:geolocation/screens/leave_screen/list_leave/list_leave_view.dart'
    as _i19;
import 'package:geolocation/screens/login/login_view.dart' as _i4;
import 'package:geolocation/screens/profile_screen/profile_screen.dart' as _i21;
import 'package:geolocation/screens/Quotation/Add%20Quotation/add_quotation_screen.dart'
    as _i12;
import 'package:geolocation/screens/Quotation/Items/items_screen.dart' as _i14;
import 'package:geolocation/screens/Quotation/List%20Quotation/list_quotation_view.dart'
    as _i13;
import 'package:geolocation/screens/sales_invoice/add_sales_invoice/add_invoice_screen.dart'
    as _i23;
import 'package:geolocation/screens/sales_invoice/items/add_items_screen.dart'
    as _i24;
import 'package:geolocation/screens/sales_invoice/list_sales_invoice/list_sales_invoice_screen.dart'
    as _i25;
import 'package:geolocation/screens/sales_order/add_sales_order/add_order_screen.dart'
    as _i7;
import 'package:geolocation/screens/sales_order/items/add_items_screen.dart'
    as _i8;
import 'package:geolocation/screens/sales_order/list_sales_order/list_sales_order_screen.dart'
    as _i6;
import 'package:geolocation/screens/splash_screen/splash_screen.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i33;

class Routes {
  static const splashScreen = '/';

  static const homePage = '/home-page';

  static const loginViewScreen = '/login-view-screen';

  static const geolocation = '/Geolocation';

  static const listOrderScreen = '/list-order-screen';

  static const addOrderScreen = '/add-order-screen';

  static const itemScreen = '/item-screen';

  static const leadListScreen = '/lead-list-screen';

  static const addLeadScreen = '/add-lead-screen';

  static const updateLeadScreen = '/update-lead-screen';

  static const addQuotationView = '/add-quotation-view';

  static const listQuotationScreen = '/list-quotation-screen';

  static const quotationItemScreen = '/quotation-item-screen';

  static const holidayScreen = '/holiday-screen';

  static const attendanceScreen = '/attendance-screen';

  static const expenseScreen = '/expense-screen';

  static const addExpenseScreen = '/add-expense-screen';

  static const listLeaveScreen = '/list-leave-screen';

  static const addLeaveScreen = '/add-leave-screen';

  static const profileScreen = '/profile-screen';

  static const changePasswordScreen = '/change-password-screen';

  static const addInvoiceScreen = '/add-invoice-screen';

  static const invoiceItemScreen = '/invoice-item-screen';

  static const listInvoiceScreen = '/list-invoice-screen';

  static const customerList = '/customer-list';

  static const addCustomer = '/add-customer';

  static const updateCustomer = '/update-customer';

  static const all = <String>{
    splashScreen,
    homePage,
    loginViewScreen,
    geolocation,
    listOrderScreen,
    addOrderScreen,
    itemScreen,
    leadListScreen,
    addLeadScreen,
    updateLeadScreen,
    addQuotationView,
    listQuotationScreen,
    quotationItemScreen,
    holidayScreen,
    attendanceScreen,
    expenseScreen,
    addExpenseScreen,
    listLeaveScreen,
    addLeaveScreen,
    profileScreen,
    changePasswordScreen,
    addInvoiceScreen,
    invoiceItemScreen,
    listInvoiceScreen,
    customerList,
    addCustomer,
    updateCustomer,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashScreen,
      page: _i2.SplashScreen,
    ),
    _i1.RouteDef(
      Routes.homePage,
      page: _i3.HomePage,
    ),
    _i1.RouteDef(
      Routes.loginViewScreen,
      page: _i4.LoginViewScreen,
    ),
    _i1.RouteDef(
      Routes.geolocation,
      page: _i5.Geolocation,
    ),
    _i1.RouteDef(
      Routes.listOrderScreen,
      page: _i6.ListOrderScreen,
    ),
    _i1.RouteDef(
      Routes.addOrderScreen,
      page: _i7.AddOrderScreen,
    ),
    _i1.RouteDef(
      Routes.itemScreen,
      page: _i8.ItemScreen,
    ),
    _i1.RouteDef(
      Routes.leadListScreen,
      page: _i9.LeadListScreen,
    ),
    _i1.RouteDef(
      Routes.addLeadScreen,
      page: _i10.AddLeadScreen,
    ),
    _i1.RouteDef(
      Routes.updateLeadScreen,
      page: _i11.UpdateLeadScreen,
    ),
    _i1.RouteDef(
      Routes.addQuotationView,
      page: _i12.AddQuotationView,
    ),
    _i1.RouteDef(
      Routes.listQuotationScreen,
      page: _i13.ListQuotationScreen,
    ),
    _i1.RouteDef(
      Routes.quotationItemScreen,
      page: _i14.QuotationItemScreen,
    ),
    _i1.RouteDef(
      Routes.holidayScreen,
      page: _i15.HolidayScreen,
    ),
    _i1.RouteDef(
      Routes.attendanceScreen,
      page: _i16.AttendanceScreen,
    ),
    _i1.RouteDef(
      Routes.expenseScreen,
      page: _i17.ExpenseScreen,
    ),
    _i1.RouteDef(
      Routes.addExpenseScreen,
      page: _i18.AddExpenseScreen,
    ),
    _i1.RouteDef(
      Routes.listLeaveScreen,
      page: _i19.ListLeaveScreen,
    ),
    _i1.RouteDef(
      Routes.addLeaveScreen,
      page: _i20.AddLeaveScreen,
    ),
    _i1.RouteDef(
      Routes.profileScreen,
      page: _i21.ProfileScreen,
    ),
    _i1.RouteDef(
      Routes.changePasswordScreen,
      page: _i22.ChangePasswordScreen,
    ),
    _i1.RouteDef(
      Routes.addInvoiceScreen,
      page: _i23.AddInvoiceScreen,
    ),
    _i1.RouteDef(
      Routes.invoiceItemScreen,
      page: _i24.InvoiceItemScreen,
    ),
    _i1.RouteDef(
      Routes.listInvoiceScreen,
      page: _i25.ListInvoiceScreen,
    ),
    _i1.RouteDef(
      Routes.customerList,
      page: _i26.CustomerList,
    ),
    _i1.RouteDef(
      Routes.addCustomer,
      page: _i27.AddCustomer,
    ),
    _i1.RouteDef(
      Routes.updateCustomer,
      page: _i28.UpdateCustomer,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashScreen(),
        settings: data,
      );
    },
    _i3.HomePage: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.HomePage(),
        settings: data,
      );
    },
    _i4.LoginViewScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LoginViewScreen(),
        settings: data,
      );
    },
    _i5.Geolocation: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.Geolocation(),
        settings: data,
      );
    },
    _i6.ListOrderScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.ListOrderScreen(),
        settings: data,
      );
    },
    _i7.AddOrderScreen: (data) {
      final args = data.getArgs<AddOrderScreenArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.AddOrderScreen(key: args.key, orderid: args.orderid),
        settings: data,
      );
    },
    _i8.ItemScreen: (data) {
      final args = data.getArgs<ItemScreenArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.ItemScreen(
            key: args.key, warehouse: args.warehouse, items: args.items),
        settings: data,
      );
    },
    _i9.LeadListScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.LeadListScreen(),
        settings: data,
      );
    },
    _i10.AddLeadScreen: (data) {
      final args = data.getArgs<AddLeadScreenArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.AddLeadScreen(key: args.key, leadid: args.leadid),
        settings: data,
      );
    },
    _i11.UpdateLeadScreen: (data) {
      final args = data.getArgs<UpdateLeadScreenArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.UpdateLeadScreen(key: args.key, updateId: args.updateId),
        settings: data,
      );
    },
    _i12.AddQuotationView: (data) {
      final args = data.getArgs<AddQuotationViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i12.AddQuotationView(key: args.key, quotationid: args.quotationid),
        settings: data,
      );
    },
    _i13.ListQuotationScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.ListQuotationScreen(),
        settings: data,
      );
    },
    _i14.QuotationItemScreen: (data) {
      final args = data.getArgs<QuotationItemScreenArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i14.QuotationItemScreen(key: args.key, items: args.items),
        settings: data,
      );
    },
    _i15.HolidayScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.HolidayScreen(),
        settings: data,
      );
    },
    _i16.AttendanceScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.AttendanceScreen(),
        settings: data,
      );
    },
    _i17.ExpenseScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.ExpenseScreen(),
        settings: data,
      );
    },
    _i18.AddExpenseScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.AddExpenseScreen(),
        settings: data,
      );
    },
    _i19.ListLeaveScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.ListLeaveScreen(),
        settings: data,
      );
    },
    _i20.AddLeaveScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.AddLeaveScreen(),
        settings: data,
      );
    },
    _i21.ProfileScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.ProfileScreen(),
        settings: data,
      );
    },
    _i22.ChangePasswordScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i22.ChangePasswordScreen(),
        settings: data,
      );
    },
    _i23.AddInvoiceScreen: (data) {
      final args = data.getArgs<AddInvoiceScreenArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i23.AddInvoiceScreen(key: args.key, invoiceid: args.invoiceid),
        settings: data,
      );
    },
    _i24.InvoiceItemScreen: (data) {
      final args = data.getArgs<InvoiceItemScreenArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i24.InvoiceItemScreen(
            key: args.key,
            invoiceItems: args.invoiceItems,
            warehouse: args.warehouse),
        settings: data,
      );
    },
    _i25.ListInvoiceScreen: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i25.ListInvoiceScreen(),
        settings: data,
      );
    },
    _i26.CustomerList: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i26.CustomerList(),
        settings: data,
      );
    },
    _i27.AddCustomer: (data) {
      final args = data.getArgs<AddCustomerArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i27.AddCustomer(key: args.key, id: args.id),
        settings: data,
      );
    },
    _i28.UpdateCustomer: (data) {
      final args = data.getArgs<UpdateCustomerArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i28.UpdateCustomer(key: args.key, id: args.id),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class AddOrderScreenArguments {
  const AddOrderScreenArguments({
    this.key,
    required this.orderid,
  });

  final _i29.Key? key;

  final String orderid;

  @override
  String toString() {
    return '{"key": "$key", "orderid": "$orderid"}';
  }

  @override
  bool operator ==(covariant AddOrderScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.orderid == orderid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ orderid.hashCode;
  }
}

class ItemScreenArguments {
  const ItemScreenArguments({
    this.key,
    required this.warehouse,
    required this.items,
  });

  final _i29.Key? key;

  final String warehouse;

  final List<_i30.Items> items;

  @override
  String toString() {
    return '{"key": "$key", "warehouse": "$warehouse", "items": "$items"}';
  }

  @override
  bool operator ==(covariant ItemScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.warehouse == warehouse &&
        other.items == items;
  }

  @override
  int get hashCode {
    return key.hashCode ^ warehouse.hashCode ^ items.hashCode;
  }
}

class AddLeadScreenArguments {
  const AddLeadScreenArguments({
    this.key,
    required this.leadid,
  });

  final _i29.Key? key;

  final String leadid;

  @override
  String toString() {
    return '{"key": "$key", "leadid": "$leadid"}';
  }

  @override
  bool operator ==(covariant AddLeadScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.leadid == leadid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ leadid.hashCode;
  }
}

class UpdateLeadScreenArguments {
  const UpdateLeadScreenArguments({
    this.key,
    required this.updateId,
  });

  final _i29.Key? key;

  final String updateId;

  @override
  String toString() {
    return '{"key": "$key", "updateId": "$updateId"}';
  }

  @override
  bool operator ==(covariant UpdateLeadScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.updateId == updateId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ updateId.hashCode;
  }
}

class AddQuotationViewArguments {
  const AddQuotationViewArguments({
    this.key,
    required this.quotationid,
  });

  final _i29.Key? key;

  final String quotationid;

  @override
  String toString() {
    return '{"key": "$key", "quotationid": "$quotationid"}';
  }

  @override
  bool operator ==(covariant AddQuotationViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.quotationid == quotationid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ quotationid.hashCode;
  }
}

class QuotationItemScreenArguments {
  const QuotationItemScreenArguments({
    this.key,
    required this.items,
  });

  final _i29.Key? key;

  final List<_i31.Items> items;

  @override
  String toString() {
    return '{"key": "$key", "items": "$items"}';
  }

  @override
  bool operator ==(covariant QuotationItemScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.items == items;
  }

  @override
  int get hashCode {
    return key.hashCode ^ items.hashCode;
  }
}

class AddInvoiceScreenArguments {
  const AddInvoiceScreenArguments({
    this.key,
    required this.invoiceid,
  });

  final _i29.Key? key;

  final String invoiceid;

  @override
  String toString() {
    return '{"key": "$key", "invoiceid": "$invoiceid"}';
  }

  @override
  bool operator ==(covariant AddInvoiceScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.invoiceid == invoiceid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ invoiceid.hashCode;
  }
}

class InvoiceItemScreenArguments {
  const InvoiceItemScreenArguments({
    this.key,
    required this.invoiceItems,
    required this.warehouse,
  });

  final _i29.Key? key;

  final List<_i32.InvoiceItems> invoiceItems;

  final String warehouse;

  @override
  String toString() {
    return '{"key": "$key", "invoiceItems": "$invoiceItems", "warehouse": "$warehouse"}';
  }

  @override
  bool operator ==(covariant InvoiceItemScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.invoiceItems == invoiceItems &&
        other.warehouse == warehouse;
  }

  @override
  int get hashCode {
    return key.hashCode ^ invoiceItems.hashCode ^ warehouse.hashCode;
  }
}

class AddCustomerArguments {
  const AddCustomerArguments({
    this.key,
    required this.id,
  });

  final _i29.Key? key;

  final String id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }

  @override
  bool operator ==(covariant AddCustomerArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

class UpdateCustomerArguments {
  const UpdateCustomerArguments({
    this.key,
    required this.id,
  });

  final _i29.Key? key;

  final String id;

  @override
  String toString() {
    return '{"key": "$key", "id": "$id"}';
  }

  @override
  bool operator ==(covariant UpdateCustomerArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^ id.hashCode;
  }
}

extension NavigatorStateExtension on _i33.NavigationService {
  Future<dynamic> navigateToSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToGeolocation([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.geolocation,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListOrderScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listOrderScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddOrderScreen({
    _i29.Key? key,
    required String orderid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addOrderScreen,
        arguments: AddOrderScreenArguments(key: key, orderid: orderid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToItemScreen({
    _i29.Key? key,
    required String warehouse,
    required List<_i30.Items> items,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.itemScreen,
        arguments:
            ItemScreenArguments(key: key, warehouse: warehouse, items: items),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLeadListScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.leadListScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddLeadScreen({
    _i29.Key? key,
    required String leadid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addLeadScreen,
        arguments: AddLeadScreenArguments(key: key, leadid: leadid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateLeadScreen({
    _i29.Key? key,
    required String updateId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateLeadScreen,
        arguments: UpdateLeadScreenArguments(key: key, updateId: updateId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddQuotationView({
    _i29.Key? key,
    required String quotationid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addQuotationView,
        arguments:
            AddQuotationViewArguments(key: key, quotationid: quotationid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListQuotationScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listQuotationScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToQuotationItemScreen({
    _i29.Key? key,
    required List<_i31.Items> items,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.quotationItemScreen,
        arguments: QuotationItemScreenArguments(key: key, items: items),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHolidayScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.holidayScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAttendanceScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.attendanceScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpenseScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.expenseScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddExpenseScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addExpenseScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListLeaveScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listLeaveScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddLeaveScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addLeaveScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangePasswordScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.changePasswordScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddInvoiceScreen({
    _i29.Key? key,
    required String invoiceid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addInvoiceScreen,
        arguments: AddInvoiceScreenArguments(key: key, invoiceid: invoiceid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToInvoiceItemScreen({
    _i29.Key? key,
    required List<_i32.InvoiceItems> invoiceItems,
    required String warehouse,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.invoiceItemScreen,
        arguments: InvoiceItemScreenArguments(
            key: key, invoiceItems: invoiceItems, warehouse: warehouse),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListInvoiceScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.listInvoiceScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerList([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customerList,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddCustomer({
    _i29.Key? key,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addCustomer,
        arguments: AddCustomerArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpdateCustomer({
    _i29.Key? key,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.updateCustomer,
        arguments: UpdateCustomerArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomePage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homePage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginViewScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginViewScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithGeolocation([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.geolocation,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListOrderScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listOrderScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddOrderScreen({
    _i29.Key? key,
    required String orderid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addOrderScreen,
        arguments: AddOrderScreenArguments(key: key, orderid: orderid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithItemScreen({
    _i29.Key? key,
    required String warehouse,
    required List<_i30.Items> items,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.itemScreen,
        arguments:
            ItemScreenArguments(key: key, warehouse: warehouse, items: items),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLeadListScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.leadListScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddLeadScreen({
    _i29.Key? key,
    required String leadid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addLeadScreen,
        arguments: AddLeadScreenArguments(key: key, leadid: leadid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateLeadScreen({
    _i29.Key? key,
    required String updateId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateLeadScreen,
        arguments: UpdateLeadScreenArguments(key: key, updateId: updateId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddQuotationView({
    _i29.Key? key,
    required String quotationid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addQuotationView,
        arguments:
            AddQuotationViewArguments(key: key, quotationid: quotationid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListQuotationScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listQuotationScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithQuotationItemScreen({
    _i29.Key? key,
    required List<_i31.Items> items,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.quotationItemScreen,
        arguments: QuotationItemScreenArguments(key: key, items: items),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHolidayScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.holidayScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAttendanceScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.attendanceScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpenseScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.expenseScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddExpenseScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addExpenseScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListLeaveScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listLeaveScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddLeaveScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addLeaveScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangePasswordScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.changePasswordScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddInvoiceScreen({
    _i29.Key? key,
    required String invoiceid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addInvoiceScreen,
        arguments: AddInvoiceScreenArguments(key: key, invoiceid: invoiceid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithInvoiceItemScreen({
    _i29.Key? key,
    required List<_i32.InvoiceItems> invoiceItems,
    required String warehouse,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.invoiceItemScreen,
        arguments: InvoiceItemScreenArguments(
            key: key, invoiceItems: invoiceItems, warehouse: warehouse),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListInvoiceScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.listInvoiceScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomerList([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.customerList,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddCustomer({
    _i29.Key? key,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addCustomer,
        arguments: AddCustomerArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpdateCustomer({
    _i29.Key? key,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.updateCustomer,
        arguments: UpdateCustomerArguments(key: key, id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
