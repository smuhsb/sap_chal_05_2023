CLASS zcl_smuhsb_w2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA user  TYPE string.
    DATA date TYPE string.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_SMUHSB_W2 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      user  = 'Muhammed'.
*      date  = ??

    ENDIF.

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->popup_message_toast( |App Executed on { date } by { user } | ).
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-id_prev_app_stack  ) ).
    ENDCASE.

    client->set_next( VALUE #( xml_main = Z2UI5_CL_XML_VIEW=>factory(
        )->shell(
        )->page(
                title          = 'Practice 1'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = abap_true
            )->header_content(
                )->link(
                    text = 'Source_Code'
                    href = Z2UI5_CL_XML_VIEW=>hlp_get_source_code_url( app = me get = client->get( ) )
                    target = '_blank'
            )->get_parent(
            )->simple_form( title = 'Practice 1' editable = abap_true
                )->content( 'form'
                    )->title( 'Input'
                    )->label( 'User'
                    )->input( value = client->_bind( user )
                    )->label( 'Date'
                    )->date_picker( client->_bind( date )
                    )->button(
                        text  = 'post'
                        press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).

  ENDMETHOD.
ENDCLASS.
