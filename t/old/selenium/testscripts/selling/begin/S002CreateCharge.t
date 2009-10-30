if(!defined $sel) {
  require "t/selenium/AllTests.t";
  init_server("singlefileonly",$0);
  exit(0);
}
diag("Create charge");
SKIP: {
  start_login();
  
  $sel->click_ok("link=Auftrag erfassen");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->select_frame_ok("main_window");
  $sel->select_ok("cp_id", "label=Grosshaupt (Verkauf)");
  $sel->type_ok("shippingpoint", "Braunschweig");
  $sel->type_ok("shipvia", "LKW");
  $sel->type_ok("transaction_description", "beta");
  $sel->click_ok("delivered");
  $sel->type_ok("ordnumber", "1");
  $sel->type_ok("quonumber", "1");
  $sel->type_ok("cusordnumber", "97862");
  $sel->select_ok("globalproject_id", "label=1001");
  $sel->type_ok("partnumber_1", "1");
  $sel->click_ok("update_button");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->click_ok("action");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->type_ok("ship_1", "20");
  $sel->type_ok("qty_1", "20");
  $sel->select_ok("sellprice_pg_1", "label=SeleniumTestPreisgruppe1");
  $sel->click_ok("update_button");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->select_ok("payment_id", "label=Schnellzahler/Skonto");
  $sel->click_ok("update_button");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->click_ok("document.oe.action[6]");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->select_ok("customer", "label=TestFrau3");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->type_ok("shippingpoint", "G�ttingen");
  $sel->type_ok("shipvia", "PKW");
  $sel->type_ok("transaction_description", "teta");
  $sel->type_ok("ordnumber", "2");
  $sel->type_ok("quonumber", "2");
  $sel->type_ok("cusordnumber", "23453666");
  $sel->type_ok("partnumber_1", "911");
  $sel->type_ok("ship_1", "5");
  $sel->type_ok("qty_1", "5");
  $sel->click_ok("update_button");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->click_ok("action");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->type_ok("description", "Handykarten D2");
  $sel->select_ok("partsgroup", "label=TestSeleniumWarengruppe3");
  $sel->type_ok("listprice", "10,00");
  $sel->type_ok("sellprice", "20,00");
  $sel->type_ok("lastcost", "5,00");
  $sel->select_ok("price_factor_id", "label=pro 10");
  $sel->select_ok("unit", "label=Stck");
  $sel->type_ok("bin", "911");
  $sel->click_ok("not_discountable");
  $sel->click_ok("shop");
  $sel->click_ok("action");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->click_ok("document.ic.action[1]");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->click_ok("document.oe.action[6]");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->select_ok("customer", "label=TestMann2");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->type_ok("partnumber_1", "991");
  $sel->type_ok("ship_1", "10");
  $sel->type_ok("qty_1", "10");
  $sel->click_ok("update_button");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->select_ok("price_factor_id_1", "label=pro 10");
  $sel->click_ok("update_button");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->type_ok("sellprice_1", "1000");
  $sel->click_ok("update_button");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
  $sel->click_ok("document.oe.action[6]");
  $sel->wait_for_page_to_load_ok($lxtest->{timeout});
};
1;