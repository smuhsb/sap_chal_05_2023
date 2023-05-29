CLASS zcl_smuhsb_w3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF mty_dev_adv,
        name TYPE string,
        rating TYPE i,
      END OF mty_dev_adv,

      mtty_dev_adv TYPE STANDARD TABLE OF mty_dev_adv WITH EMPTY KEY,

      BEGIN OF mty_data,
        best_dev_adv TYPE mty_dev_adv,
        all_dev_adv  TYPE mtty_dev_adv,
      END OF mty_data.

    INTERFACES:
      if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS:
      _get_dev_adv
        RETURNING
          VALUE(rt_all_dev_adv) TYPE mtty_dev_adv,
      _get_best_dev
        CHANGING
          ct_all_dev_adv TYPE mtty_dev_adv
        RETURNING
          VALUE(rs_best_dev_adv) TYPE mty_dev_adv.

ENDCLASS.



CLASS zcl_smuhsb_w3 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lt_all_dev_adv) = _get_dev_adv( ).

    DATA(lt_data) = VALUE mty_data( best_dev_adv = _get_best_dev( CHANGING ct_all_dev_adv = lt_all_dev_adv )
                                    all_dev_adv  = lt_all_dev_adv ).



    DATA(lo_output) = zcl_mustache=>create( 'The best SAP Developer Advocate is {{best_dev_adv-name}}!' &&
                                            cl_abap_char_utilities=>newline &&
                                            'and the rest of the best are' &&
                                            cl_abap_char_utilities=>newline &&
                                            '{{#all_dev_adv}}' &&
                                            cl_abap_char_utilities=>newline &&
                                            '{{name}}' &&
                                            cl_abap_char_utilities=>newline &&
                                            '{{/all_dev_adv}}' ).

    out->write( lo_output->render( lt_data ) ).

  ENDMETHOD.

  METHOD _get_dev_adv.

    rt_all_dev_adv = VALUE #( ( name = 'DJ Adams' rating = 5 )
                              ( name = 'Talila Baron' rating = 5 )
                              ( name = 'Josh Bentley' rating = 5 )
                              ( name = 'Rich Heilman' rating = 5 )
                              ( name = 'Thomas Jung' rating = 5 )
                              ( name = 'Mamikee Kanneh' rating = 5 )
                              ( name = 'Antonio Maradiaga' rating = 5 )
                              ( name = 'Sheena M K' rating = 5 )
                              ( name = 'Michelle Moudy' rating = 5 )
                              ( name = 'Kevin Riedelsheimer' rating = 5 )
                              ( name = 'Vitaliy Rudnytskiy' rating = 5 )
                              ( name = 'Nico Schoenteich' rating = 5 )
                              ( name = 'Shilpa Shankar' rating = 5 )
                              ( name = 'Ian Thain' rating = 5 )
                              ( name = 'Nora von Thenen' rating = 5 )
                              ( name = 'Daniel Wroblewski' rating = 5 )
                              ( name = 'Dinah Onyino' rating = 5 ) ).

  ENDMETHOD.

  METHOD _get_best_dev.

    DATA(lv_index) = CL_ABAP_RANDOM_INT=>create(
                       seed = CONV i( sy-uzeit )
                       min  = 1
                       max  = lines( ct_all_dev_adv ) )->get_next( ).

    rs_best_dev_adv = ct_all_dev_adv[ lv_index ].
    DELETE ct_all_dev_adv INDEX lv_index.

  ENDMETHOD.

ENDCLASS.
