import 'package:geolocation/screens/Quotation/Add%20Quotation/add_quotation_screen.dart';
import 'package:geolocation/screens/Quotation/Items/items_screen.dart';
import 'package:geolocation/screens/Quotation/List%20Quotation/list_quotation_view.dart';
import 'package:geolocation/screens/attendence_screen/attendence_view.dart';
import 'package:geolocation/screens/change_password/change_password_screen.dart';
import 'package:geolocation/screens/customer_screen/Update_Customer/update_customer_screen.dart';
import 'package:geolocation/screens/customer_screen/add_customer/add_customer_view.dart';
import 'package:geolocation/screens/customer_screen/customer_list/customer_list_screen.dart';
import 'package:geolocation/screens/expense_screen/add_expense/add_expense_view.dart';
import 'package:geolocation/screens/expense_screen/list_expense/list_expense_view.dart';
import 'package:geolocation/screens/geolocation/geolocation_view.dart';
import 'package:geolocation/screens/holiday_screen/holiday_view.dart';
import 'package:geolocation/screens/home_screen/home_page.dart';
import 'package:geolocation/screens/lead_screen/add_lead_screen/add_lead_screen.dart';
import 'package:geolocation/screens/lead_screen/update_screen/update_screen.dart';
import 'package:geolocation/screens/leave_screen/add_leave/add_leave_view.dart';
import 'package:geolocation/screens/leave_screen/list_leave/list_leave_view.dart';
import 'package:geolocation/screens/login/login_view.dart';
import 'package:geolocation/screens/profile_screen/profile_screen.dart';
import 'package:geolocation/screens/sales_invoice/add_sales_invoice/add_invoice_screen.dart';
import 'package:geolocation/screens/sales_invoice/items/add_items_screen.dart';
import 'package:geolocation/screens/sales_invoice/list_sales_invoice/list_sales_invoice_screen.dart';
import 'package:geolocation/screens/sales_order/add_sales_order/add_order_screen.dart';
import 'package:geolocation/screens/sales_order/items/add_items_screen.dart';
import 'package:geolocation/screens/sales_order/list_sales_order/list_sales_order_screen.dart';
import 'package:geolocation/screens/splash_screen/splash_screen.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'screens/lead_screen/lead_list/lead_screen.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),

    MaterialRoute(page: HomePage),
    MaterialRoute(page: LoginViewScreen),
    MaterialRoute(page: Geolocation),
    MaterialRoute(page: ListOrderScreen),
    MaterialRoute(page: AddOrderScreen),
    MaterialRoute(page: ItemScreen),
    MaterialRoute(page: LeadListScreen),
    MaterialRoute(page: AddLeadScreen),
    MaterialRoute(page: UpdateLeadScreen),
    MaterialRoute(page: AddQuotationView),
    MaterialRoute(page: ListQuotationScreen),
    MaterialRoute(page: QuotationItemScreen),
    MaterialRoute(page: HolidayScreen),
    MaterialRoute(page: AttendanceScreen),
    MaterialRoute(page: ExpenseScreen),
    MaterialRoute(page: AddExpenseScreen),
    MaterialRoute(page: ListLeaveScreen),
    MaterialRoute(page: AddLeaveScreen),
    MaterialRoute(page: ProfileScreen),
    MaterialRoute(page: ChangePasswordScreen),
    MaterialRoute(page: AddInvoiceScreen),
    MaterialRoute(page: InvoiceItemScreen),
    MaterialRoute(page: ListInvoiceScreen),
    MaterialRoute(page: CustomerList),
    MaterialRoute(page: AddCustomer),
    MaterialRoute(page: UpdateCustomer)
    // DetailedFarmerScreen
  ],
  dependencies: [
    Singleton(classType: NavigationService),
  ],
)
class App {
  //empty class, will be filled after code generation
}
// flutter pub run build_runner build --delete-conflicting-outputs
